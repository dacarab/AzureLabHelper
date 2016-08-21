Import-Module Pester

$Tests = Get-ChildItem -Path $PSScriptRoot\Tests -Filter *.Tests.ps1 |
  Select-Object -ExpandProperty FullName

  ForEach($Test in $Tests){
      Invoke-Pester $Test -Tag Unit
  }