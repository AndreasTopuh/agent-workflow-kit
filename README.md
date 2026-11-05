# Agent Workflow Kit

**Make any AI coding assistant work like a careful senior engineer.**  
Drop-in universal rules, skills, and a reviewer subagent for Cursor, Antigravity, VS Code, Gemini CLI, Codex, Claude Code, and other AI coding tools that read `AGENTS.md`.

---

> [!IMPORTANT]
> **Note for Beginners: This is NOT an Application You Run!**  
> If you are new to AI coding tools:  
> **You do NOT need to run commands like `npm start`, `python main.py`, or set up a server.**  
> This repository contains **guidance and rule files** for your AI assistant. You simply place these files into your existing project folder (e.g., your website, Python app, or software project). Your AI coding editor (such as Cursor, Antigravity, VS Code AI, etc.) will **automatically read them in the background** to produce disciplined, verified code instead of making blind guesses.

---

## ⚡ Method 1: 1-Command Install (Fastest, No Manual Copying!)

Open your terminal in your project directory and run the command for your operating system:

#### 🍏 For macOS & 🐧 Linux (Terminal)
```bash
curl -fsSL https://raw.githubusercontent.com/AndreasTopuh/agent-workflow-kit/main/install.sh | bash
```

#### 🪟 For Windows ONLY (PowerShell)
```powershell
irm https://raw.githubusercontent.com/AndreasTopuh/agent-workflow-kit/main/install.ps1 | iex
```

> [!NOTE]
> **Saw `zsh: command not found: irm`?**  
> That means you are on a **Mac** and accidentally copied the Windows command! Run the `curl` command above instead.

> **Interactive Menu:** The installer will prompt you to choose your desired setup scope:
> 1. **Current Project (Full Kit):** Installs `AGENTS.md` and `.agent/` (skills & reviewer).
> 2. **Core Rules Only ("The Brain"):** Installs only `AGENTS.md` without extra skill folders.
> 3. **Global Setup (All Projects):** Installs to your machine's global folders (`~/.gemini`, `~/.codex`, `~/.claude`).
>
> *(You can also pass flags directly: `bash -s -- --project`, `--core`, or `--global`)*

---

## 🎯 3 Setup Scopes: Choose What You Want

Whether you use the 1-command installer, drag & drop, or manual copying, choose the scope that fits your needs:

| Option | What Gets Installed | Best For |
|---|---|---|
| **Option 1: Single Project (Full Kit)** *(Recommended)* | `AGENTS.md` + `.agent/` folder (rules, checklist, skills, reviewer) | **Maximum engineering quality.** Gives your AI the universal rules, specialized skills (browser proofing, root-cause debugging), and an automated reviewer subagent to catch bugs before commit. |
| **Option 2: Core Rules Only ("The Brain")** | Just `AGENTS.md` | **Minimalist & lightweight.** If you don't want extra folders or your editor only reads a single rule file. Gives the AI the core disciplined thinking rules without the skill folders. |
| **Option 3: Global / All Projects on Machine** | `~/.gemini/GEMINI.md`<br>`~/.codex/AGENTS.md`<br>`~/.claude/CLAUDE.md`<br>Cursor Settings | **Set once and forget.** Every project on your computer automatically inherits senior engineer discipline without needing to copy files into each repo. |

---

## 🔌 Tool Compatibility: How AI Editors Use `AGENTS.md`

`AGENTS.md` is the universal, vendor-neutral standard for AI coding guidelines:

| AI Assistant / Editor | How It Works | What You Do |
|---|---|---|
| **Cursor** | Automatically loads `AGENTS.md` from the project root | Works out of the box (or paste into *Cursor Settings* → *Rules*) |
| **Antigravity** | Automatically reads `AGENTS.md` from the workspace | Works out of the box |
| **OpenAI Codex / OpenHands** | Natively discovers `AGENTS.md` in root directory | Works out of the box |
| **Claude Code** | Looks for `CLAUDE.md` | Run `cp AGENTS.md CLAUDE.md` (or use our installer) |
| **Gemini CLI** | Looks for `GEMINI.md` or `AGENTS.md` | Run `cp AGENTS.md GEMINI.md` (or use our installer) |
| **GitHub Copilot** | Reads custom repository instructions | Run `cp AGENTS.md .github/copilot-instructions.md` |
| **Windsurf (Codeium)** | Reads custom rules file | Run `cp AGENTS.md .windsurfrules` |

