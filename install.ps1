param (
    [ValidateSet('Project', 'Core', 'Global')]
    [string]$Scope = ''
)

$ErrorActionPreference = 'Stop'
$RepoUrl = 'https://github.com/AndreasTopuh/agent-workflow-kit.git'
$RawBase = 'https://raw.githubusercontent.com/AndreasTopuh/agent-workflow-kit/main'

Write-Host "🤖 Agent Workflow Kit Installer" -ForegroundColor Cyan
Write-Host "Make any AI coding agent work like a careful senior engineer.`n"

if ([string]::IsNullOrWhiteSpace($Scope)) {
    if ([Environment]::UserInteractive) {
        Write-Host "Choose installation mode:"
        Write-Host "  [1] Current Project: Full Kit (Rules + Skills + Reviewer) (Recommended)" -ForegroundColor Green
        Write-Host "  [2] Current Project: Core Rules Only (`"The Brain`" - AGENTS.md & GEMINI.md)"
        Write-Host "  [3] Global Setup:   All Projects on Machine (~/.gemini, ~/.codex, ~/.claude)"
        Write-Host ""
        $choice = Read-Host "Enter selection [1-3] (Default: 1)"
        if ([string]::IsNullOrWhiteSpace($choice)) { $choice = '1' }
    } else {
        $choice = '1'
    }
} else {
    switch ($Scope) {
        'Project' { $choice = '1' }
        'Core'    { $choice = '2' }
        'Global'  { $choice = '3' }
    }
}

$TempDir = Join-Path ([System.IO.Path]::GetTempPath()) ("awk-" + [System.Guid]::NewGuid().ToString().Substring(0,8))
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

function Cleanup {
    if (Test-Path $TempDir) {
        Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Backup-IfExists ($path) {
    if (Test-Path $path) {
        $bak = "$path.bak"
        Write-Host "Notice: Existing $path found. Backing up to $bak" -ForegroundColor Yellow
        Copy-Item -Path $path -Destination $bak -Force
    }
}

try {
    Write-Host "==> Fetching kit from GitHub..." -ForegroundColor Cyan
    $gitSuccess = $false
    if (Get-Command git -ErrorAction SilentlyContinue) {
        try {
            git clone --depth 1 --quiet $RepoUrl $TempDir
            $gitSuccess = $true
        } catch {
            $gitSuccess = $false
        }
    }

    if (-not $gitSuccess) {
        Write-Host "Falling back to direct file downloads..." -ForegroundColor Yellow
        $folders = @(
            "$TempDir\.agent\rules",
            "$TempDir\.agent\agents",
            "$TempDir\.agent\skills\root-cause",
            "$TempDir\.agent\skills\prove-in-browser",
            "$TempDir\.agent\skills\ship"
        )
        foreach ($f in $folders) { New-Item -ItemType Directory -Path $f -Force | Out-Null }

        Invoke-WebRequest -Uri "$RawBase/AGENTS.md" -OutFile "$TempDir\AGENTS.md"
        Invoke-WebRequest -Uri "$RawBase/GEMINI.md" -OutFile "$TempDir\GEMINI.md"
        Invoke-WebRequest -Uri "$RawBase/.agent/rules/checklist.md" -OutFile "$TempDir\.agent\rules\checklist.md"
        Invoke-WebRequest -Uri "$RawBase/.agent/agents/reviewer.md" -OutFile "$TempDir\.agent\agents\reviewer.md"
        Invoke-WebRequest -Uri "$RawBase/.agent/skills/root-cause/SKILL.md" -OutFile "$TempDir\.agent\skills\root-cause\SKILL.md"
        Invoke-WebRequest -Uri "$RawBase/.agent/skills/prove-in-browser/SKILL.md" -OutFile "$TempDir\.agent\skills\prove-in-browser\SKILL.md"
        Invoke-WebRequest -Uri "$RawBase/.agent/skills/ship/SKILL.md" -OutFile "$TempDir\.agent\skills\ship\SKILL.md"
    }

    $currentDir = (Get-Location).Path

    switch ($choice) {
        '1' {
            Write-Host "==> Installing Full Kit into current directory: $currentDir..." -ForegroundColor Cyan
            Backup-IfExists "$currentDir\AGENTS.md"
            Backup-IfExists "$currentDir\GEMINI.md"
            Copy-Item -Path "$TempDir\AGENTS.md", "$TempDir\GEMINI.md" -Destination $currentDir -Force
            Copy-Item -Path "$TempDir\.agent" -Destination $currentDir -Recurse -Force
            Write-Host "`n✔ Successfully installed Full Kit in this project!" -ForegroundColor Green
            Write-Host "Files added:`n  - AGENTS.md`n  - GEMINI.md`n  - .agent/ (checklist, reviewer, skills)"
            Write-Host "`nNext step: Open your project in Cursor, Antigravity, or VS Code and chat with AI normally!"
        }
        '2' {
            Write-Host "==> Installing Core Rules Only (`"The Brain`") into current directory: $currentDir..." -ForegroundColor Cyan
            Backup-IfExists "$currentDir\AGENTS.md"
            Backup-IfExists "$currentDir\GEMINI.md"
            Copy-Item -Path "$TempDir\AGENTS.md", "$TempDir\GEMINI.md" -Destination $currentDir -Force
            Write-Host "`n✔ Successfully installed Core Rules in this project!" -ForegroundColor Green
            Write-Host "Files added:`n  - AGENTS.md`n  - GEMINI.md"
            Write-Host "`nNext step: Open your project in Cursor, Antigravity, or VS Code and chat with AI normally!"
        }
        '3' {
            Write-Host "==> Installing globally for all projects on this machine..." -ForegroundColor Cyan
            $userHome = [Environment]::GetFolderPath('UserProfile')
            
            $geminiDir = Join-Path $userHome ".gemini"
            $codexDir  = Join-Path $userHome ".codex"
            $claudeDir = Join-Path $userHome ".claude"

            New-Item -ItemType Directory -Path $geminiDir, $codexDir, $claudeDir -Force | Out-Null

            Backup-IfExists "$geminiDir\GEMINI.md"
            Copy-Item -Path "$TempDir\GEMINI.md" -Destination "$geminiDir\GEMINI.md" -Force
            Write-Host "  - Installed to $geminiDir\GEMINI.md (Antigravity & Gemini CLI)"

            Backup-IfExists "$codexDir\AGENTS.md"
            Copy-Item -Path "$TempDir\AGENTS.md" -Destination "$codexDir\AGENTS.md" -Force
            Write-Host "  - Installed to $codexDir\AGENTS.md (Codex)"

            Backup-IfExists "$claudeDir\CLAUDE.md"
            Copy-Item -Path "$TempDir\AGENTS.md" -Destination "$claudeDir\CLAUDE.md" -Force
            Write-Host "  - Installed to $claudeDir\CLAUDE.md (Claude Code)"

            Write-Host "`n✔ Global rules installed!" -ForegroundColor Green
            Write-Host "For Cursor: Copy AGENTS.md contents into Cursor -> Settings -> Rules."
        }
        Default {
            Write-Host "Invalid option. Aborting." -ForegroundColor Yellow
            Exit 1
        }
    }
}
finally {
    Cleanup
}

