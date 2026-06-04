resource "google_compute_instance" "this" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["ssh-enabled", "web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = var.subnetwork_id
    access_config {}
  }

  metadata_startup_script = replace(<<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
echo "<h1>${var.name}</h1>" > /var/www/html/index.html
EOF
  , "\r", "")
}
