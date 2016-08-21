Import-Module Pester
Invoke-Pester ".\Tests\AzureLabHelper.Module.Tests.ps1"
Invoke-Pester ".\Tests\New-LabRG.Tests.ps1"