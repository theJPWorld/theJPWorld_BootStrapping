terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}
provider "azurerm" {
  features {}
  use_oidc        = true
  subscription_id = var.subscriptionId_State
}

provider "random" {}
