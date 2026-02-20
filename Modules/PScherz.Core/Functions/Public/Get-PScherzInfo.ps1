function Get-PScherzInfo {
  <#
  .SYNOPSIS
    Returns basic information about PScherz.Core.
  #>
  [CmdletBinding()]
  param()

  [pscustomobject]@{
    Module = 'PScherz.Core'
    Version = (Get-Module -Name PScherz.Core -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1).Version.ToString()
    LoadedAt = (Get-Date).ToString('o')
  }
}
