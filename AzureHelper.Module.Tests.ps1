$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$Module = 'AzureLabHelper'

Describe "$Module Module Tests" {
        Context "Module Setup" {
        It "has root module file $Module.psm1"{
            "$Here\$Module.psm1" | Should Exist 
        }
        It "has manifest file $Module.psd1" {
            "$Here\$Module.psd1" | Should Exist
            "$Here\$Module.psd1" | Should Contain "$Module.psm1"
        }
        It "$Module folder has functions" {
            "$Here\function-*.ps1" | Should Exist
        }
        It "$Module should contain valid PowerShell code" {
            $PsFile = Get-Content $Here\$Module.psm1
            $Errors = $Null
            [System.Management.Automation.PSParser]::Tokenize($PsFile,[ref]$Errors) | Out-Null
            $errors.Count | Should be 0
        }
    } # Context "Module Setup"

    $Functions = @("New-LabRG")

    foreach ($Function in $Functions) {
        Context "Test Function $Function" {
            It "Function-$Function.ps1 should exist" {
                "$Here\Function-$Function.ps1" | Should Exist
            }
            It "Function-$Function.ps1 should contain a SYNOPSIS" {
                "$Here\Function-$Function.ps1" | Should Contain ".SYNOPSIS"
            }
            It "Function-$Function.ps1 should contain a DESCRIPTION" {
                "$Here\Function-$Function.ps1" | Should Contain ".DESCRIPTION"
            }
            It "Function-$Function.ps1 should contain an EXAMPLE" {
                "$Here\Function-$Function.ps1" | Should Contain ".EXAMPLE"
            }
            It "Function-$Function.ps1 should define an Advanced Function" {
                "$Here\Function-$Function.ps1" | Should Contain 'CmdletBinding'

            }
            It "Function-$Function.ps1  should have tests" {
                "$Here\Function-$Function.Tests.ps1" | Should Exist
            }
        } # Context "Test Function $Function"
    } # foreach
} # Describe "$Module Module Tests"

