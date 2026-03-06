$ProfileName = "PScherz"
$ConfigPath = Join-Path $PSScriptRoot "PScherz.config.json"
$PScherzConfig = (Get-Content $ConfigPath -Raw | ConvertFrom-Json | Select-Object -ExpandProperty PScherz)
$PScherzConfigLoaded = $PScherzConfig.version -ne $null
$li = "`t$([char]0x2705)"

$TaskName = "Startup Message"
$startupMsg = @"
+----------------------------------------------------------------------------------------------------------------------
|________________     ______                   
|___  __ \_  ___/________  /___________________
|__  /_/ /____ \_  ___/_  __ \  _ \_  ___/__  /
|_  ____/____/ // /__ _  / / /  __/  /   __  /_
|/_/     /____/ \___/ /_/ /_/\___//_/    _____/
+----------------------------------------------------------------------------------------------------------------------
| Profile:           $ProfileName
| Configuration:     $ConfigPath
| Version:           $($PScherzConfig.version)
|
| To see full configuration details, run: 
|       'echo `$PScherzConfig | ConvertTo-Json -Depth 10' OR start `$ConfigPath
+----------------------------------------------------------------------------------------------------------------------
  Status:
"@
Write-Host $startupMsg -ForegroundColor Blue
Write-Host "$li $TaskName" -ForegroundColor Blue

$TaskName = "Load Profile Configuration"
if (Test-Path $ConfigPath) {
    try {
        $ConfigPath = Join-Path $PSScriptRoot "PScherz.config.json"
        $PScherzConfig = (Get-Content $ConfigPath -Raw | ConvertFrom-Json).PScherz
    }
    catch {
        Write-Warning "Failed to load config from $ConfigPath : $_"
    }
}
Write-Host "$li $TaskName" -ForegroundColor Blue

$TaskName = "Environment Variables"
[System.Environment]::SetEnvironmentVariable("BASE_PROFILE_PATH", "C:\dev\source\repos\PowerShell\Config\PScherz.profile.ps1", [System.EnvironmentVariableTarget]::Process)
Write-Host "$li $TaskName" -ForegroundColor Blue

$TaskName = "Custom Prompt"
function global:prompt {
    $lastSuccess = $?
    $lastExitCode = $LASTEXITCODE
    
    # Execution time of last command
    $executionTime = ""
    if ($PScherzConfig.prompt.showExecutionTime) {
        $lastCmd = Get-History -Count 1 -ErrorAction SilentlyContinue
        if ($lastCmd) {
            $duration = $lastCmd.EndExecutionTime - $lastCmd.StartExecutionTime
            if ($duration.TotalSeconds -ge 1) {
                $executionTime = " [{0:N2}s]" -f $duration.TotalSeconds
            }
        }
    }
    
    # Path display
    $pathDisplay = switch ($PScherzConfig.prompt.showPath) {
        'full' { $PWD.Path }
        'short' { Split-Path $PWD -Leaf }
        default { $PWD.Path }
    }
    
    # Git status (if posh-git is loaded)
    $gitStatus = ""
    if ($PScherzConfig.prompt.showGitStatus -and (Get-Module posh-git -ErrorAction SilentlyContinue)) {
        $status = Get-GitStatus -Force
        if ($status) {
            $branch = $status.Branch
            $gitStatus = " ($branch)"
        }
    }
    
    # Status indicator
    $statusChar = if ($lastSuccess) { ">" } else { "!" }
    $statusColor = if ($lastSuccess) { "Green" } else { "Red" }
    
    # Build prompt
    Write-Host 'PScherz ' -NoNewline -ForegroundColor DarkGray
    Write-Host $pathDisplay -NoNewline -ForegroundColor Blue
    Write-Host $gitStatus -NoNewline -ForegroundColor Yellow
    Write-Host $executionTime -NoNewline -ForegroundColor DarkGray
    Write-Host " $statusChar" -NoNewline -ForegroundColor $statusColor
    
    $LASTEXITCODE = $lastExitCode
    return " "
}
Write-Host "$li $TaskName" -ForegroundColor Blue

Write-Host @"
-----------------------------------------------------------------------------------------------------------------------
"@ -ForegroundColor Blue