## [🏠 HOME](../ReadMe.md)

# Basic Bootstrapper  

The `bootstrap-basic-deploy.ps1` script automates the initialization and deployment of environment-specific Terraform resources for Azure. It prepares variable files, then runs the bootstrap process for one or more environments (such as dev, test, UAT, or prod) by invoking the `bootstrap-basic.ps1` script with the appropriate environment and tenant ID. This ensures that all required infrastructure and configuration is set up consistently for each environment, streamlining the deployment process and reducing manual setup steps.

### What the Terraform Directories Deploy

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



Each directory is structured to support modular, environment-specific deployments, ensuring separation of concerns and easier management of infrastructure components.

# How To Use this BootStrapper

To follow the default naming structure used above please read [this](ZDocumention/variables-reference.md) to understand the Variables used in this BootStrapper.  You should then be able to update the tfvars (found inside "bootstrap/localDeploy/1_params" folder) for the environments you require.  You can add additional tfvars by creating a new "env.tfvars" based off of an already existing one.  
  
You can then update the [Boot Strap Basic Deployment Script](../bootstrap/localDeploy/2_deploymentScripts/bootstrap-adosc-deploy.ps1) to meet your requirements by commenting in the environments you need or adding a new if you've created a different environment naming convention.