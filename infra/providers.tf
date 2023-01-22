terraform {
  required_version = ">=1.0"

  required_providers {
    azuread = { source = "hashicorp/azuread" }
    azurerm = { source = "hashicorp/azurerm" }
    flux    = { source = "fluxcd/flux" }
    helm    = { source = "hashicorp/helm" }
    kubectl = { source = "gavinbunney/kubectl" }
  }

  cloud {
    organization = "aks-baseline"
    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = module.aks_cluster.host
    client_certificate     = base64decode(module.aks_cluster.client_certificate)
    client_key             = base64decode(module.aks_cluster.client_key)
    cluster_ca_certificate = base64decode(module.aks_cluster.cluster_ca_certificate)
  }
}

provider "kubectl" {
  host                   = module.aks_cluster.host
  client_certificate     = base64decode(module.aks_cluster.client_certificate)
  client_key             = base64decode(module.aks_cluster.client_key)
  cluster_ca_certificate = base64decode(module.aks_cluster.cluster_ca_certificate)
  load_config_file       = false
}
