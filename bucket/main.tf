terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.26.0"
    }
  }
  
}
variable "project" {
    type = string
    default = "folder"
}
provider "google" {
  project     = "labs-370214"
  region      = "europe-central2"
}

resource "google_storage_bucket_object" "backend_folder" {
  name          = "${var.project}"
  content       = "Empty dir"
  bucket        = "wgall-labs"
}