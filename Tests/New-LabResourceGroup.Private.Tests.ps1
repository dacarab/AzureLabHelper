$module = "AzureLabHelper"

Get-Module $module | Remove-Module -Force
Import-Module $PSScriptRoot\..\$module.psm1 -Force

Describe "New-LabResourceGroup Unit Tests" -Tags "Unit"{
    InModuleScope AzureLabHelper{
        $cmdlet = Get-Command New-LabResourceGroup

        Mock New-AzureRmResourceGroup {
            Param(
                [String]$Name
            )
                $mockData = @'
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceGroup</T>
      <T>System.Object</T>
    </TN>
    <ToString>Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceGroup</ToString>
    <Props>
      <S N="ResourceGroupName">PesterTest</S>
      <S N="Location">northeurope</S>
      <S N="ProvisioningState">Succeeded</S>
      <Nil N="Tags" />
      <Nil N="TagsTable" />
      <S N="ResourceId">/subscriptions/f4a4040f-1f28-4c55-ae0c-b14ad0f38a87/resourceGroups/PesterTest0001</S>
    </Props>
  </Obj>
</Objs>   
'@
                $mockData = $mockData.Replace("PesterTest",$Name)
                $Output = [System.Management.Automation.PSSerializer]::Deserialize($MockData)

                Return $Output
            } # Mock New-AzureRmResourceGroup

        Context "New-LabResourceGroup supports the expected parameters" {
            It "New-LabResourceGroup supports exactly 13 parameters" {
                $cmdlet.Parameters.count | Should Be 13
            }
            It "New-LabResourceGroup supports the 'LabName' parameter" {
                $cmdlet.Parameters.Keys.Contains("LabName") |
                  Should Be $true
            }
            It "New-LabResourceGroup supports the 'Location' parameter" {
                $cmdlet.Parameters.Keys.Contains("Location") |
                  Should Be $true
            }
        }
        Context "New-LabResourceGroup returns the expected output" {

            $ResourceGroup = New-LabResourceGroup -LabName "IntegrationTest"

            It "New-LabResourceGroup returns a 'PSResourceGroup' object " {
                $ResourceGroup.ToString() |
                  Should Be "Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceGroup"
            }
        } # Context "New-LabResourceGroup returns the expected object"
    } # InModuleScope AzureLabHelper
} # Describe "New-LabResourceGroup Tests" -Tags "Unit"

Describe "New-LabResourceGroup Acceptence Tests" -Tags "Integration" {
    $ResourceGroup = New-LabResourceGroup -ResourceGroupPrefix "PesterTest"
    Context "New-LabResourceGroup returns the expected object" {
        $ResourceGroup = New-LabResourceGroup -ResourceGroupPrefix "PesterTest"

        It "New-LabResourceGroup returns a PSResourceGroup object" {
            $ResourceGroup.GetType().Name | Should Be "PSResourceGroup"
        }
    } # Context "New-LabResourceGroup returns the expected object"
} # Describe "New-LabResourceGroup Acceptence Tests" -Tags "Integration"