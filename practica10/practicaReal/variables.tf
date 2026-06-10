variable "projects_base_dir" {
  type        = string
  description = "Ruta de todos los proyectos generados"
  default     = "./projects"
}

variable "projects" {
  type = map(object({
    author      = string
    environment = string
  }))
  default = {
    "modelo-machine-learning" = {
      author      = "Alfonso el programador de ia"
      environment = "dev"
    }
    "videojuego" = {
      author      = "Alfonso el sucesor de Alva Majo"
      environment = "prod"
    }
    "compilador" = {
      author      = "Alfonso el programador de bajo nivel"
      environment = "staging"
    }
  }
}

variable "map_projects_base_dir" {
  type        = string
  description = "Ruta de todos los proyectos generados (usando foreach)"
  default     = "./map_projects"
}