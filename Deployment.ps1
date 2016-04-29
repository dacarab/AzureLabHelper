
#region Variables
$resourceGroup = "psod-iaas"
$location = "North Europe"
$storageAccountName = "psodiaas"
$vnetName = "iaas-net"
$nicName = "vm1-nic"
#endregion

# Login to Azure 
Login-AzureRmAccount

# New resource manager group
New-AzureRmResourceGroup -Name $resourceGroup -Location $location

# New storage account
New-AzureRmStorageAccount -Name $storageAccountName -ResourceGroupName $resourceGroup `
    -Type Standard_LRS -Location $location

# Add networking
$subnet = New-AzureRmVirtualNetworkSubnetConfig -name frontendSubnet -AddressPrefix 10.0.1.0/24
$vnet = New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup -Location $location `
    -AddressPrefix 10.0.0.6/16 -Subnet $subnet

# Setup nic & public address
$pip = New-AzureRmPublicIpAddress -Name $nicName -ResourceGroupName $resourceGroup `
    -Location $location -AllocationMethod Dynamic

$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $resourceGroup `   
    -Location $location -SubnetId $vnet.Subnets[0].ID -PublicIpAddressId $pip.Id




  