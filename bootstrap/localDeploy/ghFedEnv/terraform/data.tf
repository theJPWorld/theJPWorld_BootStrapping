data "azurerm_user_assigned_identity" "build" {
  resource_group_name = local.rgName_umi_complete
  name                = local.umiName_build_complete
}

data "azurerm_user_assigned_identity" "deploy" {
  resource_group_name = local.rgName_umi_complete
  name                = local.umiName_deploy_complete
}