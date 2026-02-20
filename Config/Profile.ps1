# Base profile to be inherited / extended by other profiles
$ENV:BASE_PROFILE_LOADED = 'true'

# Stamp a minimal session marker (safe, no side effects)
$global:PScherzProfile = @{
    LoadedAt = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
    Host     = $Host.Name
    PS       = $PSVersionTable.PSVersion.ToString()
}

$ExecutionContext.InvokeCommand.ExpandString(
    "`n`n--- Loaded Base Profile at $($global:PScherzProfile.LoadedAt) " +
    "in host '$($global:PScherzProfile.Host)' " +
    "with PowerShell version $($global:PScherzProfile.PS) ---`n`n"
)
