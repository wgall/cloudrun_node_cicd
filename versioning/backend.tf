resource "google_compute_backend_service" "default" {
  provider                        = google-beta
  name                            = "${var.project}"
  project                         = "labs-370214"
  enable_cdn                      = true
  timeout_sec                     = 10
  connection_draining_timeout_sec = 10
  protocol                        = "HTTPS"

  custom_request_headers = ["host: ${split("/", "${google_cloud_run_service.default.status[0].url}")[2]}"]


  backend {
    group = "projects/labs-370214/global/networkEndpointGroups/cloudrun"
  }

}
output "backend-id" {
    value = google_compute_backend_service.default.id
}