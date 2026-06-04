output "ip_publica" {
  value = google_compute_instance.this.network_interface[0].access_config[0].nat_ip
}

output "url_nginx" {
  value = "http://${google_compute_instance.this.network_interface[0].access_config[0].nat_ip}"
}
