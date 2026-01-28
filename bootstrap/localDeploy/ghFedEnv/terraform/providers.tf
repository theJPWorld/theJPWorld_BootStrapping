terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.58.0"
    }
    github = {
      source = "integrations/github"
      version = "6.10.2"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = var.subscriptionId_Application
}

provider "github" {
  #read this link for more info
  #https://registry.terraform.io/providers/integrations/github/latest/docs
}

provider "random" {}