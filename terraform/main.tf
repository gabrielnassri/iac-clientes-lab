provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = "iac-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "iac-subnet"
  ip_cidr_range = "10.10.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_vpc_access_connector" "vpc_connector" {
  name   = "iac-vpc-connector"
  region = var.region
  network = google_compute_network.vpc_network.name

  ip_cidr_range = "10.8.0.0/28"
}
