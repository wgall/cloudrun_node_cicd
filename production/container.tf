resource "google_cloud_run_service" "container" {
  name     = "${var.project}"
  location = "europe-central2"

  template {
    spec {
      containers {
        image = "gcr.io/${var.projectid}/${var.image}:${var.tag}"
        ports {
          protocol       = "TCP"
          container_port = 3000
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "1000"
        "run.googleapis.com/client-name"   = "terraform"
      }
    }
  }
  autogenerate_revision_name = true

}
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.container.location
  project     = google_cloud_run_service.container.project
  service     = google_cloud_run_service.container.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
