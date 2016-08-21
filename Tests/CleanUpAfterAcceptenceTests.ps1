# Cleanup after New-LabRG Acceptence tests
Get-AzureRmResourceGroup | Where-Object ResourceGroupName -like "Acceptence*" |
  Remove-AzureRmResourceGroup -Force
