# Red
resource "google_compute_network" "vpc" {
  name                    = "practica-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "practica-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
}

# Firewall
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-enabled"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

variable "vm_names" {
  type    = list(string)
  default = ["vm-1", "vm-2", "vm-3"]
}

module "vms" {
  for_each = toset(var.vm_names)

  source        = "./modules/vm"
  name          = each.key
  machine_type  = var.machine_type
  zone          = var.zone
  subnetwork_id = google_compute_subnetwork.subnet.id
}
