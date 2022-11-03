module "aks_cluster" {
  source = "./modules/aks-cluster"

  environment = "staging"
  prefix      = "techdemo"
  location    = var.location
}

module "flux_cd" {
  source = "./modules/flux-cd"

  gitops_repo   = "https://github.com/ralgar/testing-aks.git"
  gitops_branch = "master"
  gitops_path   = "cluster/"
}

/*resource "helm_release" "argocd" {
  name              = "argocd"
  namespace         = "argocd"
  chart             = "${path.root}/../cluster/system/argocd"
  dependency_update = true
  create_namespace  = true
  atomic            = true
}*/
