module "aks_cluster" {
  source = "./modules/azure/aks-cluster"

  environment = var.environment
  location    = var.location
  prefix      = var.prefix
}

module "flux_cd" {
  source = "./modules/kubernetes/deploy-flux"
}
