resource "azuread_application" "app" {
  display_name = "${local.application}-sp"
  owners       = [ data.azuread_client_config.current.object_id ]
}

resource "azuread_service_principal" "app" {
  application_id = azuread_application.app.application_id
  owners         = [ data.azuread_client_config.current.object_id ]
}

resource "azuread_service_principal_password" "app" {
  service_principal_id = azuread_service_principal.app.id
}

resource "azuread_application_federated_identity_credential" "app" {
  application_object_id = azuread_application.app.object_id
  display_name          = "${local.application}-fed-id"
  description           = "The federated identity used to integrate K8s, Azure AD, and ${local.application}."
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = var.oidc_issuer_url
  subject               = "system:serviceaccount:${local.application}:${local.service_account}"
}
