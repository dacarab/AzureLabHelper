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
        $ResourceGroup
    )
}