---

## 🖱️ Method 2: Manual Drag & Drop (Zero Terminal)

If you don't want to touch the terminal at all, you can set this up in 3 simple steps:

```
[1. Download ZIP] ───> [2. Drag & Drop into Your Project] ───> [3. Open Editor & Chat with AI]
```

1. **Download the ZIP:**  
   Click the green **`<> Code`** button at the top-right of this GitHub page, then click **Download ZIP**. Unzip the downloaded file on your computer.
2. **Copy Based on Your Chosen Scope:**  
   - **For Single Project (Full Kit):** Drag `AGENTS.md` and the `.agent` folder directly into your project's root folder.
   - **For Core Rules Only ("The Brain"):** Drag only `AGENTS.md` into your project's root folder.
   - **For Global Setup:** Copy `AGENTS.md` to your tool's global config location (see table below).
3. **Start Coding with AI:**  
   Open your project in Cursor, Antigravity, VS Code, etc., and chat with the AI as you normally would. The AI reads the rules in the background automatically! 🎉

---

## 💻 Method 3: Manual Terminal Clone (For Git Enthusiasts)

If you want to use standard `git` commands without our installer script:

#### 🍏 For macOS & 🐧 Linux
```bash
git clone https://github.com/AndreasTopuh/agent-workflow-kit.git .awk-temp
cp .awk-temp/AGENTS.md .
cp -r .awk-temp/.agent .   # Omit this line if you only want Core Rules ("The Brain")
rm -rf .awk-temp
```

#### 🪟 For Windows ONLY (PowerShell)
```powershell
git clone https://github.com/AndreasTopuh/agent-workflow-kit.git .awk-temp
Copy-Item .awk-temp\AGENTS.md .
Copy-Item -Recurse .awk-temp\.agent .   # Omit this line if you only want Core Rules ("The Brain")
Remove-Item -Recurse -Force .awk-temp
```

> [!TIP]
> **Already have an `AGENTS.md` in your project?**  
> Don't overwrite it! Paste this kit's contents at the very **top** of your existing file, and keep your custom project rules underneath.

---

## 📖 Plain-English Glossary: What Do These Terms Mean?

This kit is designed to keep AI assistants disciplined. Here is what the technical terms mean in everyday language:

| Term | What It Means (Plain English) | Why It Matters |
|---|---|---|
| **Evidence vs Guess** | The AI is forbidden from guessing why something broke (*"maybe it's X, let me rewrite this"*). It must identify the exact file, line number, and mechanism before changing code. | Stops the AI from making wild assumptions that introduce new bugs. |
| **State Table** | A simple checklist of what the screen should look like in every state: before clicking, while loading, on success, and on error. | Prevents visual glitches (e.g. text vanishing unexpectedly after an animation or buttons flickering). |
| **Diff / Small Diff** | The exact lines of code added or deleted. | Forces the AI to touch only the 3–5 necessary lines rather than rewriting entire files and breaking working code. |
| **Pre-mortem** | Thinking ahead before saying "done": *"If I apply this change, what are 3 other things that could accidentally break?"* | Prevents fixes in one area from silently breaking other parts of your app. |
| **Subagent / Reviewer** | An independent "second assistant" that reviews the code changes made by the primary AI before they are saved or committed. | Like having a senior teammate double-check your code before you submit it. |
| **Browser Proof** | Requiring the AI to verify visual changes directly in a real browser, rather than just relying on passing automated tests. | Automated tests cannot see visual flickering, awkward jumps, or broken animations. |

---

## 📂 What's Inside This Kit?

```
AGENTS.md                         Universal rules ("The Brain" - read by Cursor, Codex, Antigravity, VS Code, etc.)
.agent/
  rules/checklist.md              4 questions the AI must answer with evidence before saying "done"
  skills/
    root-cause/SKILL.md           Step-by-step guide to finding the proven cause of a bug first
    prove-in-browser/SKILL.md     Step-by-step guide to verifying visual fluidity in a real browser
    ship/SKILL.md                 Step-by-step guide for clean reviews, staging, and honest commits
  agents/reviewer.md              Read-only reviewer subagent that hunts for bugs and security holes in diffs
```

*Rules (`AGENTS.md`) are always loaded. Specialized skills (`skills/`) load only when triggered, saving token budget.*

