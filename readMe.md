# What will this BootStrapper do?

# Basic Bootstrapper  

This will create your core Azure resources for TF State and UMI for Terraform build and deploy actions.  
[Basic Deployment ReadMe](ZDocumention\bootstrap-basic-reference.md)


## How To Use this BootStrapper

To follow the default naming structure used above please read [this](ZDocumention/variables-reference.md) to understand the Variables used in this BootStrapper.  You should then be able to update the tfvars (found inside "bootstrap/localDeploy/params" folder) for the environments you require.  You can add additional tfvars by creating a new "env.tfvars" based off of an already existing one.  
  

You can then update the [Boot Strap Basic Deployment Script](bootstrap/localDeploy/deploymentScripts/bootstrap-basic-deploy.ps1) to meet your requirements by commenting in the environments you need or adding a new if you've created a different environment naming convention.