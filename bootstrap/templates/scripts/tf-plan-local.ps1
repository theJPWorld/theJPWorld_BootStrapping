

param(
    [Parameter(Mandatory=$true, HelpMessage="Name of the tfstate directory (e.g., tfstate, userMI)")]
    [string]$Workload,

    [Parameter(Mandatory=$true, HelpMessage="Environment name (e.g., dev, prd)")]
    [string]$Environment,

    [Parameter(Mandatory=$false, HelpMessage="Azure DevOps Personal Access Token")]
    [string]$AdoPAT
)


$tfDir = "bootstrap/localDeploy/$Workload/terraform"
$varFile = "../../1_params/$Environment.tfvars"

Write-Host "Starting TF Plan for $Workload in $Environment environment."
if ($Workload -eq "adoFedSC") {
    terraform -chdir="$tfDir" plan -var-file="$varFile" -var "adoPAT=$AdoPAT"
} else {
    terraform -chdir="$tfDir" plan -var-file="$varFile"
}
Write-Host "Terraform plan completed for $Workload in $Environment environment."