module "aks_cluster" {
  source = "./modules/aks-cluster"

  environment = "staging"
  prefix      = "techdemo"
  location    = var.location
}

module "flux_cd" {
  source = "./modules/flux-cd"
}
