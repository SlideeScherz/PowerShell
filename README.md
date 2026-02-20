# PowerShell

Open-source PowerShell repository for **Scripts**, **Functions**, **Modules**, **Configs**, and **Profiles**.

## Structure

- `scripts/` — runnable utilities (each script in its own folder)
- `functions/` — reusable function library (Public/Private split)
- `modules/` — versioned PowerShell modules (publish-ready)
- `configs/` — configuration files (psd1/json/yaml) + examples
- `profiles/` — profile scripts you can link/copy to `$PROFILE`
- `.github/workflows/` — CI (Pester) + lint (PSScriptAnalyzer)

## Quick start

### 1) Clone
```powershell
git clone https://github.com/<your-org-or-user>/PowerShell.git
cd PowerShell
```

### 2) Import the module (PScherz.Core)
From repo root:
```powershell
Import-Module "$PWD\modules\PScherz.Core\PScherz.Core.psd1" -Force
Get-PScherzInfo
```

### 3) Run a script
```powershell
pwsh -File .\scripts\example-script\src\example-script.ps1
```

### 4) Use profiles
Copy or symlink:
- `profiles/Microsoft.PowerShell_profile.ps1` → your `$PROFILE`
- `profiles/Microsoft.PowerShellISE_profile.ps1` → your ISE profile (if applicable)

## Conventions

- Scripts: `scripts/<kebab-name>/src/<kebab-name>.ps1`
- Functions: `functions/Public` (exportable), `functions/Private` (internal helpers)
- Modules: `modules/<PascalCaseName>/` with `.psd1` + `.psm1`
- Config: prefer `.psd1` for PowerShell-native config; use `.json` only when needed

## CI

- `ci-pwsh.yml` runs Pester tests
- `lint-pwsh.yml` runs PSScriptAnalyzer
