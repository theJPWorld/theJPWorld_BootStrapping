
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

Write-Host "Starting TF apply for $Workload in $Environment environment."
if ($Workload -eq "adoFedSC") {
    terraform -chdir="$tfDir" apply -var-file="$varFile" -var-file="$gloVarFile" -var "adoPAT=$PAT" -auto-approve
} elseif ($Workload -eq "ghFedEnv") {
    terraform -chdir="$tfDir" apply -var-file="$varFile" -var-file="$gloVarFile" -var "ghPAT=$PAT" -auto-approve
} else {
    terraform -chdir="$tfDir" apply -var-file="$varFile" -var-file="$gloVarFile" -auto-approve
}
Write-Host "Terraform apply completed for $Workload in $Environment environment."
Start-Sleep -Seconds 10
Write-Host "Cleaning up local Terraform files..."
Remove-Item -Recurse -Force "$tfDir/.terraform"
Remove-Item -Force "$tfDir/.terraform.lock.hcl", "$tfDir/terraform.tfstate"
Write-Host "Cleanup completed."