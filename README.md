# claude-geo-agent

A GEO (Generative Engine Optimization) agent for auditing AI search readiness, answer-engine discoverability, and real LLM visibility measurement when providers are configured.

Works with:

- Claude Code as `@geo-agent`
- Codex / OpenAI Skills as the `geo-agent` skill

## Start Here

If you just want to use it, read:

- [QUICKSTART.md](QUICKSTART.md)
- [INSTALLATION.md](INSTALLATION.md)
- [CODEX.md](CODEX.md)
- [NON-TECHNICAL-USER-GUIDE.md](NON-TECHNICAL-USER-GUIDE.md)

## Simple Explanation

This repo is the toolkit.

Installing it copies the toolkit into the AI tool you want to use.

You install one main entry point:

`geo-agent`

You do not manually call every subagent. The main GEO agent calls the internal modules automatically.

## Install For Claude Code

Use this if you want to type:

`@geo-agent`

```bash
git clone https://github.com/PeelarBee/claude-geo-agent.git
cd claude-geo-agent
chmod +x install.sh
./install.sh
```

Restart Claude Code.

Then run:

```txt
@geo-agent
```

What this installs for Claude Code:

- agents into `~/.claude/agents/`
- skills into `~/.claude/skills/`
- scripts, prompts, templates, and docs into `~/.claude/geo-agent/`

## Install For Codex / OpenAI Skills

Use this if you want Codex to use the GEO workflow as a skill.

```bash
git clone https://github.com/PeelarBee/claude-geo-agent.git
cd claude-geo-agent
chmod +x install-codex.sh
./install-codex.sh
```

Restart Codex.

Then ask:

```txt
Run a GEO audit for https://example.com
```

or:

```txt
Use the geo-agent skill to run a full GEO audit.
```

What this installs for Codex:

- main skill `geo-agent` into `~/.agents/skills/geo-agent/`
- internal GEO skills into `~/.agents/skills/`
- support scripts, prompts, templates, agents, and docs into `~/.agents/skills/geo-agent/references/`

## What The Main Agent Does

The main `geo-agent` orchestrates these internal modules:

| Module | Purpose |
|---|---|
| `geo-crawlers` | Crawlability, robots.txt, sitemap, AI crawler access, rendering risk |
| `geo-llms-txt` | Check or draft llms.txt |
| `geo-schema` | Audit and recommend schema/JSON-LD |
| `geo-citability` | Check content answer-readiness and citability |
| `geo-brand-mentions` | Collect search/external authority evidence |
| `geo-llm-prompts` | Generate LLM prompt library/test plan |
| `geo-monitor` | Run real LLM measurement when providers are configured |

## What A Full Audit Produces

- `00-START-HERE.md`
- `01-RUN-PLAN.md`
- `02-TECHNICAL-GEO-AUDIT.md`
- `03-FIX-GUIDE.md`
- `04-LLMS-TXT.md`
- `05-SCHEMA.md`
- `06-LLM-PROMPTS-TO-RUN.md`
- `07-LLM-VISIBILITY-RESULTS.md`
- `08-BACKLOG.md`
- `09-FINAL-REPORT.md`
- `10-API-SETUP-GUIDE.md`
- `11-RUN-TRACE.md`

## Important Boundaries

The agent separates:

1. **Readiness** - whether the site is prepared to be crawled, understood, and cited.
2. **Search Evidence** - what search/third-party surfaces show.
3. **Measured LLM Visibility** - what actually happened after running prompts through providers or documented manual UI runs.
4. **Recommendations** - what to fix first.

Rules:

- Serper is search evidence only, not LLM measurement.
- Generated prompts are a test plan, not measured results.
- OpenAI API results are not ChatGPT UI results unless ChatGPT UI was separately measured and logged.
- If no LLM provider is configured, `07-LLM-VISIBILITY-RESULTS.md` must say: `Status: Not run — no LLM provider configured`.

## Optional APIs

| API | What it adds |
|---|---|
| `SERPER_API_KEY` | Search evidence and external authority research only |
| `GEMINI_API_KEY` / `GOOGLE_API_KEY` | Gemini API measurement |
| `OPENAI_API_KEY` | OpenAI API measurement, not ChatGPT UI |
| `ANTHROPIC_API_KEY` | Anthropic API measurement |
| `GROQ_API_KEY` | Groq model/API measurement |
| `PERPLEXITY_API_KEY` | Perplexity API measurement |

No API is required for a readiness audit.

At least one LLM provider is required for automatic measured LLM visibility.

## Main Docs

- [INSTALLATION.md](INSTALLATION.md) - installation paths for Claude Code and Codex
- [CODEX.md](CODEX.md) - Codex-specific install and usage guide
- [ORCHESTRATION.md](ORCHESTRATION.md) - how the main agent calls internal workers
- [CLAIM-GUARDRAILS.md](CLAIM-GUARDRAILS.md) - what the agent is allowed and not allowed to claim
- [RUN-LOG-SPEC.md](RUN-LOG-SPEC.md) - traceability for every audit run
- [OUTPUT-CONTRACT.md](OUTPUT-CONTRACT.md) - required report structure
- [SCORING.md](SCORING.md) - transparent GEO Readiness Score rules
- [EVALS.md](EVALS.md) - behavior tests for the agent
- [LIMITATIONS.md](LIMITATIONS.md) - client-safe limitations
- [PROMPTS-INDEX.md](PROMPTS-INDEX.md) - the 40-prompt library structure

## Requirements

- Claude Code or Codex/OpenAI Skills
- macOS or Linux for local installers
- `curl`, `bash`, and `python3` for support scripts
