# Grab all the script files in the Functions folder
$functionScripts = Get-ChildItem $PSScriptRoot\Functions -file -Filter *.ps1 |
  Select-Object -ExpandProperty FullName

# dotSource the scriptfiles
ForEach($Script in $functionScripts) {
    . $Script
} 

Export-ModuleMember New-AzureLab

#<#
# For debugging
$functions = Get-ChildItem $PSScriptRoot\Functions -file -Filter *.private.ps1 |
  Select-Object -ExpandProperty BaseName
ForEach($function in $functions){
    
    Export-ModuleMember $function.Replace(".Private","")
}
#>
