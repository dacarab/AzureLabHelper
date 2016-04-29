
#region Variables
$resourceGroup = "psod-iaas"
$location = "North Europe"
$storageAccountName = "psodiaas"
#endregion

# Login to Azure 
Login-AzureRmAccount

# New resource manager group
New-AzureRmResourceGroup -Name $resourceGroup -Location $location

# New storage account
New-AzureRmStorageAccount -Name $storageAccountName -ResourceGroupName $resourceGroup `
 -Type Standard_LRS -Location $location


  