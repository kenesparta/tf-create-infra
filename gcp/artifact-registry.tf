locals {
  id          = data.external.env_vars.result["ID"]
  google_zone = data.external.env_vars.result["GOOGLE_ZONE"]
}

resource "google_project_service" "artifact_registry" {
  service = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "docker_repo" {
  location      = local.google_zone
  repository_id = format("fibo-wasm-%s", local.id)
  description   = "Fibonacci WASM"
  format        = "DOCKER"

  labels = {
    environment = "test"
  }
}
