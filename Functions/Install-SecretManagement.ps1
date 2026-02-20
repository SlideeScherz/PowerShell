#requires -version 5.1

try {
    Write-Output "Installing Microsoft.PowerShell.SecretManagement module..."

    Install-Module -Name Microsoft.PowerShell.SecretManagement -RequiredVersion 1.1.2
    "$($Icons.Success) Done."
    exit 0 # success
}
catch {
    "$($Icons.Error) Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    exit 1
}
