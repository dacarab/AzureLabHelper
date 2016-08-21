# Grab all the script files in the Functions folder
$FunctionScripts = Get-ChildItem $PSScriptRoot\Functions -file -Filter *.ps1 |
  Select-Object -ExpandProperty FullName

# dotSource the scriptfiles
ForEach($Script in $FunctionScripts) {
    . $Script
} 

Export-ModuleMember New-AzureLab
