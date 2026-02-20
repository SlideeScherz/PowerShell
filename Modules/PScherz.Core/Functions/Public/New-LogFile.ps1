[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Path,
    [switch]$CreateIfMissing,
    [switch]$Force
)

function New-LogFile {
    param (
        [Parameter(Mandatory)]
        [string]$Path,
        [switch]$CreateIfMissing,
        [switch]$Force
    )
    $LogFile = Get-Item -Path $Path -ErrorAction SilentlyContinue
    if ($CreateIfMissing -or $Force) {
        New-Item -Path $Path -ItemType File -Force:$Force -ErrorAction Stop -OutVariable LogFile | Out-Null
    }
    return $LogFile
}

New-LogFile -Path $Path -CreateIfMissing:$CreateIfMissing -Force:$Force