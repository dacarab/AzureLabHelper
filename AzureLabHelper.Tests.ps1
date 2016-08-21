$Module = "AzureLabHelper"

Import-Module Pester

Get-Module $Module | Remove-Module -Force
Import-Module $PSScriptRoot\$Module.psm1 -Force

Invoke-Pester ".\Tests\$Module.Module.Tests.ps1"
Invoke-Pester ".\Tests\New-LabRG.Tests.ps1" -Tag "Unit"