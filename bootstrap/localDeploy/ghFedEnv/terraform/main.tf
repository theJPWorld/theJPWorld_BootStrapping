
module "github_environment_build" {
  source               = "../../../templates/terraform/modules/gh-environment"
  environmentName_gh   = "${local.environmentName_gh}-build"
  repositoryName_gh    = var.repositoryName_gh
  preventSelfReview_gh = false
  rgName_umiComplete   = local.rgName_umi_complete
  umiResourceId        = data.azurerm_user_assigned_identity.build.id
  orgName_gh           = var.orgName_gh
}

module "github_environment_secret_build_azure_client_id" {
  source        = "../../../templates/terraform/modules/gh-environment-secret"
  repositoryName_gh = var.repositoryName_gh
  environmentName_gh = "${local.environmentName_gh}-build"
  secretName    = "AZURE_CLIENT_ID"
  secretValue   = data.azurerm_user_assigned_identity.build.client_id
  depends_on = [ module.github_environment_build ]
}

module "github_environment_secret_build_azure_tenant_id" {
  source        = "../../../templates/terraform/modules/gh-environment-secret"
  repositoryName_gh = var.repositoryName_gh
  environmentName_gh = "${local.environmentName_gh}-build"
  secretName    = "AZURE_TENANT_ID"
  secretValue   = data.azurerm_user_assigned_identity.build.tenant_id
  depends_on = [ module.github_environment_build ]
}

module "github_environment_secret_build_azure_subscription_id" {
  source        = "../../../templates/terraform/modules/gh-environment-secret"
  repositoryName_gh = var.repositoryName_gh
  environmentName_gh = "${local.environmentName_gh}-build"
  secretName    = "AZURE_SUBSCRIPTION_ID"
  secretValue   = var.subscriptionId_Application
  depends_on = [ module.github_environment_build ]
}


module "github_environment_deploy" {
  source               = "../../../templates/terraform/modules/gh-environment"
  teamName_gh          = "${local.teamName_gh}-deploy"
  environmentName_gh   = "${local.environmentName_gh}-deploy"
  repositoryName_gh    = var.repositoryName_gh
  preventSelfReview_gh = var.preventSelfReviewDeploy_gh
  rgName_umiComplete   = local.rgName_umi_complete
  umiResourceId        = data.azurerm_user_assigned_identity.deploy.id
  orgName_gh           = var.orgName_gh
  gh_approval          = var.deployApprovalRequired
}

module "github_environment_secret_deploy_azure_client_id" {
  source        = "../../../templates/terraform/modules/gh-environment-secret"
  repositoryName_gh = var.repositoryName_gh
  environmentName_gh = "${local.environmentName_gh}-deploy"
  secretName    = "AZURE_CLIENT_ID"
  secretValue   = data.azurerm_user_assigned_identity.deploy.client_id
  depends_on = [ module.github_environment_deploy ]
}

module "github_environment_secret_deploy_azure_tenant_id" {
  source        = "../../../templates/terraform/modules/gh-environment-secret"
  repositoryName_gh = var.repositoryName_gh
  environmentName_gh = "${local.environmentName_gh}-deploy"
  secretName    = "AZURE_TENANT_ID"
  secretValue   = data.azurerm_user_assigned_identity.deploy.tenant_id
  depends_on = [ module.github_environment_deploy ]
}

module "github_environment_secret_deploy_azure_subscription_id" {
  source        = "../../../templates/terraform/modules/gh-environment-secret"
  repositoryName_gh = var.repositoryName_gh
  environmentName_gh = "${local.environmentName_gh}-deploy"
  secretName    = "AZURE_SUBSCRIPTION_ID"
  secretValue   = var.subscriptionId_Application
  depends_on = [ module.github_environment_deploy ]
}
