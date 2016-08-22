$module = 'AzureLabHelper'
$modulePath = Split-Path -Parent $PSScriptRoot

Describe "$module Module Tests" -Tags "Unit", "Acceptance"{
        Context "Module Setup" {
        It "has root module file $module.psm1"{
            "$modulePath\$module.psm1" | Should Exist 
        }
        It "has manifest file $module.psd1" {
            "$modulePath\$module.psd1" | Should Exist
            "$modulePath\$module.psd1" | Should Contain "$module.psm1"
        }
        It "$module folder has functions" {
            "$modulePath\functions\*.ps1" | Should Exist
        }
        It "$module should contain valid PowerShell code" {
            $PsFile = Get-Content $modulePath\$module.psm1
            $Errors = $Null
            [System.Management.Automation.PSParser]::Tokenize($PsFile,[ref]$Errors) | Out-Null
            $errors.Count | Should be 0
        }
    } # Context "Module Setup"

    $functions = Get-ChildItem -Path "$modulePath\Functions" |
      Select-Object -ExpandProperty BaseName

    foreach ($function in $functions) {
        Context "Test Function $function" {
            It "$function.ps1 should exist" {
                "$modulePath\Functions\$function.ps1" | Should Exist
            }
            It "$function.ps1 should contain a SYNOPSIS" {
                "$modulePath\Functions\$function.ps1" | Should Contain ".SYNOPSIS"
            }
            It "$function.ps1 should contain a DESCRIPTION" {
                "$modulePath\Functions\$function.ps1" | Should Contain ".DESCRIPTION"
            }
            It "$function.ps1 should contain an EXAMPLE" {
                "$modulePath\Functions\$function.ps1" | Should Contain ".EXAMPLE"
            }
            It "$function.ps1 should define an Advanced Function" {
                "$modulePath\Functions\$function.ps1" | Should Contain '[CmdletBinding()]'
            }
            It "$function.ps1 should contain valid PowerShell code" {
                $PsFile = Get-Content $modulePath\Functions\$function.ps1
                $Errors = $Null
                [System.Management.Automation.PSParser]::Tokenize($PsFile,[ref]$Errors) | Out-Null
                $errors.Count | Should be 0
            }
            It "$function.ps1 should have tests" {
                "$modulePath\Tests\$function.Tests.ps1" | Should Exist
            }
        } # Context "Test Function $function"
    } # foreach
} # Describe "$module Module Tests"

