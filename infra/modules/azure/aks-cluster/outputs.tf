resource "local_sensitive_file" "kube_config" {
  filename = "${path.root}/../output/kube_config"
  content  = azurerm_kubernetes_cluster.cluster.kube_config_raw

  directory_permission = "0700"
  file_permission      = "0600"
}

output "host" {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.host
}

output "client_key" {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.client_key
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate
}
