module "backend-api" {
  source       = "./modules/project"
  base_dir     = var.projects_base_dir
  project_name = "backend-api"
  author       = "Alfonsito el backend dev"
  environment  = "dev"
}

module "frontend-app" {
  source       = "./modules/project"
  base_dir     = var.projects_base_dir
  project_name = "frontend-app"
  author       = "alraro el fronted slop creator"
  environment  = "dev"
}

module "projects-with-foreach" {
  source   = "./modules/project"
  for_each = var.projects

  project_name = each.key
  author       = each.value.author
  environment  = each.value.environment
  base_dir     = var.map_projects_base_dir
}