param(
	[Parameter(Mandatory=$true, HelpMessage="Name of the tfstate directory (e.g., tfstate, userMI)")]
	[string]$Workload,

	[Parameter(Mandatory=$false, HelpMessage="Azure DevOps Personal Access Token")]
	[string]$AdoPAT
)


$tfDir = "bootstrap/localDeploy/$Workload/terraform"

Write-Host "Starting TF Init for $Workload"
terraform -chdir="$tfDir" init -backend=false -var "adoPAT=$AdoPAT"
Write-Host "Terraform init completed for $Workload."