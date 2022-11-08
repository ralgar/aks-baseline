resource "azurerm_resource_group" "cluster" {
  name     = "${var.prefix}-rg"
  location = var.location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name            = "default"
    vm_size         = "Standard_D2s_v3"
    os_disk_type    = "Ephemeral"
    os_disk_size_gb = 48

    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5
    zones               = [1,2,3]
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
  automatic_channel_upgrade         = "stable"

  tags = {
    environment = azurerm_resource_group.cluster.tags.environment
  }
}
