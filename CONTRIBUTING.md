# Contributing

Thanks for contributing!

## Ground rules

- Use PowerShell 7+ (`pwsh`) for new work unless a script explicitly targets Windows PowerShell 5.1.
- Prefer approved verbs (`Get-Verb`) and `Verb-Noun` function naming.
- Add tests (Pester) for new module functionality.
- Keep functions idempotent and side-effect aware.

## Development

### Lint
```powershell
Invoke-ScriptAnalyzer -Path . -Recurse
```

### Test
```powershell
Invoke-Pester -CI
```

## Pull requests

- Keep PRs focused and small.
- Update README/docs when behavior changes.
- Ensure CI passes (Pester + PSScriptAnalyzer).
