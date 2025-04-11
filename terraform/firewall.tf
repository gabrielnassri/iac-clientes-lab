resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-web"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["frontend"]
  description   = "Permitir tráfico HTTP a la VM"
}
