module "aks_cluster" {
  source = "./modules/azure/aks-cluster"

  environment = "staging"
  prefix      = "techdemo"
  location    = var.location
}

module "flux_cd" {
  source = "./modules/kubernetes/deploy-flux"
}
