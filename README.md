# claude-geo-agent

A GEO (Generative Engine Optimization) agent for auditing AI search readiness, answer-engine discoverability, and real LLM visibility measurement when providers are configured.

Works with:

- Claude Code as `@geo-agent`
- Codex / OpenAI Skills as the `geo-agent` skill

## The Simple Version

Install once. Restart your AI tool. Type `@geo-agent`.

The user does not call every subagent manually. The main GEO agent calls the internal modules automatically.

## Install For Claude Code

Use this if you want Claude Code to start the agent with:

```txt
@geo-agent
```

Install with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/PeelarBee/claude-geo-agent/main/install.sh | bash
```

Restart Claude Code, then type:

```txt
@geo-agent
```

What this installs for Claude Code:

- agents into `~/.claude/agents/`
- skills into `~/.claude/skills/`
- scripts, prompts, templates, and docs into `~/.claude/geo-agent/`

## Install For Codex / OpenAI Skills

Use this if you want Codex to start the GEO workflow as a skill.

Install with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/PeelarBee/claude-geo-agent/main/install-codex.sh | bash
```

Restart Codex, then type:

```txt
@geo-agent
```

You can also ask naturally:

```txt
Use geo-agent to run a GEO audit for https://example.com
```

What this installs for Codex:

- main skill `geo-agent` into `~/.agents/skills/geo-agent/`
- internal GEO skills into `~/.agents/skills/`
- support scripts, prompts, templates, agents, and docs into `~/.agents/skills/geo-agent/references/`

## Manual Install Alternative

If you already downloaded or cloned the repo, run the installer from inside the repo folder:

```bash
bash install.sh
```

For Codex:

```bash
bash install-codex.sh
```

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
- If no LLM provider is configured, `07-LLM-VISIBILITY-RESULTS.md` must say: `Status: Not run -- no LLM provider configured`.

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

- [QUICKSTART.md](QUICKSTART.md) - fastest way to install and run
- [INSTALLATION.md](INSTALLATION.md) - installation paths for Claude Code and Codex
- [CODEX.md](CODEX.md) - Codex-specific install and usage guide
- [ORCHESTRATION.md](ORCHESTRATION.md) - how the main agent calls internal workers
- [CLAIM-GUARDRAILS.md](CLAIM-GUARDRAILS.md) - what the agent is allowed and not allowed to claim
- [RUN-LOG-SPEC.md](RUN-LOG-SPEC.md) - traceability for every audit run
- [OUTPUT-CONTRACT.md](OUTPUT-CONTRACT.md) - required report structure
- [SCORING.md](SCORING.md) - transparent GEO Readiness Score rules
- [QUALITY-GATES.md](QUALITY-GATES.md) - final checks before an audit is complete
- [EVALS.md](EVALS.md) - behavior tests for the agent
- [LIMITATIONS.md](LIMITATIONS.md) - client-safe limitations
- [PROMPTS-INDEX.md](PROMPTS-INDEX.md) - the 40-prompt library structure

## Requirements

- Claude Code or Codex/OpenAI Skills
- macOS or Linux for local installers
- `curl`, `bash`, and `git` for one-line installation
- `python3` for some support scripts
