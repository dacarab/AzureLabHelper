$Module = "AzureLabHelper"
$Function = "New-LabRG"
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe "$Function Unit Tests" -Tags "Unit"{
    InModuleScope AzureLabHelper{
        Context "$Function returns the expected object" {
        
            Mock New-AzureRmResourceGroup {
                $MockData = @'
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceGroup</T>
      <T>System.Object</T>
    </TN>
    <ToString>Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceGroup</ToString>
    <Props>
      <S N="ResourceGroupName">PesterTest0001</S>
      <S N="Location">northeurope</S>
      <S N="ProvisioningState">Succeeded</S>
      <Nil N="Tags" />
      <Nil N="TagsTable" />
      <S N="ResourceId">/subscriptions/f4a4040f-1f28-4c55-ae0c-b14ad0f38a87/resourceGroups/PesterTest0001</S>
    </Props>
  </Obj>
</Objs>   
'@
                $Output = [System.Management.Automation.PSSerializer]::Deserialize($MockData)

                Return $Output
            } # Mock New-AzureRmResourceGroup

            $ResourceGroup = New-LabRG -ResourceGroupPrefix "AcceptenceTest"

            It "$Function returns a PSResourceGroup object " {
                $ResourceGroup.ToString() |
                  Should Be "Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceGroup"
            }
        } # Context "$Function returns the expected object"
    } # InModuleScope AzureLabHelper
} # Describe "$Function Tests" -Tags "Unit"

Describe "$Function Acceptence Tests" -Tags "Acceptance" {
    $ResourceGroup = New-LabRG -ResourceGroupPrefix "PesterTest"
    Context "$Function returns the expected object" {
        $ResourceGroup = New-LabRG -ResourceGroupPrefix "PesterTest"

        It "$Function returns a PSResourceGroup object" {
            $ResourceGroup.GetType().Name | Should Be "PSResourceGroup"
        }
    } # Context "$Function returns the expected object"
}