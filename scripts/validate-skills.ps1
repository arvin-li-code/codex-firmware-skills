param(
    [string]$Root = "."
)

$ErrorActionPreference = "Stop"

$skillFiles = Get-ChildItem -Path (Join-Path $Root "skills") -Recurse -Filter "SKILL.md" -File

if (-not $skillFiles) {
    Write-Error "No SKILL.md files found under skills/."
}

$failed = $false

foreach ($file in $skillFiles) {
    $relative = Resolve-Path -Path $file.FullName -Relative
    $content = Get-Content -Raw -Path $file.FullName

    if ($content -notmatch "(?s)^---\s*\r?\nname:\s*([a-z0-9-]+)\s*\r?\ndescription:\s*(.+?)\r?\n---") {
        Write-Host "BAD frontmatter: $relative" -ForegroundColor Red
        $failed = $true
        continue
    }

    $name = $Matches[1]
    $folder = Split-Path -Leaf (Split-Path -Parent $file.FullName)

    if ($name -ne $folder) {
        Write-Host "BAD name/folder mismatch: $relative declares '$name' but folder is '$folder'" -ForegroundColor Red
        $failed = $true
        continue
    }

    Write-Host "OK $relative"
}

if ($failed) {
    exit 1
}

Write-Host "Validated $($skillFiles.Count) skill file(s)."
