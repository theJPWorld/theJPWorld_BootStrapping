## [🏠 HOME](../ReadMe.md)

# Terraform Variables Reference

This document explains the variables defined in `variables.tf` for the bootstrap/localDeploy/1_params module.

## Global Variables

| Name         | Type         | Description                                                      | Source         |
|--------------|--------------|------------------------------------------------------------------|----------------|
| `tags`       | map(string)  | Tags to apply to resources.                                      | bootstrap/localDeploy/1_params/"env".tfvars |
| `location`   | string       | Azure region for resources.                                      | bootstrap/localDeploy/1_params/"env".tfvars |
| `locationShort` | string    | Short form of the Azure region for resources.                    | bootstrap/localDeploy/1_params/"env".tfvars |
| `environment`| string       | The environment for which the resources are being created (e.g., dev, tst, uat, prd). | bootstrap/localDeploy/1_params/"env".tfvars |
| `app_short`  | string       | Short form of the application for resources.                     | bootstrap/localDeploy/1_params/"env".tfvars |

**Default for `tags`:**
- Service: TBC
- Environment: TBC
- Creator: TBC
- ReviewDate: YY/MM

---

## State Variables

| Name                | Type         | Description                                      | Source         |
|---------------------|--------------|--------------------------------------------------|----------------|
| `subscriptionId_State` | string    | Subscription ID for the Terraform State resources.| bootstrap/localDeploy/1_params/"env".tfvars |
| `tags_state`        | map(string)  | Additional or override tags for state resources.  | bootstrap/localDeploy/1_params/"env".tfvars |
| `rgName_state`      | string       | Name of the resource group.                       | bootstrap/localDeploy/1_params/terraform.tfvars |
| `saName_state`      | string       | Name of the storage account.                      | bootstrap/localDeploy/1_params/terraform.tfvars |
| `containers_state`  | map(object)  | Containers to create in the storage account.      | bootstrap/localDeploy/1_params/"env".tfvars |

**`containers_state` object:**
- `name` (string): Name of the container
- `public_access` (string, optional): Public access level (default: null)

---

## Identity Variables

| Name                | Type         | Description                                      | Source         |
|---------------------|--------------|--------------------------------------------------|----------------|
| `subscriptionId_umi`| string       | Subscription ID for the Terraform State resources.| bootstrap/localDeploy/1_params/"env".tfvars |
| `tags_umi`          | map(string)  | Additional or override tags for state resources.  | bootstrap/localDeploy/1_params/"env".tfvars |
| `rgName_umi`        | string       | Name of the resource group.                       | bootstrap/localDeploy/1_params/terraform.tfvars |
| `umiName_tf`        | string       | Name of the user managed identity.                | bootstrap/localDeploy/1_params/terraform.tfvars |

---

## Service Connection (SC) Variables

| Name                         | Type    | Description                                                                  | Source                                             |
|------------------------------|---------|------------------------------------------------------------------------------|----------------------------------------------------|
| `subscriptionId_Application` | string  | Azure Subscription ID for Application/Workload deployment.                   | bootstrap/localDeploy/1_params/"env".tfvars       |
| `subscriptionName_Application` | string| Azure Subscription Name for Application/Workload deployment.                 | bootstrap/localDeploy/1_params/"env".tfvars       |
| `serviceConnectionName_Build`  | string| Name for the build service connection (ADO legacy naming retained).          | bootstrap/localDeploy/1_params/terraform.tfvars    |
| `serviceConnectionName_Deploy` | string| Name for the deploy service connection (ADO legacy naming retained).         | bootstrap/localDeploy/1_params/terraform.tfvars    |
| `scDescription`               | string | Description for the service connection (OIDC federated credentials).         | Default in variables.tf  |
| `adoPAT`                      | string | Azure DevOps Personal Access Token (used only for ADO flows).                | Runtime (passed via scripts), default null         |
| `adoOrgUrl`                   | string | Azure DevOps organization URL (used only for ADO flows).                     | bootstrap/localDeploy/1_params/terraform.tfvars    |
| `adoProjectId`                | string | Azure DevOps project ID (used only for ADO flows).                           | bootstrap/localDeploy/1_params/terraform.tfvars    |

---

## GitHub Variables

| Name                          | Type   | Description                                                                 | Source                                             |
|-------------------------------|--------|-----------------------------------------------------------------------------|----------------------------------------------------|
| `ghPAT`                       | string | GitHub Personal Access Token (used to manage envs/secrets).                 | Runtime (passed via scripts), default null         |
| `orgName_gh`                  | string | GitHub organization (or user) name containing the repository.               | bootstrap/localDeploy/1_params/terraform.tfvars    |
| `repositoryName_gh`           | string | GitHub repository name containing the environment.                          | bootstrap/localDeploy/1_params/terraform.tfvars    |
| `preventSelfReviewDeploy_gh`  | bool   | GitHub Org Required to set up a team, Repo will need to be Public OR A Github Enterprise account will be required.  Prevent reviewers from self-approving in the deploy environment.            | bootstrap/localDeploy/1_params/"env".tfvars       |
| `deployApprovalRequired`      | bool   | GitHub Org Required to set up a team, Repo will need to be Public OR A Github Enterprise account will be required.  Whether deploy environment requires approvals (module-level usage).          | bootstrap/localDeploy/1_params/"env".tfvars       |

---

## Notes
- All variables without a default value are required.
- Update the default values as needed for your environment.
- Use the `environment` and `location` variables to control deployment context.
 - PAT variables (`adoPAT`, `ghPAT`) are injected at runtime by scripts: see [bootstrap/templates/scripts/tf-plan-local.ps1](../bootstrap/templates/scripts/tf-plan-local.ps1) and [bootstrap/templates/scripts/tf-apply-local.ps1](../bootstrap/templates/scripts/tf-apply-local.ps1).
 - Cross-environment defaults (like names for RG/SA/UMI and service connection names) live in [bootstrap/localDeploy/1_params/terraform.tfvars](../bootstrap/localDeploy/1_params/terraform.tfvars). Environment-specific values (e.g., locations, tags, subscription IDs) live in the corresponding [bootstrap/localDeploy/1_params/dev.tfvars](../bootstrap/localDeploy/1_params/dev.tfvars) (and `tst/uat/prd`.tfvars).
