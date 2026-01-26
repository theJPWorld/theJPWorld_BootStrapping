.\bootstrap\templates\scripts\VariablesTF-Populate.ps1 -SourceFile "bootstrap\localDeploy\params\variables.tf" -DestinationFile "bootstrap\localDeploy\tfstate\terraform\variables.tf"
Write-Host "Populated 'variables.tf' for Terraform State."
.\bootstrap\templates\scripts\VariablesTF-Populate.ps1 -SourceFile "bootstrap\localDeploy\params\variables.tf" -DestinationFile "bootstrap\localDeploy\userMI\terraform\variables.tf"
Write-Host "Populated 'variables.tf' for User Managed Identity."