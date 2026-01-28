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
| `rgName_state`      | string       | Name of the resource group.                       | bootstrap/localDeploy/1_params/variables.tf |
| `saName_state`      | string       | Name of the storage account.                      | bootstrap/localDeploy/1_params/variables.tf |
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
| `rgName_umi`        | string       | Name of the resource group.                       | bootstrap/localDeploy/1_params/variables.tf |
| `umiName_tf`        | string       | Name of the user managed identity.                | bootstrap/localDeploy/1_params/variables.tf |

---

## Notes
- All variables without a default value are required.
- Update the default values as needed for your environment.
- Use the `environment` and `location` variables to control deployment context.
