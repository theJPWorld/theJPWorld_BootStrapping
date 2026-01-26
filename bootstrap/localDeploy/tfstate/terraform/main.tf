module "resourcegroup-state" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  version  = "0.2.1"
  name     = "${var.rgName_state}-${var.app_short}-${var.environment}-${var.locationShort}-01"
  location = var.location
  tags     = merge(var.tags, var.tags_state)
  role_assignments = {
    Owner_Deploy = {
      principal_type             = "ServicePrincipal"
      principal_id               = data.azurerm_user_assigned_identity.deploy.principal_id
      role_definition_id_or_name = "Owner"
    }
    Reader_Build = {
      principal_type             = "ServicePrincipal"
      principal_id               = data.azurerm_user_assigned_identity.build.principal_id
      role_definition_id_or_name = "Reader"
    }
  }   
}


module "storageaccount-state" {
  source              = "Azure/avm-res-storage-storageaccount/azurerm"
  version             = "0.6.7"
  resource_group_name = module.resourcegroup-state.name
  name                = "${var.saName_state}${var.app_short}${var.environment}${var.locationShort}"
  location            = var.location
  tags                = merge(var.tags, var.tags_state)
  containers = var.containers_state
  role_assignments = {
    BlobContributor_Deploy = {
      principal_type             = "ServicePrincipal"
      principal_id               = data.azurerm_user_assigned_identity.deploy.principal_id
      role_definition_id_or_name = "Storage Blob Data Contributor"
    }
    BlobContributor_Build = {
      principal_type             = "ServicePrincipal"
      principal_id               = data.azurerm_user_assigned_identity.build.principal_id
      role_definition_id_or_name = "Storage Blob Data Contributor"
    }
  }
}

