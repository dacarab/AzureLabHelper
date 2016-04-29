
# Parameters
$resourceGroup = "psod-iaas"
$location = "North Europe"
$storageAccountName = "psodiaas"
$vnetName = "iaas-net"
$nicName = "vm1-nic"
$vmName = "win-web"

# Login to Azure 
Login-AzureRmAccount

# Provide credentials to use for vm admin account
$cred = Get-Credential -Message "Admin credentials for new VMs"

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

# Set new vm config 
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize "Basic_A1"
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred `
    -ProvisionVMAgent -EnableAutoUpdate
$vm = Set-AzureRmVMSourceImage -vm $vm -PublisherName "MicrosoftWindowsServer" `
    -Offer "WindowsServer" -Skus "2012-R2-Datacenter" -version "latest"
$vm = Add-AzureRmVMNetworkInterface -vm $vm -Id $nic.Id

# Create vm Disk
$diskName = "os-disk"
$storageAcc = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroup -name $storageAccountName
$osDiskUri - $storageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $diskName + ".vhd"
$vm = Set-AzureRmVMOSDisk -vm $vm -Name $diskName -VhdUri $osDiskUri -CreateOption FromImage

# Build vm
New-AzureRmVm -ResourceGroupName $resourceGroup -Location $location -vm $vm


