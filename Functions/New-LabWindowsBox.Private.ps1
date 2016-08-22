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
        $SubnetID,
        $cred,
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
        $vniParam = {
            Name = $label
            ResourceGroupName = $prefix
            Location = 'NorthEurope'
            SubnetId = $SubnetID
            PublicIpAddressId = $pip.Id

        }
        $vni = New-AzureRmNetworkInterface @vniParam

        # Build OS config 
        $vm = New-AzureRmVMConfig -VMName $vmName$label -VMSize "Standard_A1"

        $osParam = {
            VM = '$vm'
            Windows = $true
            ComputerName = $label
            Credential = $cred
            ProvisionVMAgent = $true
            EnableAutoUpdate = $true
        }
        $vm = Set-AzureRmVMOperatingSystem @osParam

        $siParam = {
            VM = '$vm'
            PublisherName = 'MicrosoftWindowsServer'
            Offer = 'WindowsServer'
            Skus = '2012-R2-Datacenter'
            version = 'latest'

        }
        $vm = Set-AzureRmVMSourceImage @siParam
        
        $vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $vni.Id
        
        $osDiskParam = {
            VM = $vm
            Name = $label + "_OS"
            VhdUri = $StorageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/$label_OS.vhd"
            CreateOption = "fromImage"
        }
        $vm = Set-AzureRmVMOSDisk @osDiskParam
        
        # Create the vm        
        New-AzureRmVM -ResourceGroupName $rgName -Location $locName -VM $vm

        $Count = $Count - 1
    } while ($Count -gt 0)

}