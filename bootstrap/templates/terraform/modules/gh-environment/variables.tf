variable "teamName_gh" {
	description = "The name of the GitHub team responsible for approvals."
	type        = string
}

variable "environmentName_gh" {
	description = "The name of the GitHub environment to configure."
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
