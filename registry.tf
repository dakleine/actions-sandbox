resource "google_artifact_registry_repository" "hello-repo" {
  location      = "us-central1"
  repository_id = "hello-repo"
  description   = "example docker repository"
  format        = "DOCKER"
}