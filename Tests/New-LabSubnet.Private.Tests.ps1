$module = "AzureLabHelper"
$function = "New-LabStorageAccount"

Get-Module $module | Remove-Module -Force
Import-Module $PSScriptRoot\..\$module.psm1 -Force

Describe "$function Unit Tests" -Tags "Unit" {
    InModuleScope -ModuleName AzureLabHelper {
        
    }
}