module "resourcegroup-umi" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  version  = "0.2.1"
  name     = "${var.rgName_umi}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  location = var.location
  tags     = merge(var.tags, var.tags_umi)
}

module "umi_tf_build" {
  source  = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version = "0.3.4"
  resource_group_name = module.resourcegroup-umi.name
  name = "${var.umiName_tf}build-${var.app_short}-${var.environment}-${var.locationShort}"
  location = var.location
  tags = merge(var.tags, var.tags_umi)
}

module "umi_tf_deploy" {
  source  = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version = "0.3.4"
  resource_group_name = module.resourcegroup-umi.name
  name = "${var.umiName_tf}deploy-${var.app_short}-${var.environment}-${var.locationShort}"
  location = var.location
  tags = merge(var.tags, var.tags_umi)
}