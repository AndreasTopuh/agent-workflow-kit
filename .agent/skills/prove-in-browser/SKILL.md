---
name: prove-in-browser
description: Use whenever a change affects what users SEE or WHEN things happen (CSS, animation, canvas, audio, layout). Unit tests cannot see timing.
---
1. Run the app; drive a real browser (Playwright/CDP or the built-in browser tool).
2. Measure, don't eyeball: record state EVERY animation frame (requestAnimationFrame) in the page — 100 ms sampling misses 100 ms flickers.
   Record: element counts, visibility (computed opacity), positions (layout shift in px).
3. If the cause is unclear, add a temporary `data-debug` attribute with the component's state, record again, then remove it.
4. Look at 2+ screenshots and describe them. Report numbers: flickers, px shift, timing before → after.
