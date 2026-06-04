output "ips_publicas" {
  description = "IPs públicas de todas las VMs"
  value = {
    for name, vm in module.vms : name => vm.ip_publica
  }
}

output "urls_nginx" {
  description = "URLs de Nginx en todas las VMs"
  value = {
    for name, vm in module.vms : name => "http://${vm.ip_publica}"
  }
}
