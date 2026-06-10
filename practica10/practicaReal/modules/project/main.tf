terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

locals {
  project_dir = "${var.base_dir}/${var.project_name}"
  gitignore_content = <<-EOT
    .env
    node_modules/
    *.log
  EOT
}

resource "local_file" "readme" {
  filename = "${local.project_dir}/README.md"
  content  = "# ${var.project_name}\n\nGenerado Automaticamente.\n\nAutor: ${var.author}\n\nEntorno: ${upper(var.environment)}"
}

resource "local_file" "gitignore" {
  filename = "${local.project_dir}/.gitignore"
  content = "${local.gitignore_content}"
}

resource "local_file" "srcFolder" {
  filename = "${local.project_dir}/src/.keep"
  content = ""
}


resource "local_file" "testsForlder" {
  filename = "${local.project_dir}/tests/.keep"
  content = ""
}

resource "local_file" "index" {
  filename = "${local.project_dir}/docs/index.md"
  content = "# Índice"
}
