#!/bin/bash 
export PROJECT_ID="mokeefe-test-1"
gcloud config set project $PROJECT_ID

# delete cloud storage bucket 
export GCS_BUCKET="${PROJECT_ID}-cymbal-frontend"
gsutil rm -r gs://${GCS_BUCKET}
gcloud storage rm --recursive gs://${GCS_BUCKET}

# delete bigquery dataset, "cymbal_sales"
bq rm -r -f -d cymbal_sales

# delete cloud run service, "inventory"
gcloud run services delete inventory --platform managed --region us-central1 --quiet

# delete target http proxy
gcloud compute target-http-proxies delete cymbal-http-proxy --quiet

# delete url map 
gcloud compute url-maps delete cymbal-url-map --quiet

# delete backend 
gcloud compute backend-buckets delete cymbal-backend-bucket --quiet

# delete global static ip, 
export STATIC_IP="${PROJECT_ID}-cymbal-frontend-ip"
gcloud compute addresses delete ${STATIC_IP} --global --quiet

# delete firestore database
# (must manually delete collection first)
gcloud alpha firestore databases delete --database="(default)"