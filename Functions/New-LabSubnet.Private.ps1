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
Function New-LabSubnet{
    [CmdletBinding()]
    Param(
        $VNetwork,
        $ResourceGroup
    )

    # Find a spare subnet in the passed network
    If ($VNetwork.Subnets | Where-Object AddressPrefix -like "10.255.*") {
        $lastUsedSubnetCidr = $VNetwork.Subnets | Where-Object AddressPrefix -like "10.255.*" |
        Select-Object -ExpandProperty AddressPrefix |Sort-Object |Select-Object -Last 1
        $lastUsedSubnetBytes = ([IpAddress]::New($lastUsedSubnetCidr.Split("/")[0])).GetAddressBytes()
        $lastUsedSubnetBytes[2] = $lastUsedSubnetBytes[2] + 1
        $newSubnet = [IpAddress]::New($lastUsedSubnetBytes)
        $newSubnetCidr = "$($newSubnet.ToString())/24"
    }
    Else {
        $newSubnetCidr = "10.255.0.0/24"
    }
    Write-Verbose $newSubnetCidr
    # Modify the config of the vNet to include new subnet
    <#
    $param = @{
        Name = $ResourceGroup.ResourceGroupName
        AddressPrefix = $newSubnetCidr
        VirtualNetwork = $VNetwork
    }

    $output = Add-AzureRmVirtualNetworkSubnetConfig @param | Set-AzureRmVirtualNetwork
    #>
    $output = Add-AzureRmVirtualNetworkSubnetConfig -Name $ResourceGroup.ResourceGroupName `
      -AddressPrefix $newSubnetCidr -VirtualNetwork $VNetwork | Set-AzureRmVirtualNetwork
    
    Return $output
}
