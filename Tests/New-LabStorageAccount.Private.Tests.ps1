$module = "AzureLabHelper"
$function = "New-LabStorageAccount"

Get-Module $module | Remove-Module -Force
Import-Module $PSScriptRoot\..\$module.psm1 -Force

Describe "$function unit tests" -Tags "Unit" {
  InModuleScope AzureLabHelper {
      $cmdlet = Get-Command New-LabStorageAccount 
      Context "New-LabStorageAccount supports the expected parameters" {
          It "New-LabStorageAccount supports exactly 12 parameters" {
              $cmdlet.Parameters.Count | Should Be 12
          }
          It "New-LabStorageAccount supports the 'ResourceGroup' parameter" {
              $cmdlet.Parameters.Keys.Contains("ResourceGroup") |
                Should Be $true
          }
      } # Context "New-LabStorageAccount supports the expected parameters" 

    Context "$function returns the expected object" {
        Mock New-AzureRmStorageAccount {
            $mockData = @'
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>Microsoft.Azure.Commands.Management.Storage.Models.PSStorageAccount</T>
      <T>System.Object</T>
    </TN>
    <ToString>Microsoft.Azure.Commands.Management.Storage.Models.PSStorageAccount</ToString>
    <Props>
      <S N="ResourceGroupName">coreinfra</S>
      <S N="StorageAccountName">wibbler2043</S>
      <S N="Id">/subscriptions/f4a4040f-1f28-4c55-ae0c-b14ad0f38a87/resourceGroups/coreinfra/providers/Microsoft.Storage/storageAccounts/wibbler2043</S>
      <S N="Location">northeurope</S>
      <Obj N="Sku" RefId="1">
        <TN RefId="1">
          <T>Microsoft.Azure.Management.Storage.Models.Sku</T>
          <T>System.Object</T>
        </TN>
        <ToString>Microsoft.Azure.Management.Storage.Models.Sku</ToString>
        <Props>
          <S N="Name">StandardLRS</S>
          <S N="Tier">Standard</S>
        </Props>
      </Obj>
      <Obj N="Kind" RefId="2">
        <TN RefId="2">
          <T>Microsoft.Azure.Management.Storage.Models.Kind</T>
          <T>System.Enum</T>
          <T>System.ValueType</T>
          <T>System.Object</T>
        </TN>
        <ToString>Storage</ToString>
        <I32>0</I32>
      </Obj>
      <Nil N="Encryption" />
      <Nil N="AccessTier" />
      <DT N="CreationTime">2016-08-21T18:13:00.6299341Z</DT>
      <Nil N="CustomDomain" />
      <Nil N="LastGeoFailoverTime" />
      <Obj N="PrimaryEndpoints" RefId="3">
        <TN RefId="3">
          <T>Microsoft.Azure.Management.Storage.Models.Endpoints</T>
          <T>System.Object</T>
        </TN>
        <ToString>Microsoft.Azure.Management.Storage.Models.Endpoints</ToString>
        <Props>
          <S N="Blob">https://wibbler2043.blob.core.windows.net/</S>
          <S N="Queue">https://wibbler2043.queue.core.windows.net/</S>
          <S N="Table">https://wibbler2043.table.core.windows.net/</S>
          <S N="File">https://wibbler2043.file.core.windows.net/</S>
        </Props>
      </Obj>
      <S N="PrimaryLocation">northeurope</S>
      <Obj N="ProvisioningState" RefId="4">
        <TN RefId="4">
          <T>Microsoft.Azure.Management.Storage.Models.ProvisioningState</T>
          <T>System.Enum</T>
          <T>System.ValueType</T>
          <T>System.Object</T>
        </TN>
        <ToString>Succeeded</ToString>
        <I32>2</I32>
      </Obj>
      <Nil N="SecondaryEndpoints" />
      <Nil N="SecondaryLocation" />
      <Obj N="StatusOfPrimary" RefId="5">
        <TN RefId="5">
          <T>Microsoft.Azure.Management.Storage.Models.AccountStatus</T>
          <T>System.Enum</T>
          <T>System.ValueType</T>
          <T>System.Object</T>
        </TN>
        <ToString>Available</ToString>
        <I32>0</I32>
      </Obj>
      <Nil N="StatusOfSecondary" />
      <Obj N="Tags" RefId="6">
        <TN RefId="6">
          <T>System.Collections.Generic.Dictionary`2[[System.String, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089],[System.String, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]</T>
          <T>System.Object</T>
        </TN>
        <DCT />
      </Obj>
      <Obj N="Context" RefId="7">
        <TN RefId="7">
          <T>Microsoft.WindowsAzure.Commands.Common.Storage.LazyAzureStorageContext</T>
          <T>Microsoft.WindowsAzure.Commands.Common.Storage.AzureStorageContext</T>
          <T>System.Object</T>
        </TN>
        <ToString>Microsoft.WindowsAzure.Commands.Common.Storage.LazyAzureStorageContext</ToString>
        <Props>
          <S N="BlobEndPoint">https://wibbler2043.blob.core.windows.net/</S>
          <S N="TableEndPoint">https://wibbler2043.table.core.windows.net/</S>
          <S N="QueueEndPoint">https://wibbler2043.queue.core.windows.net/</S>
          <S N="FileEndPoint">https://wibbler2043.file.core.windows.net/</S>
          <S N="StorageAccount">BlobEndpoint=https://wibbler2043.blob.core.windows.net/;QueueEndpoint=https://wibbler2043.queue.core.windows.net/;TableEndpoint=https://wibbler2043.table.core.windows.net/;FileEndpoint=https://wibbler2043.file.core.windows.net/;AccountName=wibbler2043;AccountKey=[key hidden]</S>
          <S N="StorageAccountName">wibbler2043</S>
          <Ref N="Context" RefId="7" />
          <S N="Name">wibbler2043</S>
          <S N="EndPointSuffix">core.windows.net/</S>
        </Props>
      </Obj>
    </Props>
  </Obj>
</Objs>
'@
            $output = [System.Management.Automation.PSSerializer]::Deserialize($mockData)

            Return $output
        } # Mock New-AzureRmStorageAccount

        $mockResourceGroup = @'
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
        $mockInput = [System.Management.Automation.PSSerializer]::Deserialize($mockResourceGroup)
        $storageAccount = New-LabStorageAccount -ResourceGroup $mockInput
        It "$function returns a PSStorageAccount object" {
            $storageAccount.ToString() |
              Should Be "Microsoft.Azure.Commands.Management.Storage.Models.PSStorageAccount"
        }
    } # Context "$function returns the expected object"
} # Describe "$function unit tests" -Tags "Unit"

Describe "$function Acceptence Tests" -Tags "Acceptance" {
    $StorageAccount = New-LabStorageAccount -ResourceGroup "PesterTest"
    Context "$function returns the expected object" {
        $ResourceGroup = New-LabRG -ResourceGroupPrefix "PesterTest"

        It "$function returns a 'PSResourceGroup' object" {
            $ResourceGroup.GetType().Name | Should Be "PSResourceGroup"
        }
    } # Context "$function returns the expected object"
  }
}