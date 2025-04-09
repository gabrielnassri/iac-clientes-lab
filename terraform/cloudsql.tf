resource "google_sql_database_instance" "default" {
  name             = "clientes-db"
  database_version = "MYSQL_5_7"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.default.name
  password = var.db_password
}

resource "google_sql_database" "database" {
  name     = "clientes"
  instance = google_sql_database_instance.default.name
}