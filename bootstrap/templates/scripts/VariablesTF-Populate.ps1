param(
    [Parameter(Mandatory=$true, HelpMessage="Path to the source variables.tf file")]
    [string]$SourceFile,

    [Parameter(Mandatory=$true, HelpMessage="Path to the destination variables.tf file")]
    [string]$DestinationFile,

    [switch]$Append = $false
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $SourceFile)) {
    Write-Error "Source file '$SourceFile' does not exist."
    exit 1
}

# Create destination directory if it doesn't exist
$destDir = Split-Path $DestinationFile -Parent
if (-not (Test-Path $destDir) -and $destDir -ne "") {
    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    Write-Host "Created directory '$destDir'."
}

$content = Get-Content $SourceFile -Raw

if ($Append) {
    Add-Content -Path $DestinationFile -Value "`r`n$content" -Encoding UTF8
    Write-Host "Appended contents of '$SourceFile' to '$DestinationFile'."
} else {
    Set-Content -Path $DestinationFile -Value $content -Encoding UTF8
    Write-Host "Copied contents of '$SourceFile' to '$DestinationFile'."
}
