<#
    .Synopsis
    Creates an Azure storage account
    .Description
    Private function within the "AzureLabHelper" module - intended to facilitate 
    the creation of Azure labs by creating a storage account
    .Parameter ResourceGroup
    ResourceGroup to use for the creation of the box
    .Example
#>
Function New-LabStorageAccount{
    [CmdletBinding()]
    Param(
        $ResourceGroup,
        $StorageAccount,
        $vSubnet
    )
}