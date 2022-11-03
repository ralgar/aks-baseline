terraform {
  required_version = ">=1.0"

  required_providers {
    flux       = { source = "fluxcd/flux" }
    kubectl    = { source = "gavinbunney/kubectl" }
    kubernetes = { source = "hashicorp/kubernetes" }
  }
}

provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host = module.aks_cluster.host
    client_certificate = base64decode(module.aks_cluster.client_certificate)
    client_key = base64decode(module.aks_cluster.client_key)
    cluster_ca_certificate = base64decode(module.aks_cluster.cluster_ca_certificate)
  }
}

provider "kubectl" {
  host = module.aks_cluster.host
  client_certificate = base64decode(module.aks_cluster.client_certificate)
  client_key = base64decode(module.aks_cluster.client_key)
  cluster_ca_certificate = base64decode(module.aks_cluster.cluster_ca_certificate)
  load_config_file = false
}

provider "kubernetes" {
  host = module.aks_cluster.host
  client_certificate = base64decode(module.aks_cluster.client_certificate)
  client_key = base64decode(module.aks_cluster.client_key)
  cluster_ca_certificate = base64decode(module.aks_cluster.cluster_ca_certificate)
}
