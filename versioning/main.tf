terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.26.0"
    }
  }
}
provider "google" {
  project     = "pid"
  region      = "europe-central2"
}
variable "project" {
    type = string
    default = "project"
}
variable "image" {
    type = string
    default = "project"
}
variable "tag" {
    type = string
    default = "tag"
}
variable "projectid" {
  type = string 
  default = "pid"
}
