# Agent Workflow Kit

**Make any AI coding agent work like a careful senior engineer.**
Drop-in rules, skills and a reviewer subagent for Antigravity, Gemini CLI, Codex, Cursor, Claude Code and other agents that read `AGENTS.md` / `GEMINI.md`.

Without it, agents often:
- "fix" a bug by guessing the cause;
- patch one moment and break another (the text appears, then vanishes again);
- call a visual change "done" because the unit tests are green;
- claim "fully fixed" with no numbers.

With it, the agent:
1. writes the **cause with evidence**, or labels it `GUESS:`;
2. builds a **state table** before touching UI or anything time-based;
3. makes the **smallest diff**, and a test that fails without the fix;
4. **proves** visual changes in a real browser, measured per frame;
5. runs a **pre-mortem** and a **reviewer** pass before committing;
6. reports **proven vs guessed**, with before → after numbers.

---

## What's inside

```
AGENTS.md                         always-on rules (read by Codex, Cursor, Antigravity, many others)
GEMINI.md                         same rules, for Gemini CLI / Antigravity
.agent/
  rules/checklist.md              4 questions the agent must answer before saying "done"
  skills/
    root-cause/SKILL.md           bug → proven cause → general fix → test that bites
    prove-in-browser/SKILL.md     measure flicker, layout shift and timing in a real browser
    ship/SKILL.md                 checks, review, file-by-file staging, honest commit
  agents/reviewer.md              read-only subagent that hunts bugs and new holes in your diff
```

Rules are always loaded. Skills load only when relevant, so they cost almost no context until they are used.

---

## Install

### Option A: one project (recommended)

From your project root:

```bash
git clone https://github.com/<you>/agent-workflow-kit /tmp/awk
cp /tmp/awk/AGENTS.md /tmp/awk/GEMINI.md .
cp -R /tmp/awk/.agent .
```

Already have an `AGENTS.md` or `GEMINI.md`? Don't overwrite it. Paste the kit's content at the **top** of your existing file, and keep your project-specific rules below it.

### Option B: every project on your machine

| Tool | Global location |
|---|---|
| Gemini CLI / Antigravity | `~/.gemini/GEMINI.md` |
| Codex | `~/.codex/AGENTS.md` |
| Claude Code | `~/.claude/CLAUDE.md` |
| Cursor | Settings → Rules → paste `AGENTS.md` |

Skills and subagents are per-project: copy `.agent/` into each repo.

### Per tool

- **Antigravity**: reads `GEMINI.md` / `AGENTS.md` and discovers `.agent/` (rules, skills, agents) automatically. Restart the conversation after installing.
- **Gemini CLI**: reads `GEMINI.md`. Skills are plain Markdown; tell it to "use the root-cause skill in .agent/skills".
- **Codex / Cursor / others**: read `AGENTS.md`. Point them at `.agent/skills/<name>/SKILL.md` when needed.
- **Claude Code**: copy `AGENTS.md` into `CLAUDE.md`. Optionally move the skills to `.claude/skills/` and the reviewer to `.claude/agents/`.

---

## Verify it loaded (30 seconds)

Start a **new** conversation and paste:

```
List the rules, skills and subagents you can see in this workspace,
and the 4 questions you must answer before saying "done". Don't change anything.
```

It should name `root-cause`, `prove-in-browser`, `ship`, the `reviewer` subagent and the checklist. If it doesn't, it isn't reading the files: check the file location for your tool (table above).

---

## Daily use: copy-paste prompts

**Fix a bug**
```
Follow AGENTS.md. Use the root-cause skill.
Bug: <what you saw, when, how often>.
Before any fix, give me CAUSE with evidence (or GUESS) and a state table.
```

**UI / animation / "make it smooth"**
```
Follow AGENTS.md. First turn my request into 2–4 measurable criteria and show them to me.
Then implement, and prove each criterion with the prove-in-browser skill (numbers + 2 screenshots).
Request: <e.g. text should fade in word by word like ChatGPT, without layout jumps>.
```

**New feature**
```
Follow AGENTS.md. Plan first: files to touch, state table, risks (pre-mortem), how you will prove it.
Wait for my OK, then build in small verified steps.
Feature: <…>
```

**Before committing**
```
Use the ship skill. Ask the reviewer subagent to review the diff and answer every finding.
Don't push.
```

---

## Before / after (what you should notice)

| Moment | Typical agent | With this kit |
|---|---|---|
| Bug report | "The issue is probably X, fixed!" | `CAUSE: fn returns -1 at ratio 0, and -1 means "show all" — proven by frame recording` |
| UI change | Edits CSS, says done | State table, then per-frame measurement: `flicker 0, layout shift 0 px, 0.4 s/word` |
| Tests | Loosens the assertion until green | New test fails without the fix, passes with it |
| Commit | `git add .`, vague message | File-by-file, reviewed, message explains WHY with numbers |
| Report | "Everything works perfectly" | Proven / guess / not tested, before → after |

---

## Tips that matter most

1. **One conversation per task.** Long chats get summarized and the rules fade.
2. **Don't let it read huge files whole.** Logs and notes: `grep` first.
3. **Give it data:** logs, screenshots, a screen recording. "Measure, don't guess" only works if there's something to measure.
4. **Ask for numbers.** "Is it smooth?" is unanswerable; "how many flicker frames?" is.
5. **Keep your own rules below the kit's.** The kit is about *how* to work; your file says *what* your project needs.

---

## Customize

- Add project facts (commands, folders, past pitfalls) under a `## Project` section in `AGENTS.md`.
- Add your own skills: `.agent/skills/<name>/SKILL.md` with `name` and `description` frontmatter. Make the description say **when** to use it.
- Language: rules are in English. Agents follow them while answering in your language. You can also add "Reply in <language>" to `AGENTS.md`.

## FAQ

**Does it slow the agent down?** Slightly, per task. It saves the much longer loop of "fixed → broken → fixed again".

**Does it cost tokens?** The rules are about 1–2k tokens. Skills load only when used.

**It still guessed!** Reply: "That's a GUESS. Prove it first." The rules give the agent a shared vocabulary for this.

## License

MIT. Use it, fork it, adapt it.
