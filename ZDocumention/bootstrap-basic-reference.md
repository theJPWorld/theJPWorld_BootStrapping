## [🏠 HOME](../ReadMe.md)

# Basic Bootstrapper  

The `bootstrap-basic-deploy.ps1` script automates the initialization and deployment of environment-specific Terraform resources for Azure. It prepares variable files, then runs the bootstrap process for one or more environments (such as dev, test, UAT, or prod) by invoking the `bootstrap-basic.ps1` script with the appropriate environment and tenant ID. This ensures that all required infrastructure and configuration is set up consistently for each environment, streamlining the deployment process and reducing manual setup steps.

## What the Terraform Directories Deploy

- **userMI/terraform/**: Contains Terraform configuration for deploying a User Managed Identity (UserMI) in Azure. This identity is used to securely run automation or access Azure resources with least-privilege permissions, and is often assigned to resources or pipelines that require Azure access. These are:
    - Resource group  
    *default name: "rg-umi-`${var.app_short}`-`${var.environment}`-`${var.locationShort}`-01"*
    - User Managed Identity Build  
    *default name: umi-tfbuild-`${var.app_short}`-`${var.environment}`-`${var.locationShort}`*
    - User Managed Identity Deploy  
    *default name: umi-tfdeploy-`${var.app_short}`-`${var.environment}`-`${var.locationShort}`*

- **tfstate/terraform/**: Contains the core Terraform configuration for provisioning foundational Azure resources required for bootstrapping. These are:
    - Resource group  
    *default name: "rg-tfstate-`${var.app_short}`-`${var.environment}`-`${var.locationShort}`-01"*
    - Storage account (for Terraform state)  
    *default name: "sttfstate`${var.app_short}{var.environment}${var.locationShort}`"*
    - State containers/blobs
    *default containers:  
    "Network",  
    "Infra"*

User MI Resources are instantiated through three module calls in [bootstrap/localDeploy/userMI/terraform/main.tf](../bootstrap/localDeploy/userMI/terraform/main.tf):
- `resourcegroup-umi`
- `umi_tf_build`
- `umi_tf_deploy`

State Resources are instantiated through two module calls in [bootstrap/localDeploy/tfstae/terraform/main.tf](../bootstrap/localDeploy/tfstate/terraform/main.tf):
- `resourcegroup-state`
- `storageaccount-state`

Each module uses Azure Verified Modules as it's source.

## How To Use this BootStrapper

### Prerequisites

- **Terraform**: Installed and available on `PATH`.
- **Azure Subscription**: You have the correct subscription and permissions to deploy resources.

### Inputs and Variables

See the [Variables Reference](ZDocumention/variables-reference.md) guide for details on the the variables used.

Variables for the basic bootstrap are defined in [bootstrap/localDeploy/1_params/variables.tf](../bootstrap/localDeploy/1_params/variables.tf). See [link.](ZDocumention/variables-reference.md) for more information.  
Environment-scoped values come from [bootstrap/localDeploy/1_params/](../bootstrap/localDeploy/1_params) `*.tfvars`. Ensure these are up-to-date for each environment.

### Script Workflow

1. **Populate local and variables files**: [bootstrap/localDeploy/2_deploymentScripts/bootstrap-basic-deploy.ps1](../bootstrap/localDeploy/2_deploymentScripts/bootstrap-basic-deploy.ps1) runs [bootstrap/templates/scripts/z-tf-files-populate-orchestration.ps1](../bootstrap/templates/scripts/z-tf-files-populate-orchestration.ps1) to prepare `variables.tf` and related files from `1_params`.
2. **Bootstrap Basic**: Calls [bootstrap/templates/scripts/bootstrap-basic.ps1](../bootstrap/templates/scripts/bootstrap-basic.ps1) per environment to:
    - `az login` to the specified tenant.
    - Run `tf-init-local.ps1`, `tf-plan-local.ps1`, and `tf-apply-local.ps1` for the `userMI` and `tfstate` workloads.

The Terraform scripts operate in [bootstrap/localDeploy/userMI/terraform](../bootstrap/localDeploy/userMI/terraform) and [bootstrap/localDeploy/tfstate/terraform](../bootstrap/localDeploy/tfstate/terraform) and use the AzureRM provider defined in their respective `providers.tf` files.

### How To Run

- Edit environments in [../bootstrap/localDeploy/2_deploymentScripts/bootstrap-basic-deploy.ps1](../bootstrap/localDeploy/2_deploymentScripts/bootstrap-basic-deploy.ps1) (comment/uncomment blocks).
- Run the orchestrator:

```powershell
./bootstrap/localDeploy/2_deploymentScripts/bootstrap-basic-deploy.ps1
```

## Security Notes

- **None to note**

## Troubleshooting

- **None to note**

## File Map

- Orchestrator: [bootstrap/localDeploy/2_deploymentScripts/bootstrap-basic-deploy.ps1](../bootstrap/localDeploy/2_deploymentScripts/bootstrap-basic-deploy.ps1)
- Inner bootstrap: [bootstrap/templates/scripts/bootstrap-basic.ps1](../bootstrap/templates/scripts/bootstrap-basic.ps1)
- Workload Terraform: 
 - [bootstrap/localDeploy/userMI/terraform](../bootstrap/localDeploy/userMI/terraform)
 - [bootstrap/localDeploy/tfstate/terraform](../bootstrap/localDeploy/tfstate/terraform)
- Module implementation: [templates/terraform/modules/service-connection](../templates/terraform/modules/service-connection)
- Environment params: [bootstrap/localDeploy/1_params](../bootstrap/localDeploy/1_params)
