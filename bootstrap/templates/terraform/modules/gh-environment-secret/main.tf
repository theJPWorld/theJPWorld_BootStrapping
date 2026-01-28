resource "github_actions_environment_secret" "this_secret" {
  repository       = var.repositoryName_gh
  environment      = var.environmentName_gh
  secret_name      = var.secretName
  plaintext_value  = var.secretValue
}