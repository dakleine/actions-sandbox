terraform {
    backend "gcs" { 
      bucket  = "terraform-state-cpl-home-infra"
      prefix  = "prod"
    }
}

provider "google" {
  project = var.project
  region = var.region
}