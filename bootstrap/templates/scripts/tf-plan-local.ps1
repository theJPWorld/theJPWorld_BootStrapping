
param(
	[Parameter(Mandatory=$true, HelpMessage="Name of the tfstate directory (e.g., tfstate, userMI)")]
	[string]$Workload,

	[Parameter(Mandatory=$true, HelpMessage="Environment name (e.g., dev, prd)")]
	[string]$Environment
)

$tfDir = "bootstrap/localDeploy/$Workload/terraform"
$varFile = "../../params/$Environment.tfvars"

Write-Host "Starting TF Plan for $Workload in $Environment environment."
terraform -chdir="$tfDir" plan -var-file="$varFile"
Write-Host "Terraform plan completed for $Workload in $Environment environment."