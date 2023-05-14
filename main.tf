provider "google" {
  project     = "faculdade-386623"
  region      = "us-east1"
}


### Cloud SQL ###

resource "google_sql_database" "database" {
  name     = "aps-chat-database"
  instance = google_sql_database_instance.instance.name
}

# See versions at https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version
resource "google_sql_database_instance" "instance" {
  name             = "aps-chat-database-instance"
  region           = "us-east1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}

### Artifact Registry ###

resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-east1"
  repository_id = "aps-chat-repository"
  description   = "APS Chat Docker repository"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}

### Cloud Storage ###

resource "google_storage_bucket" "auto-expire" {
  name          = "aps-chat-bucket"
  location      = "us-east1"
  force_destroy = true

  public_access_prevention = "enforced"
}

