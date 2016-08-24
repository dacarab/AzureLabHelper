$module = "AzureLabHelper"

Get-Module $module | Remove-Module -Force
Import-Module $PSScriptRoot\..\$module.psm1 -Force
Import-Module AzureRM.Network

Describe "New-LabSubnet Unit Tests" -Tags "Unit" {
    InModuleScope -ModuleName AzureLabHelper {
        $cmdlet = Get-Command New-LabSubnet

        Context "New-LabSubnet supports the expected parameters" {
            It "New-LabSubnet supports exactly 13 parameters" {
                $cmdlet.Parameters.Count | Should Be 13
            }
            It "New-LabSubnet supports the 'VNetwork' parameter" {
                $cmdlet.Parameters.Keys.Contains("VNetwork") |
                  Should Be $true
            }
            It "New-LabSubnet supports the 'ResourceGroup' parameter" {
                $cmdlet.Parameters.Keys.Contains("ResourceGroup") |
                  Should Be $true
            }
        } # Context "New-LabSubnet supports the expected parameters" 

<# Pester currently can't mock AzureRm cmdlets
        Context "New-LabSubnet should return the expected output" {
            Mock Add-AzureRmVirtualNetworkSubnetConfig -ModuleName AzureLabHelper {
                Return "El Wibbler"
            }
            
            Mock Set-AzureRmVirtualNetwork -ModuleName AzureLabHelper {
                                                                                                                                                                                                                                                                                                                                                                                        $mockData = @'
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork</T>
      <T>Microsoft.Azure.Commands.Network.Models.PSTopLevelResource</T>
      <T>Microsoft.Azure.Commands.Network.Models.PSChildResource</T>
      <T>Microsoft.Azure.Commands.Network.Models.PSResourceId</T>
      <T>System.Object</T>
    </TN>
    <ToString>Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork</ToString>
    <Props>
      <Obj N="AddressSpace" RefId="1">
        <TN RefId="1">
          <T>Microsoft.Azure.Commands.Network.Models.PSAddressSpace</T>
          <T>System.Object</T>
        </TN>
        <ToString>Microsoft.Azure.Commands.Network.Models.PSAddressSpace</ToString>
        <Props>
          <Obj N="AddressPrefixes" RefId="2">
            <TN RefId="2">
              <T>System.Collections.Generic.List`1[[System.String, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]</T>
              <T>System.Object</T>
            </TN>
            <LST>
              <S>10.0.0.0/16</S>
            </LST>
          </Obj>
        </Props>
      </Obj>
      <Nil N="DhcpOptions" />
      <Obj N="Subnets" RefId="3">
        <TN RefId="3">
          <T>System.Collections.Generic.List`1[[Microsoft.Azure.Commands.Network.Models.PSSubnet, Microsoft.Azure.Commands.Network, Version=2.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]</T>
          <T>System.Object</T>
        </TN>
        <LST>
          <Obj RefId="4">
            <TN RefId="4">
              <T>Microsoft.Azure.Commands.Network.Models.PSSubnet</T>
              <T>Microsoft.Azure.Commands.Network.Models.PSChildResource</T>
              <T>Microsoft.Azure.Commands.Network.Models.PSResourceId</T>
              <T>System.Object</T>
            </TN>
            <ToString>Microsoft.Azure.Commands.Network.Models.PSSubnet</ToString>
            <Props>
              <S N="AddressPrefix">10.0.255.0/24</S>
              <Obj N="IpConfigurations" RefId="5">
                <TN RefId="5">
                  <T>System.Collections.Generic.List`1[[Microsoft.Azure.Commands.Network.Models.PSIPConfiguration, Microsoft.Azure.Commands.Network, Version=2.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]</T>
                  <T>System.Object</T>
                </TN>
                <LST />
              </Obj>
              <Nil N="NetworkSecurityGroup" />
              <Nil N="RouteTable" />
              <S N="ProvisioningState">Succeeded</S>
              <S N="IpConfigurationsText">[]</S>
              <S N="NetworkSecurityGroupText">null</S>
              <S N="RouteTableText">null</S>
              <S N="Name">demo</S>
              <S N="Etag">W/"730cd6b5-fe00-4329-a37a-dcf2a29f4db0"</S>
              <S N="Id">/subscriptions/f4a4040f-1f28-4c55-ae0c-b14ad0f38a87/resourceGroups/CoreInfra/providers/Microsoft.Network/virtualNetworks/CoreInfra/subnets/demo</S>
            </Props>
          </Obj>
        </LST>
      </Obj>
      <Obj N="VirtualNetworkPeerings" RefId="6">
        <TN RefId="6">
          <T>System.Collections.Generic.List`1[[Microsoft.Azure.Commands.Network.Models.PSVirtualNetworkPeering, Microsoft.Azure.Commands.Network, Version=2.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]</T>
          <T>System.Object</T>
        </TN>
        <LST />
      </Obj>
      <S N="ProvisioningState">Succeeded</S>
      <S N="AddressSpaceText">{_x000D__x000A_  "AddressPrefixes": [_x000D__x000A_    "10.0.0.0/16"_x000D__x000A_  ]_x000D__x000A_}</S>
      <S N="DhcpOptionsText">null</S>
      <S N="SubnetsText">[_x000D__x000A_  {_x000D__x000A_    "Name": "demo",_x000D__x000A_    "Etag": "W/\"730cd6b5-fe00-4329-a37a-dcf2a29f4db0\"",_x000D__x000A_    "Id": "/subscriptions/f4a4040f-1f28-4c55-ae0c-b14ad0f38a87/resourceGroups/CoreInfra/providers/Microsoft.Network/virtualNetworks/CoreInfra/subnets/demo",_x000D__x000A_    "AddressPrefix": "10.0.255.0/24",_x000D__x000A_    "IpConfigurations": [],_x000D__x000A_    "ProvisioningState": "Succeeded"_x000D__x000A_  }_x000D__x000A_]</S>
      <S N="VirtualNetworkPeeringsText">[]</S>
      <S N="ResourceGroupName">CoreInfra</S>
      <S N="Location">northeurope</S>
      <S N="ResourceGuid">127f7a29-563f-4c02-ad59-8b851b264580</S>
      <Nil N="Tag" />
      <Nil N="TagsTable" />
      <S N="Name">CoreInfra</S>
      <S N="Etag">W/"730cd6b5-fe00-4329-a37a-dcf2a29f4db0"</S>
      <S N="Id">/subscriptions/f4a4040f-1f28-4c55-ae0c-b14ad0f38a87/resourceGroups/CoreInfra/providers/Microsoft.Network/virtualNetworks/CoreInfra</S>
    </Props>
  </Obj>
</Objs>
'@
                $output = [System.Management.Automation.PSSerializer]::Deserialize($mockData)
                Return $output
            }
            $mockVNetXML = @'
<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork</T>
      <T>Microsoft.Azure.Commands.Network.Models.PSTopLevelResource</T>
      <T>Microsoft.Azure.Commands.Network.Models.PSChildResource</T>
      <T>Microsoft.Azure.Commands.Network.Models.PSResourceId</T>
      <T>System.Object</T>
    </TN>
    <ToString>Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork</ToString>
    <Props>
      <Obj N="AddressSpace" RefId="1">
        <TN RefId="1">
          <T>Microsoft.Azure.Commands.Network.Models.PSAddressSpace</T>
          <T>System.Object</T>
        </TN>
        <ToString>Microsoft.Azure.Commands.Network.Models.PSAddressSpace</ToString>
        <Props>
          <Obj N="AddressPrefixes" RefId="2">
            <TN RefId="2">
              <T>System.Collections.Generic.List`1[[System.String, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]</T>
              <T>System.Object</T>
            </TN>
            <LST>
              <S>10.0.0.0/16</S>
            </LST>
          </Obj>
        </Props>
      </Obj>
      <Nil N="DhcpOptions" />
      <Obj N="Subnets" RefId="3">
        <TN RefId="3">
          <T>System.Collections.Generic.List`1[[Microsoft.Azure.Commands.Network.Models.PSSubnet, Microsoft.Azure.Commands.Network, Version=2.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]</T>
          <T>System.Object</T>
        </TN>
        <LST>
          <Obj RefId="4">
            <TN RefId="4">
              <T>Microsoft.Azure.Commands.Network.Models.PSSubnet</T>
              <T>Microsoft.Azure.Commands.Network.Models.PSChildResource</T>
              <T>Microsoft.Azure.Commands.Network.Models.PSResourceId</T>
              <T>System.Object</T>
            </TN>
            <ToString>Microsoft.Azure.Commands.Network.Models.PSSubnet</ToString>
            <Props>
              <S N="AddressPrefix">10.0.255.0/24</S>
              <Obj N="IpConfigurations" RefId="5">
                <TN RefId="5">
                  <T>System.Collections.Generic.List`1[[Microsoft.Azure.Commands.Network.Models.PSIPConfiguration, Microsoft.Azure.Commands.Network, Version=2.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]</T>
                  <T>System.Object</T>
                </TN>
                <LST />
              </Obj>
              <Nil N="NetworkSecurityGroup" />
              <Nil N="RouteTable" />
              <S N="ProvisioningState">Succeeded</S>
              <S N="IpConfigurationsText">[]</S>
              <S N="NetworkSecurityGroupText">null</S>
              <S N="RouteTableText">null</S>
              <S N="Name">demo</S>
              <S N="Etag">W/"730cd6b5-fe00-4329-a37a-dcf2a29f4db0"</S>
              <S N="Id">/subscriptions/f4a4040f-1f28-4c55-ae0c-b14ad0f38a87/resourceGroups/CoreInfra/providers/Microsoft.Network/virtualNetworks/CoreInfra/subnets/demo</S>
            </Props>
          </Obj>
        </LST>
      </Obj>
      <Obj N="VirtualNetworkPeerings" RefId="6">
        <TN RefId="6">
          <T>System.Collections.Generic.List`1[[Microsoft.Azure.Commands.Network.Models.PSVirtualNetworkPeering, Microsoft.Azure.Commands.Network, Version=2.0.1.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]</T>
          <T>System.Object</T>
        </TN>
        <LST />
      </Obj>
      <S N="ProvisioningState">Succeeded</S>
      <S N="AddressSpaceText">{_x000D__x000A_  "AddressPrefixes": [_x000D__x000A_    "10.0.0.0/16"_x000D__x000A_  ]_x000D__x000A_}</S>
      <S N="DhcpOptionsText">null</S>
      <S N="SubnetsText">[_x000D__x000A_  {_x000D__x000A_    "Name": "demo",_x000D__x000A_    "Etag": "W/\"730cd6b5-fe00-4329-a37a-dcf2a29f4db0\"",_x000D__x000A_    "Id": "/subscriptions/f4a4040f-1f28-4c55-ae0c-b14ad0f38a87/resourceGroups/CoreInfra/providers/Microsoft.Network/virtualNetworks/CoreInfra/subnets/demo",_x000D__x000A_    "AddressPrefix": "10.0.255.0/24",_x000D__x000A_    "IpConfigurations": [],_x000D__x000A_    "ProvisioningState": "Succeeded"_x000D__x000A_  }_x000D__x000A_]</S>
      <S N="VirtualNetworkPeeringsText">[]</S>
      <S N="ResourceGroupName">CoreInfra</S>
      <S N="Location">northeurope</S>
      <S N="ResourceGuid">127f7a29-563f-4c02-ad59-8b851b264580</S>
      <Nil N="Tag" />
      <Nil N="TagsTable" />
      <S N="Name">CoreInfra</S>
      <S N="Etag">W/"730cd6b5-fe00-4329-a37a-dcf2a29f4db0"</S>
      <S N="Id">/subscriptions/f4a4040f-1f28-4c55-ae0c-b14ad0f38a87/resourceGroups/CoreInfra/providers/Microsoft.Network/virtualNetworks/CoreInfra</S>
    </Props>
  </Obj>
</Objs>
'@
            $mockVNet = [System.Management.Automation.PSSerializer]::Deserialize($mockVNetXML)

            $mockRGXML = @'
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
            $mockRG = [System.Management.Automation.PSSerializer]::Deserialize($mockRGXML)

            $vNet = New-LabSubnet -VNetwork $mockVNet -ResourceGroup $mockRG
            It "New-LabSubnet should return a 'PSVirtualNetwok' object" {
                $vNet.ToString() |
                  Should Be "Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork" 
            }
        } # Context "New-LabSubnet should return the expected output"
#>
    } # InModuleScope -ModuleName AzureLabHelper  
} # Describe "New-LabSubnet Unit Tests" -Tags "Unit" 