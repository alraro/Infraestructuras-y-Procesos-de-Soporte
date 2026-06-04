variable "project_id" {
  type        = string
  description = "ID del proyecto GCP"
}

variable "region" {
  type        = string
  description = "Región de GCP"
  default     = "europe-west1"
}

variable "zone" {
  type        = string
  description = "Zona de GCP"
  default     = "europe-west1-b"
}

variable "machine_type" {
  type        = string
  description = "Tipo de máquina"
  default     = "e2-micro"
}
