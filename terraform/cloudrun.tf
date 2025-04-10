resource "google_cloud_run_service" "java_api" {
  name     = "clientes-api"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/clientes-api:latest"

        env {
          name  = "DB_HOST"
          value = google_sql_database_instance.default.connection_name
        }
        env {
          name  = "DB_USER"
          value = var.db_user
        }
        env {
          name  = "DB_PASSWORD"
          value = var.db_password
        }

        ports {
          container_port = 8080
        }
      }

      container_concurrency = 80

      vpc_access_egress = "ALL_TRAFFIC"
      vpc_connector     = google_vpc_access_connector.vpc_connector.id

      traffic {
        percent         = 100
        latest_revision = true
      }
    }
  }

  traffics {
    percent         = 100
    latest_revision = true
  }
}
