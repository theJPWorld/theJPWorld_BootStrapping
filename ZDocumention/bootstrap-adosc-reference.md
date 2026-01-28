## [🏠 HOME](../ReadMe.md)

# Azure DevOps Federated Service Connection Bootstrap

The `bootstrap-adosc-deploy.ps1` script prepares environment-specific Terraform variables and then bootstraps Azure DevOps federated service connections using the `bootstrap-ado.ps1` pipeline. This creates secure, OIDC (workload identity federation) service connections for your Azure DevOps project, bound to pre-existing User Managed Identities (UMIs) in Azure, enabling build/deploy pipelines to access Azure subscriptions without secrets.

## What This Process Deploys

- **Azure DevOps Service Connections (OIDC)** via `azuredevops_serviceendpoint_azurerm`:
  - Creates two service connections (Build and Deploy) in the target Azure DevOps project.
  - Authentication scheme: `WorkloadIdentityFederation` (OIDC) using UMI principal IDs.
- **Federated Identity Credentials** via `azurerm_federated_identity_credential`:
  - Adds federated credentials on existing UMIs so Azure DevOps can obtain tokens for Azure.

Resources are instantiated through two module calls in [bootstrap/localDeploy/adoFedSC/terraform/main.tf](bootstrap/localDeploy/adoFedSC/terraform/main.tf):
- `module.build_federated_service_connection`
- `module.deploy_federated_service_connection`

Each module sources [templates/terraform/modules/service-connection/main.tf](templates/terraform/modules/service-connection/main.tf) and requires UMI metadata from [bootstrap/localDeploy/adoFedSC/terraform/data.tf](bootstrap/localDeploy/adoFedSC/terraform/data.tf).

## Prerequisites

- **Azure CLI**: Logged into the correct tenant (`az login --tenant <TenantID>`).
- **Terraform**: Installed and available on `PATH`.
- **UMIs exist**: The UMIs referenced by `data.tf` must already exist (usually provisioned by the basic bootstrap). Names are derived from variables: `rgName_umi`, `umiName_tf`, `app_short`, `environment`, `locationShort`.
- **Azure DevOps PAT**: A PAT with permissions to create/manage service connections in the target project. Do not store the PAT in version control; provide it at runtime.

## Inputs and Variables

Variables for ADO SC are defined in [bootstrap/localDeploy/adoFedSC/terraform/variables.tf](bootstrap/localDeploy/adoFedSC/terraform/variables.tf):
- `subscriptionId_Application`, `subscriptionName_Application`: Target Azure subscription.
- `adoOrgUrl`, `adoProjectId`: Azure DevOps org/project identifiers.
- `adoPAT`: Azure DevOps Personal Access Token (provided at runtime).
- `serviceConnectionName_Build`, `serviceConnectionName_Deploy`, `scDescription`: Naming/config metadata.

Environment-scoped values come from [bootstrap/localDeploy/1_params](bootstrap/localDeploy/1_params) `*.tfvars`. Ensure these are up-to-date for each environment.

## Script Workflow

1. **Populate TF variable files**: [bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1](bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1) runs [bootstrap/templates/scripts/z-tf-files-populate-orchestration.ps1](bootstrap/templates/scripts/z-tf-files-populate-orchestration.ps1) to prepare `variables.tf` and related files from `1_params`.
2. **Prompt for PAT**: The script prompts for the PAT securely and passes it into child scripts.
3. **Bootstrap ADO SC**: Calls [bootstrap/templates/scripts/bootstrap-ado.ps1](bootstrap/templates/scripts/bootstrap-ado.ps1) per environment to:
   - `az login` to the specified tenant.
   - Run `tf-init-local.ps1`, `tf-plan-local.ps1`, and `tf-apply-local.ps1` for the `adoFedSC` workload, forwarding `-AdoPAT`.

The Terraform scripts operate in [bootstrap/localDeploy/adoFedSC/terraform](bootstrap/localDeploy/adoFedSC/terraform) and use the AzureRM + Azure DevOps providers defined in [providers.tf](bootstrap/localDeploy/adoFedSC/terraform/providers.tf).

## How To Run

- Edit environments in [bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1](bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1) (comment/uncomment blocks).
- Run the orchestrator:

```powershell
./bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1
```

- Alternatively, invoke the inner script directly:

```powershell
./bootstrap/templates/scripts/bootstrap-ado.ps1 -Environment "dev" -TenantID "<tenant-guid>" -AdoPAT "<your-PAT>"
```

## Security Notes

- **PAT handling**: Supply the PAT at runtime. Avoid committing it to files.
- **Optional env var**: You can set `TF_VAR_adoPAT` in your shell to pass it implicitly:

```powershell
$env:TF_VAR_adoPAT = '<your-PAT>'
```

- **Least privilege**: Ensure the PAT has only the scopes needed to manage service connections.

## Troubleshooting

- **Terraform prompts for `var.adoPAT`**: PAT was not passed; provide `-AdoPAT` or set `TF_VAR_adoPAT`.
- **UMI not found**: Verify the basic bootstrap created UMIs and that names (`rgName_umi`, `umiName_tf`, `app_short`, `environment`, `locationShort`) match your `1_params` values.
- **Service connection creation fails**: Check `adoOrgUrl` and `adoProjectId` are correct and the PAT has sufficient permissions.
- **Azure login issues**: Confirm `TenantID` and your Azure CLI context (`az account show`).

## File Map

- Orchestrator: [bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1](bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1)
- Inner bootstrap: [bootstrap/templates/scripts/bootstrap-ado.ps1](bootstrap/templates/scripts/bootstrap-ado.ps1)
- Workload Terraform: [bootstrap/localDeploy/adoFedSC/terraform](bootstrap/localDeploy/adoFedSC/terraform)
- Module implementation: [templates/terraform/modules/service-connection](templates/terraform/modules/service-connection)
- Environment params: [bootstrap/localDeploy/1_params](bootstrap/localDeploy/1_params)
