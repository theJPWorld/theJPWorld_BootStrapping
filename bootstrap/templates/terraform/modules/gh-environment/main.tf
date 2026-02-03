
resource "github_team" "approval_team" {
  count       = var.gh_approval == true ? 1 : 0
  name        = var.teamName_gh
  description = "Team responsible for approvals"
  privacy     = "closed"
}

resource "github_team_repository" "approval_team_repo" {
  count       = var.gh_approval == true ? 1 : 0
  team_id    = github_team.approval_team[0].id
  repository = var.repositoryName_gh
}

resource "github_repository_environment" "this" {
  environment         = var.environmentName_gh
  repository          = var.repositoryName_gh
  prevent_self_review = var.preventSelfReview_gh == true ? var.preventSelfReview_gh : false
  reviewers {
    teams = var.gh_approval == true ? [github_team.approval_team[0].id] : []
  }
}

resource "azurerm_federated_identity_credential" "github" {
  name                = "sc-gh-${var.environmentName_gh}"
  resource_group_name = var.rgName_umiComplete
  parent_id           = var.umiResourceId
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  subject             = "repo:${var.orgName_gh}/${var.repositoryName_gh}:environment:${var.environmentName_gh}"
}