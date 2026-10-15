# Model reference

Last reviewed: October 2026. Aliases (`haiku`, `sonnet`, `opus`, `fable`) always point to the newest model of each family, so prefer them over full IDs.

## Tiers

| Tier | Current model | API model ID | Strengths | Typical cost / speed |
|---|---|---|---|---|
| **Haiku** | Haiku 5.5 | `claude-haiku-5-5` | Fast, cheap, good at well-defined tasks; 1M context | Fastest, cheapest |
| **Sonnet** | Sonnet 5.5 | `claude-sonnet-5-5` | Best default: everyday coding, writing, analysis, agentic work | Mid |
| **Opus** | Opus 5.5 | `claude-opus-5-5` | Deep reasoning, architecture, hard debugging, high-stakes work | Higher |
| **Fable** | Fable 5.1 | `claude-fable-5-1` | Hardest, longest autonomous work; investigates and verifies on its own | Highest; may bill to usage credits |

Exact prices change. Point users to https://www.anthropic.com/pricing rather than quoting numbers.

## What each tier is for

**Haiku**
- Look up, reformat, convert (JSON ↔ CSV, units, date formats)
- Extract fields from text the user provided
- Classify, tag, or sort many short items
- Short translations, spelling and grammar fixes
- Renames, simple regex, boilerplate, small single-file edits
- Codebase search and "where is X defined" (as a subagent)
- Summarising a short document

**Sonnet**
- Implementing a feature with a clear scope
- Fixing a bug with a known reproduction
- Writing emails, posts, product copy, documentation, proposals
- Data analysis and charts from a provided dataset
- Research that needs synthesis across several sources
- Most multi-step agentic tasks
- Reviewing a pull request of normal size

**Opus**
- Architecture and system design, choosing between approaches
- Debugging that spans many files or already failed once
- Large refactors and migrations
- Security review, threat modelling
- Legal, financial or medical document analysis where nuance matters
- Maths, proofs, algorithm design
- Ambiguous requests where the first job is to work out what is actually needed
- Long-form writing where structure and argument matter (reports, business plans)

**Fable** (only with the user's explicit yes)
- Multi-hour autonomous sessions
- Root-cause investigations of outages or flaky systems
- Tasks you would normally break into several sittings
- Problems Opus could not solve
- Note: requests that trip its safety classifiers (mostly cybersecurity and biology) can fall back to Opus automatically, so for security research Opus is usually the more predictable choice.

## Effort levels (Claude Code)

`low`, `medium`, `high`, `xhigh`, `max`. The 5.5 models default to `medium`.

- `low`: quick exchanges you review each step of
- `medium`: day-to-day work with a clear scope
- `high`: when verification matters or edge cases are likely
- `xhigh` / `max`: hard problems you want worked through unattended; `max` can overthink, use sparingly

Set it with `/effort <level>`, or in the `/model` picker with the left and right arrow keys. For one deep turn without changing the setting, include the word `ultrathink` in the prompt.

## How to switch

### Claude Code

| Goal | Command |
|---|---|
| Switch the session model | `/model haiku` · `/model sonnet` · `/model opus` · `/model fable` |
| Open the picker | `/model` (Enter saves as default, `s` for this session only) |
| Plan with Opus, build with Sonnet | `/model opusplan` |
| Start a session on a model | `claude --model sonnet` |
| Change effort | `/effort medium` |
| Run every subagent on one model | env `CLAUDE_CODE_SUBAGENT_MODEL=haiku` |

Subagents: a subagent's `model` frontmatter, or the `model` parameter Claude passes when spawning it, decides its model. Without either, it inherits the session model.

### Claude app (claude.ai, desktop, mobile)

Pick the model from the model menu in the message box before sending. The choice applies to the next messages; for a long task, start a new chat on the chosen model so every turn runs on it. Model availability depends on the plan.

## Keeping this file current

When Anthropic releases a new model, update the "Current model" and "API model ID" columns. The routing rules in SKILL.md use tier names, so they do not need to change.
