resource "random_pet" "prefix" {}

resource "azurerm_resource_group" "cluster" {
  name     = "${random_pet.prefix.id}-rg"
  location = var.aksClusterLocation

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  default_node_pool {
    name            = "default"
    vm_size         = "Standard_D2_v2_Promo"
    os_disk_size_gb = 30

    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
    zones               = [1,2,3]
  }

  // Auth
  service_principal {
    client_id     = var.aksAppID
    client_secret = var.aksPassword
  }

  role_based_access_control_enabled = true
  http_application_routing_enabled  = true
  automatic_channel_upgrade = "stable"

  tags = {
    environment = azurerm_resource_group.cluster.tags.environment
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  chart            = "${path.module}/../cluster/system/argocd"
  dependency_update = true
  namespace        = "argocd"
  create_namespace = true
  atomic = true
}

resource "local_sensitive_file" "kubeconfig" {
  filename = "${path.module}/../output/kubeconfig"
  content  = azurerm_kubernetes_cluster.cluster.kube_config_raw

  directory_permission = "0700"
  file_permission      = "0600"
}
