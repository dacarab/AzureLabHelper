<#
    .Synopsis
    Creates a lab environment in Azure
    .Description
    Creates a new resource group and set of machines in Azure for the purposes of 
    testing. Can optionally deploy core AD infrastructure (TODO)
    .Parameter LabName
    .Parameter WindowsCount
    .Parameter LinuxCount
    .Example
    New-AzureLab -LabName Demo -WindowsServerCount 3 -LinuxServerCount 1

    Creates a resource group called demo and deploys 3 Windows machines and 1 
    Linux machine into the environment.
#>

Function New-AzureLab {
    [CmdletBinding()]
    Param(
        [String]$LabName,
        [Int]$WindowsCount,
        [Int]$LinuxCount,
        $Cred
    )
    # Create the resource group required to manage the lab
    $ResourceGroup = New-LabResourceGroup -LabName $LabName

    # Create a storage Account for the lab
    $StorageAccount = New-LabStorageAccount -ResourceGroup $ResourceGroup

    # Create a vSubnet to use for the LabName
    $SubnetID = New-LabSubnet -ResourceGroup $ResourceGroup

    # Create lab machines
    If ($WindowsCount) {
        $param = @{
            Count = $WindowsCount
            ResourceGroup = $ResourceGroup
            StorageAccount = $StorageAccount
            vSubnet = $SubnetID
            cred = $Cred
        }
        New-LabWindowsBox @param
    }
    If ($LinuxCount) {
        $param = @{
            Count = $LinuxCount
            ResourceGroup = $ResourceGroup
            StorageAccount = $StorageAccount
            vSubnet = $SubnetID
            Cred = $Cred
        }
        New-LabLinuxBox @param
    }
    

}