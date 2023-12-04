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

output "frontend_ip" {
  value       = google_compute_global_address.frontend.address
  description = "🍎 Cymbal Superstore frontend address"
}

output "inventory_cr_endpoint" {
  value       = google_cloud_run_v2_service.inventory.uri
  description = "👟 Inventory API Cloud Run address"
}
