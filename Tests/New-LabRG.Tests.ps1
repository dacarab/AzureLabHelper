$Module = "AzureLabHelper"
$Function = "New-LabRG"
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

Get-Module $Module | Remove-Module -Force

Import-Module $Here\..\$Module.psm1 -Force

Describe '$Module Tests'{
    $ResourceGroup = New-LabRG -ResourceGroupPrefix "PesterTests"
    
    Context "$Function returns the expected object" {
        It "$Function returns a PSResourceGroup object" {
            $ResourceGroup.GetType().Name | Should Be "PSResourceGroup"
        }
    }
} 