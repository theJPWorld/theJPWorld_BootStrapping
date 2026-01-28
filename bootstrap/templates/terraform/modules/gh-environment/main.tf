resource "github_team" "approval_team" {
  name        = var.teamName_gh
  description = "Team responsible for approvals"
  privacy     = "closed"
}

resource "github_repository_environment" "this" {
  environment         = var.environmentName_gh
  repository          = var.repositoryName_gh
  prevent_self_review = var.preventSelfReview_gh
  reviewers {
    teams = [github_team.approval_team.id]
  }
}