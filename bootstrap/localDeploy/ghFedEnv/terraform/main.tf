
module "build_federated_service_connection" {
  source = "../../../templates/terraform/modules/ado-service-connection"

  adoProjectId                 = var.adoProjectId
  serviceConnectionName        = local.buildServiceConnectionName
  scDescription                = var.scDescription
  umiPrincipalId               = data.azurerm_user_assigned_identity.build.principal_id
  tenantId                     = data.azurerm_user_assigned_identity.build.tenant_id
  subscriptionId_Application   = var.subscriptionId_Application
  subscriptionName_Application = var.subscriptionName_Application
  rgName_umiComplete           = local.rgName_umi_complete
  umiResourceId                = data.azurerm_user_assigned_identity.build.id
}

module "deploy_federated_service_connection" {
  source = "../../../templates/terraform/modules/ado-service-connection"

  adoProjectId                 = var.adoProjectId
  serviceConnectionName        = local.deployServiceConnectionName
  scDescription                = var.scDescription
  umiPrincipalId               = data.azurerm_user_assigned_identity.deploy.principal_id
  tenantId                     = data.azurerm_user_assigned_identity.deploy.tenant_id
  subscriptionId_Application   = var.subscriptionId_Application
  subscriptionName_Application = var.subscriptionName_Application
  rgName_umiComplete           = local.rgName_umi_complete
  umiResourceId                = data.azurerm_user_assigned_identity.deploy.id
}