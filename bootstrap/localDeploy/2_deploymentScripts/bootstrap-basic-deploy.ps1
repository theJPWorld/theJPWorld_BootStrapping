$TenantID = "<Fill Me In>"

Write-Host "Prepared variables.tf files from params folder."
./bootstrap/templates/scripts/z-tf-files-populate-orchestration.ps1
Write-Host "Prepared variables.tf files from params folder."

##Comment in the below for Dev environment bootstrap
Write-Host "Starting Bootstrap Basic for Dev environment."
./bootstrap/templates/scripts/bootstrap-basic.ps1 -Environment "dev" -TenantID "$TenantID"
Write-Host "Bootstrap Basic complete for Dev environment."

# ##Comment in the below for Test environment bootstrap
# Write-Host "Starting Bootstrap Basic for Tst environment."
# ./bootstrap/templates/scripts/bootstrap-basic.ps1 -Environment "tst" -TenantID "$TenantID"
# Write-Host "Bootstrap Basic complete for Tst environment."

# ##Comment in the below for SIT environment bootstrap
# Write-Host "Starting Bootstrap Basic for Sit environment."
# ./bootstrap/templates/scripts/bootstrap-basic.ps1 -Environment "sit" -TenantID "$TenantID"
# Write-Host "Bootstrap Basic complete for Sit environment."

# ##Comment in the below for UAT environment bootstrap
# Write-Host "Starting Bootstrap Basic for Uat environment."
# ./bootstrap/templates/scripts/bootstrap-basic.ps1 -Environment "uat" -TenantID "$TenantID"
# Write-Host "Bootstrap Basic complete for Uat environment."

# ##Comment in the below for Prod environment bootstrap
# Write-Host "Starting Bootstrap Basic for Prd environment."
# ./bootstrap/templates/scripts/bootstrap-basic.ps1 -Environment "prd" -TenantID "$TenantID"
# Write-Host "Bootstrap Basic complete for Prd environment."