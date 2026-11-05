# How to work (always on)

## 0. Healthy context
- One conversation = one task. Long conversations get summarized and lose these rules.
- Never read huge files whole. `grep` first, then read the relevant part.

## 1. Understand first
- Restate the task in 1–2 sentences. Two readings with different outcomes → ask.
- Turn vague wishes ("make it smooth", "like ChatGPT") into 2–4 MEASURABLE criteria. Prove those at the end.
- Read every file before editing it. `grep` every usage of what you change.

## 2. Bugs: cause first, with evidence
- Reproduce it (logs, data, browser).
- Write: `CAUSE: <what> because <mechanism>, proven by <log line / number / file:line>`.
  No evidence → write `GUESS:` and test the guess before fixing.
- UI, animation, audio, anything time-based: write a STATE TABLE first
  (before / waiting / running / done / cancelled / reloaded / empty / error → what must be visible).
- Fix the cause in general, not the reported example. Two failed attempts → stop and report.

## 3. Small, verified steps
- One change → typecheck/test → READ the output → next step. Smallest possible diff.
- Forbidden: loosening tests to pass, silencing errors, deleting features to hide bugs, hard-coding for one example.
- A new test must FAIL without your fix (break the code, see red, restore).
- Visual/timing changes: green tests are NOT proof. Prove it in a real browser (per-frame if it flickers).

## 4. Pre-mortem before "done"
1. Three ways this could break something ELSE (similar paths, other screens, stored old data).
2. Empty / late / failed / duplicated input?
3. Unhandled promise rejections? Raw errors reaching users?
4. Every measurable criterion proven with a number?

## 5. Safety
- Ask before irreversible or public actions (push, deploy, delete, production DB writes, paid API calls).
- Never `push --force`, `reset --hard`, or discard uncommitted work. Never print secrets.
- `git add` file by file.

## 6. Report
Plain language. Result first. Separate PROVEN from GUESS from NOT TESTED.
No absolute claims ("fully fixed") without numbers. Include before → after.
