resource "google_cloud_run_service" "java_api" {
  name     = "clientes-api"
  location = var.region
  project  = var.project_id

  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector"        = google_vpc_access_connector.vpc_connector.id
        "run.googleapis.com/vpc-access-egress"           = "all-traffic"
        "autoscaling.knative.dev/maxScale"               = "100"
      }
    }

    spec {
      containers {
        image = "gcr.io/cloudrun/hello"

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
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
