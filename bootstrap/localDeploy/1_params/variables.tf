//Global Variables
variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default = {
    Service     = "TBC"
    Environment = "TBC"
    Creator     = "TBC"
    ReviewDate  = "YY/MM"
  }
}

variable "location" {
  description = "Azure region for resources."
  type        = string
}

variable "locationShort" {
  description = "Short form of the Azure region for resources."
  type        = string

}

variable "environment" {
  description = "The environment for which the resources are being created (e.g., dev, tst, uat, prd)."
  type        = string
}

variable "app_short" {
  description = "Short form of the application for resources.  Might be an application code or abbreviation."
  type        = string

}

//State Variables
variable "subscriptionId_State" {
  description = "Subscription ID for the Terraform State resources."
  type        = string
}

variable "tags_state" {
  description = "Additional or override tags for state resources."
  type        = map(string)
  default     = {}
}

variable "rgName_state" {
  description = "Name of the resource group."
  type        = string
  default     = "rg-tfstate"
}

variable "saName_state" {
  description = "Name of the storage account."
  type        = string
  default     = "sttfstate"
}

variable "containers_state" {
  description = "Containers to create in the storage account."
  type = map(object({
    name          = string
    public_access = optional(string, null)
  }))
  default = {}
}

//Identity Variables
variable "subscriptionId_umi" {
  description = "Subscription ID for the Terraform State resources."
  type        = string
}

variable "tags_umi" {
  description = "Additional or override tags for state resources."
  type        = map(string)
  default     = {}
}

variable "rgName_umi" {
  description = "Name of the resource group."
  type        = string
  default     = "rg-umi"
}

variable "umiName_tf" {
  description = "Name of the user managed identity."
  type        = string
  default     = "umi-tf"
}

//SC Credentials Variables
variable "subscriptionId_Application" {
  description = "The Azure Subscription ID for deployment."
  type        = string
}

variable "subscriptionName_Application" {
  description = "The Azure Subscription Name for deployment."
  type        = string
}

variable "adoOrgUrl" {
  description = "The Azure DevOps organization URL."
  type        = string
  default     = "https://dev.azure.com/theJPWorld/"
}

variable "adoProjectId" {
  description = "The Azure DevOps project ID."
  type        = string
  default     = "053ffcce-a848-4a4f-970b-5f49abdc5de8"
}

variable "adoPAT" {
  description = "The Azure DevOps personal access token."
  type        = string
}

variable "serviceConnectionName_Build" {
  description = "The name of the Azure DevOps service connection."
  type        = string
  default     = "sc_build"
}

variable "serviceConnectionName_Deploy" {
  description = "The name of the Azure DevOps service connection."
  type        = string
  default     = "sc_deploy"
}

variable "scDescription" {
  description = "Description for the service connection."
  type        = string
  default     = "Service connection for either build or deploy using OIDC federated credentials."
}