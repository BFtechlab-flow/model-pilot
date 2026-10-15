# 🧭 Model Pilot

**The right Claude model for every task. Free, open source, works in Claude Code and in the Claude app.**

Model Pilot scores each task on five dimensions, picks the smallest Claude model that will do it well (Haiku, Sonnet, Opus or Fable), suggests the effort level, and explains the choice in one line. In Claude Code it goes further: it hands subtasks to subagents that run on the chosen model, so a search runs on Haiku while the hard debugging runs on Opus.

```
🧭 Model Pilot → Opus · effort high
Why: intermittent production bug, unknown cause, money at stake (score 9/10).
Switch: /model opus   (Claude app: pick Opus in the model menu)
```

Made by **[BF Tech Lab](#about-bf-tech-lab)**.

---

## Why

- **Save money and usage limits.** Most requests don't need the biggest model. Routine work on Haiku or Sonnet leaves more of your plan for the tasks that need Opus.
- **Get better results on hard problems.** It also works the other way: when a task needs deep reasoning, Model Pilot tells you before a weaker model wastes your time.
- **Learn the models.** The one-line "Why" shows what makes a task easy or hard, so you start choosing well yourself.

## How it decides

Each task gets 0–2 points on five dimensions:

| Dimension | Low (0) | High (2) |
|---|---|---|
| Reasoning depth | Reformat, extract | Multi-step reasoning, design |
| Scope | One small item | Whole codebase, many documents |
| Ambiguity | Fully specified | Goal unclear, needs investigation |
| Stakes | Throwaway | Production, money, legal, clients |
| Autonomy | One reply | Long unattended run |

Then: **0–2 → Haiku · 3–5 → Sonnet · 6–8 → Opus · 9–10 → Opus, with Fable offered.**

Modifiers adjust the score for batch work (cheaper), a previous failed attempt (stronger), and anything you ask for explicitly. A few guard rails apply on top: client-facing writing never goes below Sonnet, architecture and security start at Opus, and Fable is never used without your yes.

## Install

### Claude Code (recommended: plugin with routing subagents)

```
/plugin marketplace add BFtechlab-flow/model-pilot
/plugin install model-pilot@bftechlab
```

This installs the skill plus three subagents: `pilot-haiku`, `pilot-sonnet` and `pilot-opus`. Claude also delegates to them on its own when a subtask fits their description, which saves tokens even when you don't call the skill.

You'll be asked for a **routing mode**: `balanced` (default), `economy` or `quality`. Change it later in `/config`.

**Skill only, no plugin:** copy `skills/model-pilot/` to `~/.claude/skills/model-pilot/`.

### Claude app (claude.ai, desktop, mobile)

1. Download `model-pilot.zip` from the [latest release](https://github.com/BFtechlab-flow/model-pilot/releases/latest).
2. In Claude, make sure **Code execution and file creation** is on in **Settings → Capabilities**.
3. Go to **Customize → Skills → + → Upload a skill** and pick the ZIP.
4. Turn the skill on.

In the app, Claude can't change the model by itself, so Model Pilot tells you which model to pick from the model menu, and warns you when the current one is too weak for the task.

## Use it

Just ask:

- *"Which model should I use for this?"*
- *"Route this: migrate the auth module to the new API."*
- *"Pick the cheapest model that can do this well."*

In Claude Code you can also type `/model-pilot` (or `/model-pilot:model-pilot`).

Change the mode for one conversation by saying *"economy mode"* or *"quality mode"*.

## What's inside

```
model-pilot/
├── .claude-plugin/
│   ├── plugin.json          # plugin manifest
│   └── marketplace.json     # lets people install from this repo
├── skills/model-pilot/
│   ├── SKILL.md             # the routing logic (works everywhere)
│   └── references/
│       ├── models.md        # tiers, current versions, how to switch
│       └── examples.md      # worked examples
├── agents/
│   ├── pilot-haiku.md       # fast worker (Claude Code)
│   ├── pilot-sonnet.md      # balanced worker
│   └── pilot-opus.md        # deep-reasoning worker
└── scripts/package.sh       # builds the ZIP for the Claude app
```

When Anthropic releases new models, only `references/models.md` needs updating: the routing rules use tier names, and the aliases (`haiku`, `sonnet`, `opus`) always point to the newest version.

## Contributing

Issues and pull requests are welcome, especially new worked examples and cases where the routing got it wrong. Please include the task, the tier Model Pilot chose, and the tier you think was right.

Run `bash scripts/package.sh` to build the ZIP locally, and `claude plugin validate .` to check the manifests.

## About BF Tech Lab

**BF Tech Lab** is a web and AI studio based in Bergamo, Italy. We build fast websites, custom apps and AI automations for small businesses in Italy and the US.

Model Pilot is free and always will be. If it saves you time and you'd like help with a website, an app, or putting AI to work in your business, get in touch: **bftechlabselling@gmail.com**

## License

MIT. See [LICENSE](LICENSE).

---

### 🇮🇹 In italiano

**Model Pilot** sceglie il modello Claude giusto (Haiku, Sonnet, Opus o Fable) e il livello di effort per ogni richiesta, spiegando il perché in una riga. Su Claude Code affida le sotto-attività a sotto-agenti che girano sul modello scelto; nell'app Claude ti dice quale modello selezionare dal menu e ti avvisa se quello attuale non basta.

**Installazione su Claude Code:**
```
/plugin marketplace add BFtechlab-flow/model-pilot
/plugin install model-pilot@bftechlab
```

**Installazione sull'app Claude:** scarica `model-pilot.zip` dall'[ultima release](https://github.com/BFtechlab-flow/model-pilot/releases/latest), poi **Personalizza → Skill → + → Carica una skill**.

Gratuito e open source, realizzato da **BF Tech Lab** (Bergamo). Per siti web, app e automazioni AI per la tua attività: **bftechlabselling@gmail.com**
