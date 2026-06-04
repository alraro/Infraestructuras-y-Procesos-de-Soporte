terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

resource "local_file" "readme" {
  filename = "${path.module}/output/README.md"
  content  = "# Mi primer proyecto Terraform\n\nGenerado Automaticamente.\n\nAutor: ${var.author}\n\nEntorno: ${upper(var.environment)}"
}
