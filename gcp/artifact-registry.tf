locals {
  id             = data.external.env_vars.result["ID"]
  google_zone    = data.external.env_vars.result["GOOGLE_ZONE"]
  container_name = data.external.env_vars.result["CONTAINER_NAME"]
}

resource "google_project_service" "artifact_registry" {
  service = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "docker_repo" {
  location      = local.google_zone
  repository_id = format("%s-%s", local.container_name, local.id)
  description   = "Docker Weekend Event"
  format        = "DOCKER"

  labels = {
    environment = "test"
  }
}
