resource "google_container_cluster" "default" {
  name     = "gke-autopilot-basic"
  location = "us-central1"

  enable_autopilot = true

  release_channel {
    channel = "REGULAR"
  }
}