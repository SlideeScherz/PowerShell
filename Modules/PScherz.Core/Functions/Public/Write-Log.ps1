[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Message,

    [ValidateSet('Trace', 'Debug', 'Info', 'Warn', 'Error')]
    [string]$Level = 'Info'
)

function Write-Log {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet('Trace', 'Debug', 'Info', 'Warn', 'Error')]
        [string]$Level = 'Info'
    )

    Write-Host ("[{0}] {1}" -f $Level, $Message) -ForegroundColor $(
        switch ($Level) {
            'Trace' { 'Gray' }
            'Debug' { 'Cyan' }
            'Info' { 'Green' }
            'Warn' { 'Yellow' }
            'Error' { 'Red' }
        }
    )
}

Write-Log -Message $Message -Level $Level