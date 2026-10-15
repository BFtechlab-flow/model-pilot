---
name: model-pilot
description: Picks the right Claude model (Haiku, Sonnet, Opus or Fable) and effort level for a task, explains why in one line, then routes the work. Use when the user asks which model to use, wants the best or cheapest model for a task, says "route this", "pick the model", "use the right model", or before starting a large or costly task. In Claude Code it can delegate subtasks to subagents running on the chosen model; in the Claude app it tells the user exactly how to switch.
license: MIT
compatibility: Works in Claude Code (CLI, desktop, IDE) and in the Claude app (web, desktop, mobile). Subagent routing requires Claude Code.
metadata:
  author: BF Tech Lab
  homepage: https://github.com/bftechlab/model-pilot
  version: "1.0.0"
---

# Model Pilot

Choose the smallest Claude model that will do the job well, say why in one line, and route the work. Optimize for **quality first, then cost and speed**: never downgrade a task that needs the stronger model.

Respond in the user's language.

## Settings

- Mode: `${user_config.mode}`
  - If this line shows a literal placeholder (not `balanced`, `economy` or `quality`), the mode is **balanced**, unless the user said otherwise in this conversation ("economy mode", "quality mode", "don't spend much", "money is no object").
  - `economy`: when two tiers are close, pick the cheaper one. Never suggest Fable unprompted.
  - `balanced`: follow the rubric as written.
  - `quality`: when two tiers are close, pick the stronger one.

## Step 1: Score the task

Rate each dimension 0, 1 or 2. Read the request, any attached files, and the conversation so far.

| Dimension | 0 | 1 | 2 |
|---|---|---|---|
| **Reasoning depth** | Recall, reformat, extract | Some analysis or judgment | Multi-step reasoning, trade-offs, proofs, novel design |
| **Scope** | One small item | A few files, a document, a feature | Whole codebase, many documents, many dependent steps |
| **Ambiguity** | Fully specified | Some gaps to fill sensibly | Unclear goal, needs investigation to even define |
| **Stakes** | Throwaway, easy to redo | Will be used or shared | Costly if wrong: production, legal, money, security, a client deliverable |
| **Autonomy** | One reply | A short agentic loop | Long unattended run, hours of work, many tool calls |

Then apply the modifiers:

- **Volume / latency**: many near-identical items (batch classification, extraction, translation of short strings) or a need for instant replies → subtract 2 (minimum 0).
- **Prior failure**: a weaker model already tried this and failed or went in circles → add 3.
- **Explicit user preference** always wins ("use Opus", "keep it cheap").

## Step 2: Map the score to a tier

| Total | Tier | Default effort (Claude Code) |
|---|---|---|
| 0–2 | **Haiku** | low |
| 3–5 | **Sonnet** | medium |
| 6–8 | **Opus** | medium (high if stakes = 2) |
| 9–10 | **Opus**, and offer **Fable** | high |

Sanity checks after scoring:

- Writing that represents the user to clients, investors or the public rarely belongs on Haiku, even if short. Floor it at Sonnet.
- Debugging that already failed once on Sonnet goes to Opus, regardless of score.
- Architecture, system design and security review start at Opus.
- **Fable** is for the hardest, longest work: multi-hour autonomous sessions, root-cause investigations, tasks you would normally split into many sittings. It can cost usage credits on some plans. Never switch to Fable or spawn work on it without the user's explicit yes.

For tier details, current versions and how to switch on each surface, read `references/models.md`. For worked examples, read `references/examples.md`.

## Step 3: Show the routing card

Keep it to three or four lines. No preamble.

```
🧭 Model Pilot → Sonnet · effort medium
Why: clear-scope feature in 3 files, moderate stakes (score 4/10).
Switch: /model sonnet   (Claude app: pick Sonnet in the model menu)
```

Rules for the card:

- One "Why" line, naming the two or three dimensions that decided it and the score.
- If the current model already matches, say `Already on the right model.` and skip the "Switch" line.
- If you are unsure between two tiers, name both and say what would tip it: `Sonnet, or Opus if the migration touches the payment flow.`
- If the request mixes parts of very different difficulty, give one card per part (max 3).

## Step 4: Route the work

First work out where you are running:

- **Claude Code**: you have an Agent (subagent) tool and the user can type `/model` and `/effort`.
- **Claude app** (claude.ai web, desktop, mobile): no subagent tool; the model is picked from the model menu in the chat input.

### In Claude Code

1. **Delegable subtasks** (search, summarise, run tests, bulk edits, research that returns a summary): spawn a subagent on the chosen tier.
   - If the `model-pilot` plugin is installed, use its agents: `model-pilot:pilot-haiku`, `model-pilot:pilot-sonnet`, `model-pilot:pilot-opus`.
   - Otherwise pass the `model` parameter on the Agent tool call (`haiku`, `sonnet`, `opus`) with a general-purpose subagent.
   - Give the subagent a self-contained brief: it does not see this conversation.
   - Downgrades (running on a cheaper model than the session) need no confirmation. Upgrades to Opus are fine when the user invoked this skill or asked for routing. Fable always needs a yes.
2. **Work that needs the main conversation** (iterative back-and-forth, shared context across phases): recommend `/model <tier>` and, when useful, `/effort <level>`. Do not proceed on a weaker model than the task needs; ask the user to switch first, or offer to delegate the hard part to a `pilot-opus` subagent instead.
3. For a plan-then-build task, suggest `/model opusplan` (Opus while planning, Sonnet while executing).

### In the Claude app

You cannot change the model yourself. After the card:

- If the current model is **stronger** than needed: just do the task; mention the cheaper option for next time in the "Switch" line.
- If the current model is **weaker** than needed: say so plainly and ask whether to proceed anyway or wait while they switch. If they proceed, do your best and flag the parts most likely to need a second pass.
- If the current model matches: do the task.

Tell them to start a **new chat** on the chosen model for long tasks, so the whole conversation runs on it.

## Things to avoid

- Don't route trivial chit-chat or one-line questions. If the user didn't ask for routing and the task is small, skip the card and answer.
- Don't invent prices or benchmark numbers. Speak in relative terms (Haiku is the fastest and cheapest, Opus costs more per token than Sonnet).
- Don't repeat the card on every turn of the same task. Re-route only when the task changes or a tier fails.
- Don't advertise anything in your replies. Just route well.
