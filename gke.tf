resource "google_container_cluster" "default" {
  name     = "gke-autopilot-basic"
  location = "us-central1"

  enable_autopilot = true
  deletion_protection = false
  confidential_nodes {
    enabled = true
  }
  release_channel {
    channel = "REGULAR"
  }
}

data "google_client_config" "current" {}
provider "kubernetes" {
  host                   = "https://${google_container_cluster.default.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}