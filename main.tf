terraform {
    backend "gcs" { 
      bucket  = "terraform-state-cpl-home-infra"
      prefix  = "prod"
    }
}

resource "google_project_service" "multiple_apis" {
  #for_each = toset([
  #  "cloudresourcemanager.googleapis.com",
  #  "serviceusage.googleapis.com",
  #  "storage.googleapis.com",
  #  "compute.googleapis.com",
  #  "container.googleapis.com",
  #])
  project                    = var.project
  #service                    = each.value
  service                    = "container.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
  disable_on_destroy         = true
}

provider "google" {
  project = var.project
  region = var.region
}