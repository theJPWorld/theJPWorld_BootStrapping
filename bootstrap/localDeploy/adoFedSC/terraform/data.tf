data "azurerm_user_assigned_identity" "build" {
  resource_group_name = "${var.rgName_umi}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  name                = "${var.umiName_tf}build-${var.app_short}-${var.environment}-${var.locationShort}"
}

data "azurerm_user_assigned_identity" "deploy" {
  resource_group_name = "${var.rgName_umi}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  name                = "${var.umiName_tf}deploy-${var.app_short}-${var.environment}-${var.locationShort}"
}