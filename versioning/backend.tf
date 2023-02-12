resource "google_compute_backend_service" "backend" {
  provider                        = google-beta
  name                            = "${var.project}"
  project                         = "${var.projectid}"
  enable_cdn                      = true
  timeout_sec                     = 10
  connection_draining_timeout_sec = 10
  protocol                        = "HTTPS"

  custom_request_headers = ["host: ${split("/", "${google_cloud_run_service.container.status[0].url}")[2]}"]


  backend {
    group = "projects/${var.projectid}/global/networkEndpointGroups/cloudrun"
  }

}
output "backend-id" {
    value = google_compute_backend_service.backend.id
}