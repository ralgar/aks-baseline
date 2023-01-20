locals {
  application     = "external-secrets"
  service_account = "${local.application}-keyvault"
}

variable "resource_group" {}
variable "oidc_issuer_url" {}
