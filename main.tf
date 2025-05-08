terraform {
    backend "gcs" { 
      bucket  = "terraform-state-jb-cicdproject-home-infra"
      prefix  = "prod"
    }
}

provider "google" {
  project = var.project
  region = var.region
}