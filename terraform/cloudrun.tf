resource "google_sql_database_instance" "default" {
  name             = "clientes-db"
  database_version = "MYSQL_8_0"
  region           = var.region
  project          = var.project_id

  settings {
    tier              = "db-f1-micro"
    disk_type         = "PD_SSD"
    disk_size         = 5
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"
    disk_autoresize   = false

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc_network.self_link
    }
  }

  deletion_protection = false

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]
}

resource "google_sql_database" "database" {
  name     = "clientes"
  instance = google_sql_database_instance.default.name
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.default.name
  password = var.db_password
}
