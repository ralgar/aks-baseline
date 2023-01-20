resource "helm_release" "external_secrets" {
  name             = local.application
  namespace        = local.application
  create_namespace = true
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  version          = "0.7.2"
}

resource "kubectl_manifest" "service_account" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${local.service_account}
  namespace: ${local.application}
  labels:
    azure.workload.identity/use: "true"
  annotations:
    azure.workload.identity/client-id: ${azuread_application.app.application_id}
    azure.workload.identity/tenant-id: ${data.azurerm_client_config.current.tenant_id}
    azure.workload.identity/service-account-token-expiration: "86400"
YAML
  apply_only = true
  depends_on = [ helm_release.external_secrets ]
}

resource "kubectl_manifest" "external_secrets_config" {
  yaml_body = <<YAML
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: azure-keyvault
spec:
  provider:
    azurekv:
      authType: WorkloadIdentity
      vaultUrl: "${azurerm_key_vault.default.vault_uri}"
      serviceAccountRef:
        name: ${local.service_account}
        namespace: ${local.application}
YAML
  apply_only = true
  depends_on = [ kubectl_manifest.service_account ]
}
