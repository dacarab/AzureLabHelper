$Module = 'AzureLabHelper'
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModulePath = Split-Path -Parent $Here

Describe "$Module Module Tests" {
        Context "Module Setup" {
        It "has root module file $Module.psm1"{
            "$ModulePath\$Module.psm1" | Should Exist 
        }
        It "has manifest file $Module.psd1" {
            "$ModulePath\$Module.psd1" | Should Exist
            "$ModulePath\$Module.psd1" | Should Contain "$Module.psm1"
        }
        It "$Module folder has functions" {
            "$ModulePath\functions\*.ps1" | Should Exist
        }
        It "$Module should contain valid PowerShell code" {
            $PsFile = Get-Content $ModulePath\$Module.psm1
            $Errors = $Null
            [System.Management.Automation.PSParser]::Tokenize($PsFile,[ref]$Errors) | Out-Null
            $errors.Count | Should be 0
        }
    } # Context "Module Setup"

    $Functions = @("New-LabRG")

    foreach ($Function in $Functions) {
        Context "Test Function $Function" {
            It "Function-$Function.ps1 should exist" {
                "$ModulePath\Functions\$Function.ps1" | Should Exist
            }
            It "Function-$Function.ps1 should contain a SYNOPSIS" {
                "$ModulePath\Functions\$Function.ps1" | Should Contain ".SYNOPSIS"
            }
            It "Function-$Function.ps1 should contain a DESCRIPTION" {
                "$ModulePath\Functions\$Function.ps1" | Should Contain ".DESCRIPTION"
            }
            It "Function-$Function.ps1 should contain an EXAMPLE" {
                "$ModulePath\Functions\$Function.ps1" | Should Contain ".EXAMPLE"
            }
            It "Function-$Function.ps1 should define an Advanced Function" {
                "$ModulePath\Functions\$Function.ps1" | Should Contain '[CmdletBinding()]'
            }
            It "Function-$Function.ps1  should have tests" {
                "$ModulePath\Tests\$Function.Tests.ps1" | Should Exist
            }
        } # Context "Test Function $Function"
    } # foreach
} # Describe "$Module Module Tests"
