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