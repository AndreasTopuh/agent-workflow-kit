---
name: ship
description: Use before every commit or push.
---
1. Typecheck, tests, build — read the numbers. Anything red → stop.
2. Ask the `reviewer` subagent to review the diff; answer every finding.
3. `git status`, then `git add` FILE BY FILE. Scan the staged diff for secrets.
4. Commit message: what changed for users + WHY (proven cause, numbers). No AI attribution.
5. Push only when the owner asks. Never force-push.
6. Log the decision (date, what, why, numbers, commit) in the project's notes file.
