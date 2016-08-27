<#
    .Synopsis
    Creates a Windows machine
    .Description
    Private function within the "AzureLabHelper" module - intended to facilitate 
    the creation of Azure labs by spinning up a standard Windows box
    .Parameter ResourceGroup
    ResourceGroup to use for the creation of the box
    .Parameter StorageAccount
    StorageAccount to be used for the creation of the box
    .Parameter vSubnet
    vSubnet the box is to be deployed to
    .Parameter Count
    Number of machines to spin up    
    .Example
#>
Function New-LabWindowsBox{
    [CmdletBinding()]
    Param(
        $ResourceGroup,
        $StorageAccount,
        $VNetwork,
        $Cred,
        $Count
    )
    # Derive the name prefix to use for generated objects
    $prefix = $ResourceGroup.ResourceGroupName

    do {
        $label = $prefix + $Count
        # Create a new Public IP
        $pipParam = @{
            Name = $label
            ResourceGroupName = $prefix
            Location = 'NorthEurope'
            AllocationMethod = "Dynamic"
        }
        $pip = New-AzureRmPublicIpAddress @pipParam

        # Create a new interface
        $subnet = $VNetwork.Subnets | Where-Object Name -eq $prefix

        $vni = New-AzureRmNetworkInterface -Name $label -ResourceGroupName $prefix -Location 'NorthEurope' -Subnet $subnet -PublicIpAddress $pip 

        # Build OS config 
        $vm = New-AzureRmVMConfig -VMName $vmName$label -VMSize "Standard_A1"

        $vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $label -Credential $Cred -ProvisionVMAgent -EnableAutoUpdate

        $vm = Set-AzureRmVMSourceImage -vm $vm -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus '2012-R2-Datacenter' -Version 'latest'
        
        $vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $vni.Id
        
        $vhdUri = $StorageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $label + "_OS.vhd"

        $vm = Set-AzureRmVMOSDisk -vm $vm -Name $($label + "_OS") -VhdUri $vhdUri -CreateOption FromImage
        
        # Create the vm        
        New-AzureRmVM -ResourceGroupName $prefix -Location 'NorthEurope' -VM $vm

        $Count = $Count - 1
    } while ($Count -gt 0)

}