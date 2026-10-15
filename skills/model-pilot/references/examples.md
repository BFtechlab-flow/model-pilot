# Worked examples

Scores are Reasoning / Scope / Ambiguity / Stakes / Autonomy, then modifiers.

---

**"Convert this CSV of 40 products to JSON with fields name, price, sku."**
0 / 0 / 0 / 0 / 0 = 0 → **Haiku**, effort low.
```
🧭 Model Pilot → Haiku · effort low
Why: pure format conversion, fully specified (score 0/10).
Switch: /model haiku   (Claude app: pick Haiku in the model menu)
```

---

**"Classify these 2,000 support tickets as billing / bug / feature request."**
1 / 1 / 0 / 1 / 1 = 4, volume −2 → 2 → **Haiku**. In Claude Code, send batches to `pilot-haiku` subagents; spot-check a sample on Sonnet.

---

**"Write a follow-up email to the client who hasn't paid the invoice."**
1 / 0 / 0 / 1 / 0 = 2 → Haiku by score, but it speaks for the user to a client → floor at **Sonnet**.

---

**"Add a contact form with validation to my landing page and send submissions to Google Sheets."**
1 / 1 / 1 / 1 / 1 = 5 → **Sonnet**, effort medium.

---

**"The checkout fails randomly in production, about 1 in 50 orders. Find out why."**
2 / 2 / 2 / 2 / 1 = 9 → **Opus**, effort high; offer Fable for a long unattended investigation.
```
🧭 Model Pilot → Opus · effort high
Why: intermittent production bug, unknown cause, money at stake (score 9/10).
Switch: /model opus   · For a multi-hour unattended hunt, Fable is an option (uses more credits) — want it?
```

---

**"Design the database and API for a B2B marketplace with buyers, sellers and quotes."**
2 / 2 / 1 / 2 / 1 = 8 → **Opus**. Suggest `/model opusplan` if the user wants to build right after the design.

---

**"Fix the typo in the README title."**
Trivial, user did not ask for routing → skip the card and fix it.

---

**"Sonnet already tried twice to fix this failing test and it keeps breaking another one."**
1 / 1 / 1 / 1 / 1 = 5, prior failure +3 → 8 → **Opus**.

---

**Mixed request: "Scrape the 30 competitor pages, summarise each, then write our positioning strategy."**
Two cards:
- Scrape + summarise each page → **Haiku** subagents (score 2)
- Positioning strategy from the summaries → **Opus** (score 7)
