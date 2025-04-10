resource "google_service_account" "github_actions" {
  account_id   = "github-deployer"
  display_name = "GitHub Actions Service Account"
}

resource "google_project_iam_member" "run_admin" {
  role   = "roles/run.admin"
  member = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_project_iam_member" "iam_admin" {
  role   = "roles/iam.securityAdmin"
  member = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_project_iam_member" "storage_admin" {
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_project_iam_member" "run_invoker" {
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_service_account_key" "github_key" {
  service_account_id = google_service_account.github_actions.name
  keepers = {
    last_updated = timestamp()
  }
}

output "github_sa_key_json" {
  value     = google_service_account_key.github_key.private_key
  sensitive = true
}

output "github_sa_email" {
  value = google_service_account.github_actions.email
}
