param(
	[Parameter(Mandatory=$true, HelpMessage="Name of the tfstate directory (e.g., tfstate, userMI)")]
	[string]$Workload
)

$tfDir = "bootstrap/localDeploy/$Workload/terraform"

Write-Host "Starting TF Init for $Workload"
terraform -chdir="$tfDir" init -backend=false
Write-Host "Terraform init completed for $Workload."