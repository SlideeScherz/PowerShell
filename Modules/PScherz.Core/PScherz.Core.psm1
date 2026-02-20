# PScherz.Core - module entry point

$public = Join-Path $PSScriptRoot 'Public'
$private = Join-Path $PSScriptRoot 'Private'

# Load private functions first
if (Test-Path $private) {
    Get-ChildItem -Path $private -Filter '*.ps1' -File -ErrorAction SilentlyContinue |
    ForEach-Object { . $_.FullName }
}

# Export only public functions
if (Test-Path $public) {
    $exports = Get-ChildItem -Path $public -Filter '*.ps1' -File |
    ForEach-Object { $_.BaseName }
    Export-ModuleMember -Function $exports
}
