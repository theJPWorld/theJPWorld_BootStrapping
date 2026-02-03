terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.58.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.10.2"
    }
  }
}