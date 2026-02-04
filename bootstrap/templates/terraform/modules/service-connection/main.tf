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


resource "azuredevops_group" "deploy-approvers" {
  count      = var.deployApprovalRequired == true ? 1 : 0
  scope = var.adoProjectId
  display_name       = "Approvers-${var.serviceConnectionName}"
  description = "Approvers group for service connection ${var.serviceConnectionName}"
}

resource "azuredevops_check_approval" "this" {
  count                = var.deployApprovalRequired == true ? 1 : 0
  project_id           = var.adoProjectId
  target_resource_id   = azuredevops_serviceendpoint_azurerm.this.id
  target_resource_type = "endpoint"

  requester_can_approve = !var.preventSelfReviewDeploy_ado
  approvers = [
    azuredevops_group.deploy-approvers[0].origin_id
  ]
  timeout = 43200
  depends_on = [
    azuredevops_serviceendpoint_azurerm.this,
    azuredevops_group.deploy-approvers
  ]
}