---
name: root-cause
description: Use for any bug report, flaky behavior, flicker, wrong output or "sometimes it breaks". Finds the proven cause before any fix.
---
1. Collect data: logs, DB rows (read-only), reproduction steps. Check what the measurement really measures.
2. Write `CAUSE: … proven by …` or `GUESS: …` (then test the guess: add a log, read the code path, record per frame).
3. State table for every affected state; the fix must make every row correct.
4. `grep` all similar paths. Derive conditions from the cause ("named correct state"), not from a list of bad examples.
5. Test that fails on old code (use real inputs from logs), passes with the fix. Prove red → green.
