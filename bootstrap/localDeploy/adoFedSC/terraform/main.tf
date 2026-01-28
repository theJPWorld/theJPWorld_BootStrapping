
module "build_federated_service_connection" {
  source = "../../../templates/terraform/modules/service-connection"

  adoProjectId                 = var.adoProjectId
  serviceConnectionName        = "${var.serviceConnectionName_Build}"
  scDescription                = var.scDescription
  umiPrincipalId               = data.azurerm_user_assigned_identity.build.principal_id
  tenantId                     = data.azurerm_user_assigned_identity.build.tenant_id
  subscriptionId_Application   = var.subscriptionId_Application
  subscriptionName_Application = var.subscriptionName_Application
  rgName_umiComplete           = "${var.rgName_umi}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  umiResourceId                = data.azurerm_user_assigned_identity.build.id
}

module "deploy_federated_service_connection" {
  source = "../../../templates/terraform/modules/service-connection"

  adoProjectId                 = var.adoProjectId
  serviceConnectionName        = "${var.serviceConnectionName_Deploy}"
  scDescription                = var.scDescription
  umiPrincipalId               = data.azurerm_user_assigned_identity.deploy.principal_id
  tenantId                     = data.azurerm_user_assigned_identity.deploy.tenant_id
  subscriptionId_Application   = var.subscriptionId_Application
  subscriptionName_Application = var.subscriptionName_Application
  rgName_umiComplete           = "${var.rgName_umi}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  umiResourceId                = data.azurerm_user_assigned_identity.deploy.id
}