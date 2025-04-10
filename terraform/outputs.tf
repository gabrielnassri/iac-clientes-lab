output "sql_instance_connection_name" {
  value = google_sql_database_instance.default.connection_name
}

output "cloud_run_url" {
  value       = google_cloud_run_service.java_api.status[0].url
  description = "URL pública del servicio Cloud Run"
}

output "github_sa_email" {
  value       = google_service_account.github_actions.email
  description = "Correo electrónico de la cuenta de servicio de GitHub Actions"
}

output "github_sa_key_json" {
  value       = google_service_account_key.github_key.private_key
  description = "Clave privada en JSON (para GitHub Secrets)"
  sensitive   = true
}
