param(
	[Parameter(Mandatory = $true, HelpMessage = "Deployment environment (e.g., dev, prd)")]
	[string]$Environment,

	[Parameter(Mandatory = $true, HelpMessage = "Azure Tenant ID")]
	[string]$TenantID
)

# Interactive login to Azure with specified tenant ID
az login --tenant "$TenantID"

Write-Host "Starting Bootstrap for User Managed Identities for Deployment for $Environment environment."
# Run tf-init for your User Managed Identities for Deployment
./bootstrap/templates/scripts/tf-init-local.ps1 -Workload userMI

# Run tf-plan for your User Managed Identities for Deployment
$planResult = ./bootstrap/templates/scripts/tf-plan-local.ps1 -Workload userMI -Environment "$Environment"
if ($LASTEXITCODE -ne 0) {
	Write-Error "tf-plan-local.ps1 failed with exit code $LASTEXITCODE. Stopping script."
	exit $LASTEXITCODE
}
Write-Host "Planned Terraform for userMI."
Start-Sleep -Seconds 5

# Run tf-apply for your User Managed Identities for Deployment
$applyResult = ./bootstrap/templates/scripts/tf-apply-local.ps1 -Workload userMI -Environment "$Environment"
if ($LASTEXITCODE -ne 0) {
	Write-Error "tf-apply-local.ps1 failed with exit code $LASTEXITCODE. Stopping script."
	exit $LASTEXITCODE
}
Write-Host "userMI for $Environment environment, Bootstrapped successfully."
Start-Sleep -Seconds 5

Write-Host "Starting Bootstrap for TF State for Deployment for $Environment environment."
# Run tf-init for your TF State for Deployment
./bootstrap/templates/scripts/tf-init-local.ps1 -Workload tfstate

# Run tf-plan for your TF State for Deployment
$planResult = ./bootstrap/templates/scripts/tf-plan-local.ps1 -Workload tfstate -Environment "$Environment"
if ($LASTEXITCODE -ne 0) {
	Write-Error "tf-plan-local.ps1 failed with exit code $LASTEXITCODE. Stopping script."
	exit $LASTEXITCODE
}
Write-Host "Planned Terraform for tfstate."
Start-Sleep -Seconds 5

# Run tf-apply for your TF State for Deployment
$applyResult = ./bootstrap/templates/scripts/tf-apply-local.ps1 -Workload tfstate -Environment "$Environment"
if ($LASTEXITCODE -ne 0) {
	Write-Error "tf-apply-local.ps1 failed with exit code $LASTEXITCODE. Stopping script."
	exit $LASTEXITCODE
}
Write-Host "tfstate for $Environment environment, Bootstrapped successfully."
Start-Sleep -Seconds 5

