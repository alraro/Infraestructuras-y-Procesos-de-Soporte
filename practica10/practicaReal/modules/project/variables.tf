variable "project_name" {
  type        = string
  description = "Nombre del proyecto"
  default     = "my-project"
}

variable "author" {
  type        = string
  description = "Nombre del autor o autora"
}

variable "environment" {
  type        = string
  description = "Entorno de despliegue"
  default     = "dev"
}

variable "base_dir" {
  type = string
  description = "Directorio base donde crear el proyecto"
}
