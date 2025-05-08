terraform {
    backend "gcs" { 
      bucket  = "terraform-state-cpl-home-infra"
      prefix  = "prod"
    }
}

resource "google_project_service" "services" {
  for_each = toset([
    "container.googleapis.com",
    "compute.googleapis.com",
    "storage.googleapis.com",
  ])
  project                    = var.project
  service                    = each.value
  disable_dependent_services = false
  disable_on_destroy         = false
}

provider "google" {
  project = var.project
  region = var.region
}