---

## 🔍 Verify It Loaded (30 Seconds)

Start a **new conversation** in your AI editor and paste this prompt:

```text
List the rules, skills and subagents you can see in this workspace,
and the 4 questions you must answer before saying "done". Don't change anything.
```

**Expected result:** The AI will list `root-cause`, `prove-in-browser`, `ship`, the `reviewer` subagent, and the 4 checklist questions.  
If it does not see them, ensure `AGENTS.md` and the `.agent` folder are in your project's root directory.

---

## 💬 Ready-to-Use Daily Prompts

Copy and paste these prompts when chatting with your AI assistant:

### 1. Fixing a Bug
```text
Follow AGENTS.md. Use the root-cause skill.
Bug: <describe what happened, when, and any error message>.
Before making any changes, give me the proven CAUSE with evidence (or label it GUESS) and a state table.
```

### 2. UI / Animation / "Make it smooth"
```text
Follow AGENTS.md. First convert my request into 2–4 measurable criteria and show them to me.
Once approved, implement and prove each criterion using the prove-in-browser skill.
Request: <e.g. animate text appearing smoothly word-by-word like ChatGPT without layout jumps>.
```

### 3. Adding a New Feature
```text
Follow AGENTS.md. Plan first: files to touch, state table, and risks (pre-mortem).
Wait for my approval before writing code.
Feature: <describe the feature>.
```

### 4. Before Committing Code
```text
Use the ship skill. Have the reviewer subagent inspect the diff and address all findings.
Do not push.
```

---

## 📊 Before vs After: What You Should Notice

| Situation | Typical AI Assistant | AI with Agent Workflow Kit |
|---|---|---|
| **Bug Report** | *"The issue is probably X, fixed!"* (Guessing) | `CAUSE: function returns -1 at ratio 0 — proven by log line 42` |
| **UI Change** | Edits CSS and immediately says "done" | Builds state table, then measures: `0 flicker frames, 0.4s/word` |
| **Writing Code** | Rewrites entire files, introducing regressions | Smallest possible diff; only touches what is required |
| **Final Report** | *"Everything is 100% working!"* (Empty claim) | Explicitly lists proven vs guessed, with before → after numbers |

---

## 💡 5 Tips That Matter Most

1. **One conversation per task.** Avoid long, endless chats because the AI will gradually summarize away initial rules.
2. **Never let the AI read gigantic log files whole.** Ask it to `grep` or search for key terms first.
3. **Feed real data:** Provide error logs, screenshots, or screen recordings. Evidence-based coding requires real data.
4. **Ask for measurable numbers, not feelings.** Instead of asking *"Is it smooth?"*, ask *"How many frames flickered?"*.
5. **Keep project-specific rules below the kit's rules.** The kit defines *how* to work; your custom rules define *what* your specific project needs.

---

## 🛠️ Global Setup Details

If you chose **Option 3 (Global Setup)**, here are the locations where the rules are stored:

| AI Tool | Global Location | How It Works |
|---|---|---|
| **Antigravity / Gemini CLI** | `~/.gemini/GEMINI.md` | Automatically read on every prompt across all projects. |
| **Codex** | `~/.codex/AGENTS.md` | Automatically loaded by Codex globally. |
| **Claude Code** | `~/.claude/CLAUDE.md` | Automatically loaded by Claude Code globally. |
| **Cursor** | Open *Settings* → *Rules* → paste contents of `AGENTS.md` | Applies to every Cursor workspace on your computer. |

*(Note: The `.agent/` folder contains project-specific skills and should be copied into individual projects where you want browser testing or automated review).*

---

## ❓ Frequently Asked Questions (FAQ)

**Does this slow the AI down?**  
Slightly at the start of a task, because the AI investigates and plans before editing. However, it saves immense time overall by eliminating the frustrating cycle of *"AI fixed bug A but broke bug B"*.

**Does it consume a lot of tokens?**  
The core rules are compact (~1–2k tokens). Skills load on-demand only when invoked, keeping context overhead minimal.

**What if the AI still makes a guess?**  
Simply reply: *"That's a GUESS. Prove it with evidence first per AGENTS.md."* The AI will immediately recognize the rule and adjust.

---

## License

[MIT License](LICENSE) — Free to use, modify, and distribute for personal and commercial projects.
