# Agent Workflow Kit — Project State

## Overview
- **Project:** Agent Workflow Kit
- **Repository:** https://github.com/AndreasTopuh/agent-workflow-kit.git
- **Purpose:** Universal senior engineer rules, skills, and reviewer subagent for AI coding tools.

## Architecture
- `AGENTS.md`: Universal rule specification loaded natively by Cursor, Antigravity, VS Code, Codex, etc.
- `.agent/rules/checklist.md`: 4 pre-mortem questions required before declaring "done".
- `.agent/skills/`:
  - `root-cause`: Bug reproduction, evidence gathering, state table, and bitten test.
  - `prove-in-browser`: Real-world browser fluidity and per-frame measurements.
  - `ship`: Diff review, clean staging, and honest commits.
- `.agent/agents/reviewer.md`: Independent reviewer subagent for auditing uncommitted diffs.
- `install.sh` & `install.ps1`: Interactive cross-platform 1-command installers supporting 3 setup scopes.

## Key Architectural Decisions
- **Single Source of Truth:** `AGENTS.md` is the sole canonical rule specification; duplicate `GEMINI.md` removed to avoid synchronization drift.
- **Cross-Platform Clarity:** Dedicated, distinct one-liners for macOS/Linux (`curl`) and Windows PowerShell (`irm`).
- **Project Memory:** Optional `STATE.md` support in `AGENTS.md` gives AI persistent memory across conversations.

## Recent Change Log
- **2026-11-05** (`a078f98`): Added post-installation next steps and verification prompt directly below 1-command installer.
- **2026-11-05** (`030410a`): Clarified OS-specific installation commands with distinct icons and troubleshooting callout for `command not found: irm`.
- **2026-11-05** (`e42d91a`): Unified rules into `AGENTS.md`, removed duplicate `GEMINI.md`, updated installers, and added AI tool compatibility guide.
- **2026-11-05** (`7c5690f`): Created `install.sh` and `install.ps1` with 3 setup scopes (Project, Core, Global); added beginner-friendly documentation and plain-English glossary.
- **2026-11-05** (`84cb0cd`): Initial release of rules, skills, and reviewer subagent.

