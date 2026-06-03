param(
    [string]$Path = "."
)

$ErrorActionPreference = "Stop"

$root = Resolve-Path -Path $Path

$textExtensions = @(
    ".md", ".txt", ".yml", ".yaml", ".json", ".toml", ".ps1",
    ".py", ".js", ".ts", ".tsx", ".jsx", ".c", ".h", ".cpp",
    ".hpp", ".cmake", ".ini", ".conf"
)

$skipDirs = @(
    ".git",
    "node_modules",
    ".venv",
    "venv",
    "build",
    "dist",
    "out"
)

# Keep this script ASCII-only. Windows PowerShell 5.1 may parse UTF-8
# scripts without BOM using the local ANSI code page.
$mojibakePatterns = @(
    ([string][char]0xFFFD),
    ([string][char]0x00EF + [string][char]0x00BF + [string][char]0x00BD),
    ([string][char]0x00C3),
    ([string][char]0x00C2)
)

function Test-SkipFile {
    param([System.IO.FileInfo]$File)

    if ($File.Name -eq "check-generated-output.ps1") {
        return $true
    }

    foreach ($dir in $skipDirs) {
        $needle = "\" + $dir + "\"
        if ($File.FullName.Contains($needle)) {
            return $true
        }
    }

    return $false
}

function Test-TextFile {
    param([System.IO.FileInfo]$File)

    $ext = $File.Extension.ToLowerInvariant()
    if ($textExtensions -contains $ext) {
        return $true
    }

    if ($File.Name -eq "SKILL.md") {
        return $true
    }
    if ($File.Name -eq "README.md") {
        return $true
    }
    if ($File.Name -eq "CHANGELOG.md") {
        return $true
    }

    return $false
}

$files = New-Object System.Collections.Generic.List[System.IO.FileInfo]
$allFiles = Get-ChildItem -Path $root -Recurse -File

foreach ($file in $allFiles) {
    if (Test-SkipFile -File $file) {
        continue
    }
    if (Test-TextFile -File $file) {
        $files.Add($file)
    }
}

$failures = New-Object System.Collections.Generic.List[string]

foreach ($file in $files) {
    $relative = Resolve-Path -Path $file.FullName -Relative
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)

    foreach ($byte in $bytes) {
        if ($byte -eq 0) {
            $failures.Add("NUL byte found: " + $relative)
            break
        }
    }

    $content = Get-Content -Raw -Encoding UTF8 -Path $file.FullName

    foreach ($pattern in $mojibakePatterns) {
        if ($content.Contains($pattern)) {
            $failures.Add("Suspicious mojibake pattern in " + $relative)
            break
        }
    }

    $isMarkdown = $false
    if ($file.Extension.ToLowerInvariant() -eq ".md") {
        $isMarkdown = $true
    }
    if ($file.Name -eq "SKILL.md") {
        $isMarkdown = $true
    }
    if ($file.Name -eq "README.md") {
        $isMarkdown = $true
    }
    if ($file.Name -eq "CHANGELOG.md") {
        $isMarkdown = $true
    }

    if ($isMarkdown) {
        $fenceCount = 0
        $contentLines = $content -split '\r?\n'
        foreach ($contentLine in $contentLines) {
            if ($contentLine.StartsWith('```')) {
                $fenceCount = $fenceCount + 1
            }
        }
        if (($fenceCount % 2) -ne 0) {
            $failures.Add("Unbalanced Markdown code fence count " + $fenceCount + ": " + $relative)
        }
    }

    if ($file.Name -eq "SKILL.md") {
        $frontmatterPattern = '(?s)^---\s*\r?\nname:\s*([a-z0-9-]+)\s*\r?\ndescription:\s*(.+?)\r?\n---'
        if ($content -notmatch $frontmatterPattern) {
            $failures.Add("Invalid SKILL.md frontmatter: " + $relative)
        } else {
            $name = $Matches[1]
            $folder = Split-Path -Leaf (Split-Path -Parent $file.FullName)
            if ($name -ne $folder) {
                $failures.Add("Skill name/folder mismatch: " + $relative)
            }
        }
    }
}

if ($failures.Count -gt 0) {
    foreach ($failure in $failures) {
        Write-Host ("BAD " + $failure) -ForegroundColor Red
    }
    Write-Error ("Generated-output sanity check failed with " + $failures.Count + " issue(s).")
}

Write-Host ("Generated-output sanity check passed for " + $files.Count + " file(s).")
