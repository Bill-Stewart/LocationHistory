@{
  RootModule = 'LocationHistory.psm1'
  ModuleVersion = '2.0.0'
  GUID = '1c577381-7cd2-4985-b3f0-493dcbc2b26b'
  Author = 'Bill Stewart'
  CompanyName = 'Bill Stewart'
  Copyright = '(C) 2017-2025 by Bill Stewart'
  Description = 'Provides an enhanced location history.'
  CompatiblePSEditions = @('Desktop','Core')
  PowerShellVersion = '5.1'
  AliasesToExport = '*'
  FormatsToProcess = 'LocationHistory.format.ps1xml'
  FunctionsToExport = @(
    'Clear-LocationHistory'
    'Get-LocationHistory'
    'Set-LocationEx'
    'Remove-LocationHistory'
  )
  PrivateData = @{
    PSData = @{
      # PowerShell Gallery tags
      Tags = @('location','history','Set-Location','PSEdition_Core','PSEdition_Desktop')
      LicenseUri = 'https://github.com/Bill-Stewart/LocationHistory/blob/master/LICENSE.txt'
      ProjectUri = 'https://github.com/Bill-Stewart/LocationHistory'
    }
  }
}
