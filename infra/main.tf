module "aks_cluster" {
  source = "./modules/azure/aks-cluster"

  environment = var.environment
  location    = var.location
  prefix      = var.prefix
}

module "flux_cd" {
  source = "./modules/kubernetes/flux-cd"
}

module "key_vault" {
  source = "./modules/azure/key-vault"

  resource_group  = module.aks_cluster.resource_group
  oidc_issuer_url = module.aks_cluster.oidc_issuer_url
}
