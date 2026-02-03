

param(
    [Parameter(Mandatory=$true, HelpMessage="Name of the tfstate directory (e.g., tfstate, userMI)")]
    [string]$Workload,

    [Parameter(Mandatory=$true, HelpMessage="Environment name (e.g., dev, prd)")]
    [string]$Environment,

    [Parameter(Mandatory=$false, HelpMessage="Azure DevOps Personal Access Token")]
    [string]$PAT
)




$tfDir = "bootstrap/localDeploy/$Workload/terraform"
$varFile = "../../1_params/$Environment.tfvars"
$gloVarFile = "../../1_params/terraform.tfvars"

Write-Host "Starting TF Plan for $Workload in $Environment environment."
if ($Workload -eq "adoFedSC") {
    terraform -chdir="$tfDir" plan -var-file="$varFile" -var-file="$gloVarFile" -var "adoPAT=$PAT"
} elseif ($Workload -eq "ghFedEnv") {
    terraform -chdir="$tfDir" plan -var-file="$varFile" -var-file="$gloVarFile" -var "ghPAT=$PAT"
} else {
    terraform -chdir="$tfDir" plan -var-file="$varFile" -var-file="$gloVarFile"
}
Write-Host "Terraform plan completed for $Workload in $Environment environment."