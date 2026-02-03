param(
	[Parameter(Mandatory=$true, HelpMessage="Name of the tfstate directory (e.g., tfstate, userMI)")]
	[string]$Workload,

	[Parameter(Mandatory=$false, HelpMessage="Azure DevOps Personal Access Token")]
	[string]$PAT
)


$tfDir = "bootstrap/localDeploy/$Workload/terraform"

Write-Host "Starting TF Init for $Workload"
if ($Workload -eq "adoFedSC") {
	terraform -chdir="$tfDir" init -backend=false -var "adoPAT=$PAT"
} elseif ($Workload -eq "ghFedEnv") {
	terraform -chdir="$tfDir" init -backend=false -var "ghPAT=$PAT"
} else {
	terraform -chdir="$tfDir" init -backend=false
}
Write-Host "Terraform init completed for $Workload."