resource "github_team" "approval_team" {
  name        = "approval-team"
  description = "Team responsible for approvals"
  privacy     = "closed"
}

resource "github_repository_environment" "example" {
  environment         = "example"
  repository          = github_repository.example.name
  prevent_self_review = true
  reviewers {
    teams = [github_team.approval_team.id]
  }
  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}