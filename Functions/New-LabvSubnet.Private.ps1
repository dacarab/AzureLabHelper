<#
    .Synopsis
    Creates an Azure subnet
    .Description
    Private function within the "AzureLabHelper" module - intended to facilitate 
    the creation of Azure labs by creating a vSubnet
    .Parameter ResourceGroup
    ResourceGroup to use for the creation of the vSubnet
    .Example
#>
Function New-LabvSubnet{
    [CmdletBinding()]
    Param(
        $vNetwork,
        $ResourceGroup
    )

    # Find a spare range in the passed network in the 10.0.255.0 range
    $LastUsedSubnet = $vNetwork.Subnets | Where-Object AddressPrefix -like "10.255.*" |
      Select-Object -ExcludeProperty AddressPrefix |Sort-Object |Select-Object -Last 1
    
    # Modify the config of the vNet to include new subnet
    $subnet = New-AzureRmVirtualNetworkSubnetConfig -name frontendSubnet -AddressPrefix 10.0.1.0/24
    $vnet = New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup -Location $location `
      -AddressPrefix 10.0.0.0/16 -Subnet $subnet
}