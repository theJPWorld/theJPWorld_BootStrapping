variable "teamName_gh" {
  description = "The name of the GitHub team responsible for approvals."
  type        = string
  default     = null
}

variable "environmentName_gh" {
  description = "The name of the GitHub environment to configure."
  type        = string
}

variable "orgName_gh" {
  description = "The name of the GitHub organization containing the repository."
  type        = string
}

variable "repositoryName_gh" {
  description = "The name of the GitHub repository containing the environment."
  type        = string
}

variable "preventSelfReview_gh" {
  description = "Whether to prevent reviewers from self-approving in the environment."
  type        = bool
}

variable "gh_approval" {
  description = "Flag to enable (1) or disable (0) GitHub environment approval via team."
  type        = bool
  default     = false
}

variable "rgName_umiComplete" {
  description = "The resource group name for the UMI."
  type        = string
}

variable "umiResourceId" {
  description = "The resource ID of the UMI."
  type        = string
}