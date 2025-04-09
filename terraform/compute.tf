resource "google_compute_instance" "frontend" {
  name         = "frontend"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo '<html><body><h1>Clientes</h1><div id="data">Cargando...</div><script>fetch("https://clientes-api-....run.app").then(res => res.json()).then(data => { document.getElementById("data").innerText = JSON.stringify(data); });</script></body></html>' > /var/www/html/index.html
  EOF
}