variable "environmentName_gh" {
	description = "The name of the GitHub environment to configure."
	type        = string
}

variable "repositoryName_gh" {
	description = "The name of the GitHub repository containing the environment."
	type        = string
}

variable "secretName" {
  description = "The name of the GitHub Actions environment secret."
  type        = string
}

variable "secretValue" {
  description = "The value of the GitHub Actions environment secret."
  type        = string
  ephemeral = true
}