terraform {
  required_version = ">=1.0"

  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "0.20.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.15.0"
    }
  }
}
