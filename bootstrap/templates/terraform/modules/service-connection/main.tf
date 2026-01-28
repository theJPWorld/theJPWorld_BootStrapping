resource "azuredevops_serviceendpoint_azurerm" "this" {
  project_id                             = var.adoProjectId
  service_endpoint_name                  = var.serviceConnectionName
  description                            = var.scDescription
  service_endpoint_authentication_scheme = "WorkloadIdentityFederation"
  credentials {
    serviceprincipalid = var.umiPrincipalId
  }
  azurerm_spn_tenantid      = var.tenantId
  azurerm_subscription_id   = var.subscriptionId_Application
  azurerm_subscription_name = var.subscriptionName_Application
}

resource "azurerm_federated_identity_credential" "this" {
  name                = var.serviceConnectionName
  resource_group_name = var.rgName_umiComplete
  parent_id           = var.umiResourceId
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azuredevops_serviceendpoint_azurerm.this.workload_identity_federation_issuer
  subject             = azuredevops_serviceendpoint_azurerm.this.workload_identity_federation_subject
}