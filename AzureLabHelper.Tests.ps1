Import-Module Pester

$Tests = Get-ChildItem -Path $PSScriptRoot\Tests -Filter *.Tests.ps1 |
  Select-Object -ExpandProperty FullName

  ForEach($Test in $Tests){
      Write-Host "Running Tests from $Test" -ForegroundColor Yellow
      Invoke-Pester $Test -Tag Unit
  }