# What will this BootStrapper do?

## Basic Bootstrapper  

This Bootstrapper will deploy User Managed Identities for Build and Deploy Terraform processes and create the TF State Storage account with the required RBAC against the UMIs to be able to Init, Plan and Apply TF Deployments.

### How To Use this BootStrapper
[Basic Deployment ReadMe](ZDocumention/bootstrap-basic-reference.md)

## ADO Service Conenction Bootstrapper  

This Bootstrapper will configure User Managed Identities for Build and Deploy Terraform preivously deployed using Federated OIDC Service Connections in Azure DevOps and configure the Azure DevOps Service Connections.

### How To Use this BootStrapper
[ADO Service Connection Deployment ReadMe](ZDocumention/bootstrap-adosc-reference.md)

## GitHub Service Conenction Bootstrapper  

This Bootstrapper will configure User Managed Identities for Build and Deploy Terraform preivously deployed using Federated OIDC Service Connections in GitHub and configure the GitHub Service Connections.  
  
**Please pay particular attention to the GitHub Variables inside the variable markdown!**

### How To Use this BootStrapper
[GitHub Service Connection Deployment ReadMe](ZDocumention/bootstrap-ghsc-reference.md)

# Approval Groups

## ADO Group  

Head to the below link to see the approval groups in Azure DevOps and add members to it.  
`https://dev.azure.com/<Your Org>/<ADO Project Name>/_settings/permissions`

## GitHub Team  

Head to the below link to see the approval teams in GitHub and add members to it.  
`https://github.com/orgs/<Your Org>/teams`