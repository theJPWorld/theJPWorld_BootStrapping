param(
	[Parameter(Mandatory = $true, HelpMessage = "Deployment environment (e.g., dev, prd)")]
	[string]$Environment,

	[Parameter(Mandatory = $true, HelpMessage = "Azure Tenant ID")]
	[string]$TenantID,

	[Parameter(Mandatory=$false, HelpMessage="Azure DevOps Personal Access Token")]
	[string]$PAT
)

# Interactive login to Azure with specified tenant ID
az login --tenant "$TenantID"

Write-Host "Starting Bootstrap for User Managed Identities for Deployment for $Environment environment."
# Run tf-init for your User Managed Identities for Deployment
./bootstrap/templates/scripts/tf-init-local.ps1 -Workload ghFedEnv -PAT $PAT

# Run tf-plan for your User Managed Identities for Deployment
$planResult = ./bootstrap/templates/scripts/tf-plan-local.ps1 -Workload ghFedEnv -Environment "$Environment" -PAT $PAT
if ($LASTEXITCODE -ne 0) {
	Write-Error "tf-plan-local.ps1 failed with exit code $LASTEXITCODE. Stopping script."
	exit $LASTEXITCODE
}
Write-Host "Planned Terraform for ghFedEnv."
Start-Sleep -Seconds 5

# Run tf-apply for your User Managed Identities for Deployment
$applyResult = ./bootstrap/templates/scripts/tf-apply-local.ps1 -Workload ghFedEnv -Environment "$Environment" -PAT $PAT
if ($LASTEXITCODE -ne 0) {
	Write-Error "tf-apply-local.ps1 failed with exit code $LASTEXITCODE. Stopping script."
	exit $LASTEXITCODE
}
Write-Host "ghFedEnv for $Environment environment, Bootstrapped successfully."
Start-Sleep -Seconds 5
