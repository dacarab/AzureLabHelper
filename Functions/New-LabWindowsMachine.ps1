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
    .Example
#>
Function New-LabLinuxMachine{
    [CmdletBinding()]
    Param(
        $ResourceGroup,
        $StorageAccount,
        $vSubnet
    )
}