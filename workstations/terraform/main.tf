# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

// import random string
resource "random_string" "image_tag" {
  length  = 16
  special = false
}

locals {
  //  generate a 16 digit hexadecimal string 
  docker_image_tag     = substr(md5(random_string.image_tag.result), 0, 16)
  frontend_bucket_name = "${var.project_id}-cymbal-frontend"
  frontend_static_ip   = "${var.project_id}-cymbal-frontend-ip"
  inventory_image_url  =  "us-central1-docker.pkg.dev/${var.project_id}/cymbal-superstore/inventory-api:${local.docker_image_tag}"
}

// -------------  ENABLE APIS -----------------------------------------------------------------
resource "google_project_service" "cloudbuild" {
  project                    = var.project_id
  service                    = "cloudbuild.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}
resource "google_project_service" "storage" {
  project                    = var.project_id
  service                    = "storage.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}
resource "google_project_service" "run" {
  project                    = var.project_id
  service                    = "run.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}
resource "google_project_service" "firestore" {
  project                    = var.project_id
  service                    = "firestore.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}

resource "google_project_service" "spanner" {
  project                    = var.project_id
  service                    = "spanner.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}

# // ------------- ARTIFACT REGISTRY ---------------------------------------
// https://cloud.google.com/artifact-registry/docs/repositories/create-repos#docker_1 
resource "google_artifact_registry_repository" "cymbal-superstore-artifact-repo-docker" {
  location      = "us-central1"
  repository_id = "cymbal superstore"
  description   = "docker image repository"
  format        = "DOCKER"
}

# // -------------  FIRESTORE - NATIVE MODE -----------------------------------
resource "google_firestore_database" "database" {
  project     = var.project_id
  name        = "(default)"
  location_id = "nam5"
  type        = "FIRESTORE_NATIVE"
  depends_on  = [google_project_service.firestore]
  // do not try to delete; you can't. 
  lifecycle {
    prevent_destroy = true
  }
}

# // -------------  CLOUD STORAGE BUCKET -----------------------------------------------------------------
# // https://cloud.google.com/load-balancing/docs/https/setup-global-ext-https-buckets#terraform
resource "google_storage_bucket" "frontend" {
  name     = local.frontend_bucket_name
  location = var.region
  project  = var.project_id
  website {
    main_page_suffix = "index.html"
  }
}
resource "google_storage_bucket_iam_member" "frontend" {
  bucket = google_storage_bucket.frontend.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
  depends_on = [
    google_storage_bucket.frontend
  ]
}

# // -------------  LOCAL EXEC - BUILD AND UPLOAD REACT FRONTEND TO CLOUD STORAGE -----------------------------------
resource "null_resource" "npm_build_frontend" {
  provisioner "local-exec" {
    command = "cd ../frontend && npm install && npm run build"
  }
  // always run
  triggers = {
    always_run = "${timestamp()}"
  }
}
resource "null_resource" "cloud_storage_upload_frontend" {
  provisioner "local-exec" {
    command = "gsutil -m cp -r ../frontend/build/* gs://${local.frontend_bucket_name}"
  }
  depends_on = [
    null_resource.npm_build_frontend,
    google_storage_bucket.frontend
  ]
  // always run
  triggers = {
    always_run = "${timestamp()}"
  }
}

# // -------------  CLOUD LOAD BALANCER - REACT FRONTEND  -----------------------------------
resource "google_compute_global_address" "frontend" {
  name       = local.frontend_static_ip
  project    = var.project_id
  depends_on = [google_storage_bucket.frontend]
}
resource "google_compute_backend_bucket" "frontend" {
  name        = "cymbal-backend-bucket"
  bucket_name = google_storage_bucket.frontend.name
  project     = var.project_id
  enable_cdn  = true
  depends_on = [
    google_compute_global_address.frontend
  ]
}
resource "google_compute_url_map" "frontend" {
  name            = "cymbal-url-map"
  default_service = google_compute_backend_bucket.frontend.self_link
  project         = var.project_id
  depends_on = [
    google_compute_backend_bucket.frontend
  ]
}
resource "google_compute_target_http_proxy" "frontend" {
  name    = "cymbal-http-proxy"
  url_map = google_compute_url_map.frontend.self_link
  project = var.project_id
  depends_on = [
    google_compute_url_map.frontend
  ]
}
resource "google_compute_global_forwarding_rule" "frontend" {
  name                  = "http-lb-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  project               = var.project_id
  target                = google_compute_target_http_proxy.frontend.id
  ip_address            = google_compute_global_address.frontend.address
  depends_on = [
    google_compute_target_http_proxy.frontend
  ]
}
# // -------------  LOCAL EXEC - BUILD AND PUSH INVENTORY API DOCKER IMAGE -------------------------------------
resource "null_resource" "docker_build_backend" {
  provisioner "local-exec" {
    command = "cd ../backend && docker build --platform linux/amd64 -t ${local.inventory_image_url} ."
  }
  // always run this on every terraform apply
  triggers = {
    always_run = timestamp()
  }
}
resource "null_resource" "docker_push_backend" {
  provisioner "local-exec" {
    command = "docker push ${local.inventory_image_url}"
  }
  triggers = {
    always_run = timestamp()
  }
  depends_on = [
    null_resource.docker_build_backend
  ]
}

# // -------------  CLOUD RUN SERVICE - INVENTORY API -----------------------------------------------------------------
resource "google_cloud_run_v2_service" "inventory" {
  name     = "inventory"
  location = var.region
  project  = var.project_id
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = local.inventory_image_url
      env {
        name  = "PROJECT_ID"
        value = var.project_id
      }
      ports {
        container_port = 8000
      }
      startup_probe {
        initial_delay_seconds = 10
        timeout_seconds       = 10
        period_seconds        = 5
        failure_threshold     = 3
        tcp_socket {
          port = 8000
        }
      }
      liveness_probe {
        http_get {
          path = "/health"
        }
        initial_delay_seconds = 10
        timeout_seconds       = 10
        period_seconds        = 5
        failure_threshold     = 3
      }
    }
  }
  depends_on = [null_resource.docker_push_backend]
}

resource "google_cloud_run_v2_service_iam_member" "member" {
  location = google_cloud_run_v2_service.inventory.location
  project  = google_cloud_run_v2_service.inventory.project
  name     = google_cloud_run_v2_service.inventory.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

// -------------  BIGQUERY - SALES DATA -----------------------------------------------------------------
resource "google_bigquery_dataset" "bq_dataset" {
  project                     = var.project_id
  dataset_id                  = "cymbal_sales"
  friendly_name               = "Cymbal Superstore Product Sales"
  description                 = "Product sales by week Q3 2023"
  location                    = "US"
  default_table_expiration_ms = 5184000000
}


resource "google_bigquery_table" "bq_table" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.bq_dataset.dataset_id
  table_id   = "cymbalsalestable"
  depends_on = [
    google_bigquery_dataset.bq_dataset
  ]
}

// upload sales_bq_rawdata to GCS bucket 
resource "google_storage_bucket_object" "bq_rawdata" {
  name   = "sales_bq_rawdata.csv"
  bucket = google_storage_bucket.frontend.name
  source = "./sales_bq_rawdata.csv"
  depends_on = [
    google_storage_bucket.frontend
  ]
}

// exec using the bq command to load sales_bq_rawdata.csv from GCS bucket "Frontend" into table 
resource "null_resource" "bq_load" {
  provisioner "local-exec" {
    command = "bq load --autodetect --source_format=CSV --skip_leading_rows=1 ${google_bigquery_dataset.bq_dataset.dataset_id}.${google_bigquery_table.bq_table.table_id} gs://${google_storage_bucket.frontend.name}/sales_bq_rawdata.csv"
  }
  depends_on = [
    google_bigquery_table.bq_table,
    google_storage_bucket_object.bq_rawdata
  ]
  # only run this once to avoid duplicate data 
  # triggers = {
  #   always_run = timestamp()
  # }
}

// SPANNER DATABASE
resource "google_spanner_instance" "transactions" {
  project      = var.project_id
  name         = "cymbal-spanner-instance"
  config       = "regional-us-central1"
  display_name = "Cymbal Superstore Transactions"
  num_nodes    = 2
}


resource "google_spanner_database" "database" {
  project                  = var.project_id
  instance                 = google_spanner_instance.transactions.name
  name                     = "transactions-db"
  version_retention_period = "7d"
  ddl = [
    "CREATE TABLE t1 (t1 INT64 NOT NULL,) PRIMARY KEY(t1)",
    "CREATE TABLE t2 (t2 INT64 NOT NULL,) PRIMARY KEY(t2)",
  ]
  deletion_protection = false
}
