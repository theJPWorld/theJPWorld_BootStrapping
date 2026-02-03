terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.58.0"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "1.13.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscriptionId_Application
}

provider "azuredevops" {
  org_service_url       = var.adoOrgUrl
  personal_access_token = var.adoPAT
}

provider "random" {}