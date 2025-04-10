resource "google_sql_database_instance" "default" {
  name             = "clientes-db"
  database_version = "MYSQL_8_0"
  region           = var.region

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc_network.id
    }
  }
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
