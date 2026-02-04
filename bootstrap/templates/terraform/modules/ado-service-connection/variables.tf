variable "adoProjectId" {
  description = "The Azure DevOps project ID."
  type        = string
}

variable "serviceConnectionName" {
  description = "The name of the Azure DevOps service connection."
  type        = string
}

variable "scDescription" {
  description = "Description for the service connection."
  type        = string
  default     = "Service connection using OIDC federated credentials."
}

variable "umiPrincipalId" {
  description = "The User Managed Identity (UMI) principal ID."
  type        = string
}

variable "tenantId" {
  description = "The Azure Tenant ID."
  type        = string
}

variable "subscriptionId_Application" {
  description = "The Azure Subscription ID for deployment."
  type        = string
}

variable "subscriptionName_Application" {
  description = "The Azure Subscription Name for deployment."
  type        = string
}

variable "rgName_umiComplete" {
  description = "The resource group name for the UMI."
  type        = string
}

variable "umiResourceId" {
  description = "The resource ID of the UMI."
  type        = string
}

variable "deployApprovalRequired" {
  description = "Whether deployment approval is required for the service connection."
  type        = bool
  default     = false
}

variable "preventSelfReviewDeploy_ado" {
  description = "Whether to prevent self-review deployment in Azure DevOps."
  type        = bool
  default     = false
}