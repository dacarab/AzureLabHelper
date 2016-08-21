<#
    .Synopsis
    Creates a resource group
    .Description
    Creates a resource group and returns it as output. Intended to facilitate the
    creation of a lab in Azure. It takes a prefix that it will append a 4 digit
    random number onto for naming purposes
    .Parameter ResourseGroupPrefix
    The prefix that you wish to prepend to the randomly generated 4 didgit number
    .Example
    $LabResourceGroup  = New-LabRG -ResourceGroupPrefix Wibbler

    Will append a randomly generated 4 digit number onto the end of Wibbler,
    create a resource group of that name in Azure  and place the resource group 
    into the variable '$LabResourceGroup'
#>

Function New-LabRG {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [String]$ResourceGroupPrefix,
        [String]$Location = "NorthEurope"
    )

    # Create a "random" name to use for the lab
    $LabLabel = -join ($ResourceGroupPrefix, $(Get-Random -Maximum 9999))

    New-AzureRmResourceGroup -Location $Location -Name $LabLabel 
}