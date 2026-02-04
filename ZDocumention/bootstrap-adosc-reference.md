## [🏠 HOME](../ReadMe.md)

# Azure DevOps Federated Service Connection Bootstrap

The `bootstrap-adosc-deploy.ps1` script prepares environment-specific Terraform variables and then bootstraps Azure DevOps federated service connections using the `bootstrap-ado.ps1` pipeline. This creates secure, OIDC (workload identity federation) service connections for your Azure DevOps project, bound to pre-existing User Managed Identities (UMIs) in Azure, enabling build/deploy pipelines to access Azure subscriptions without secrets.  It also creates an approvers group that is then applied (depending on flag in `env.tfvars`) to the deployment service connection as a approvals check.


## What the Terraform Directories Deploy

- **adoFedSC/terraform/**: Contains Terraform configuration for deploying a Azure DevOps Service Connections (OIDC), Federated Identity Credential in Azure the defaults for these are below:  
    - Federated Identity Credentials (Build)
    *default name: sc-build-`${var.app_short}`-`${var.environment}`-`${var.locationShort}`-01*
    - Federated Identity Credentials (Deploy)
    *default name: sc-deploy-`${var.app_short}`-`${var.environment}`-`${var.locationShort}`-01*
    - Azure DevOps Endpoint (Build) 
    *default name: sc-build-`${var.app_short}`-`${var.environment}`-`${var.locationShort}`-01*
    - Azure DevOps Endpoint (Deploy) 
    *default name: sc-deploy-`${var.app_short}`-`${var.environment}`-`${var.locationShort}`-01*
    - Azure DevOps Group
    *default name: Approvers-sc-build-`${var.app_short}`-`${var.environment}`-`${var.locationShort}`-01**

Each directory is structured to support modular, environment-specific deployments, ensuring separation of concerns and easier management of infrastructure components.

Resources are instantiated through two module calls in [bootstrap/localDeploy/adoFedSC/terraform/main.tf](../bootstrap/localDeploy/adoFedSC/terraform/main.tf):
- `module.build_federated_service_connection`
- `module.deploy_federated_service_connection`

Each module sources [templates/terraform/modules/service-connection/main.tf]../(templates/terraform/modules/service-connection/main.tf) and requires UMI metadata from [bootstrap/localDeploy/adoFedSC/terraform/data.tf](../bootstrap/localDeploy/adoFedSC/terraform/data.tf).

## How To Use this BootStrapper

### Prerequisites

- **Terraform**: Installed and available on `PATH`.
- **Azure Subscription**: You have the correct subscription and permissions to deploy resources.
- **UMIs exist**: The UMIs referenced by `data.tf` must already exist **(usually provisioned by the basic bootstrap)**. Names are derived from locals.tf
- **Azure DevOps PAT**: A PAT with permissions in the target project. Do not store the PAT in version control; provide it at runtime. [See this link for a guide on this](../ZDocumention/adosc-patscoping.md)
- **Azure DevOps Project ID**: You have used `https://dev.azure.com/<You Org Name>/_apis/projects?api-version=5.0` to retrieve the project ID.  **Tick Pretty Print to make this easier to read**



### Inputs and Variables

See the [Variables Reference](ZDocumention/variables-reference.md) guide for details on the the variables used.

Variables for the ADO service connection bootstrap are defined in [bootstrap/localDeploy/1_params/variables.tf](../bootstrap/localDeploy/1_params/variables.tf). See [link.](ZDocumention/variables-reference.md) for more information.  
Environment-scoped values come from [bootstrap/localDeploy/1_params/](../bootstrap/localDeploy/1_params) `*.tfvars`. Ensure these are up-to-date for each environment.


### Script Workflow

1. **Populate local and variables files**: [bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1](../bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1) runs [bootstrap/templates/scripts/z-tf-files-populate-orchestration.ps1](../bootstrap/templates/scripts/z-tf-files-populate-orchestration.ps1) to prepare `variables.tf` and related files from `1_params`.
2. **Prompt for PAT**: The script prompts for the PAT securely and passes it into child scripts.
3. **Bootstrap ADO SC**: Calls [bootstrap/templates/scripts/bootstrap-ado.ps1](../bootstrap/templates/scripts/bootstrap-ado.ps1) per environment to:
   - `az login` to the specified tenant.
   - Run `tf-init-local.ps1`, `tf-plan-local.ps1`, and `tf-apply-local.ps1` for the `adoFedSC` workload, forwarding `-AdoPAT`.

The Terraform scripts operate in [bootstrap/localDeploy/adoFedSC/terraform](../bootstrap/localDeploy/adoFedSC/terraform) and use the AzureRM + Azure DevOps providers defined in [providers.tf](../bootstrap/localDeploy/adoFedSC/terraform/providers.tf).


### How To Run

- Edit environments in [../bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1](../bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1) (comment/uncomment blocks).
- Run the orchestrator:

```powershell
./bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1
```

## Security Notes

- **PAT handling**: Supply the PAT at runtime. Avoid committing it to files.
- **Least privilege**: Ensure the PAT has only the scopes needed to manage service connections.


## Troubleshooting

- **None to Note**

## File Map

- Orchestrator: [bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1](../bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1)
- Inner bootstrap: [bootstrap/templates/scripts/bootstrap-ado.ps1](../bootstrap/templates/scripts/bootstrap-ado.ps1)
- Workload Terraform: [bootstrap/localDeploy/adoFedSC/terraform](../bootstrap/localDeploy/adoFedSC/terraform)
- Module implementation: [templates/terraform/modules/service-connection](../templates/terraform/modules/service-connection)
- Environment params: [bootstrap/localDeploy/1_params](../bootstrap/localDeploy/1_params)
