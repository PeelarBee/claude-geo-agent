# claude-geo-agent

A Claude Code agent for GEO (Generative Engine Optimization) — helping any business become visible in AI-generated answers across ChatGPT, Perplexity, Claude, Gemini, and Bing Copilot.

## What This Agent Does

- Detects if your site is a SPA (invisible to AI crawlers)
- Audits robots.txt for blocked AI crawlers + disallowed route leaks
- Creates or optimizes your `llms.txt` file
- Scores content for AI citability and provides rewrite suggestions
- Implements schema markup for AI discoverability
- Checks brand mentions across AI-cited platforms (Wikipedia, Reddit, YouTube, LinkedIn)
- Generates a full LLM visibility monitoring prompt library for your business
- Produces a client-ready output folder with fix guide, audit, and backlog

## How to Use

Invoke in Claude Code:

```
@geo-agent
```

The agent will ask you a few questions about your business, then run the selected objective and generate an output folder.

## Installation

```bash
git clone https://github.com/PeelarBee/claude-geo-agent.git
cd claude-geo-agent
chmod +x install.sh
./install.sh
```

Then restart Claude Code.

## API Setup

Set these in your environment or Claude Code settings before running the agent.

| API | Required | What it's used for | Cost | Link |
|---|---|---|---|---|
| **Serper** | Recommended | Search evidence and competitor research. Does not run LLM prompts. | 2,500 free searches/month — no credit card required | [serper.dev](https://serper.dev) |
| **Gemini API** | Recommended for monitoring | Run LLM visibility prompts in Gemini | Free with limits | [aistudio.google.com](https://aistudio.google.com) |
| **Groq API** | Recommended for monitoring | Run LLM visibility prompts with fast, low-cost/open models | Free with generous limits | [console.groq.com](https://console.groq.com) |
| **OpenAI API** | Optional | Run LLM visibility prompts in ChatGPT-style models | Paid | [platform.openai.com](https://platform.openai.com) |
| **Anthropic API** | Optional | Run LLM visibility prompts in Claude | Paid | [console.anthropic.com](https://console.anthropic.com) |
| **Perplexity API** | Optional | Run answer-engine style visibility prompts | Paid | [docs.perplexity.ai](https://docs.perplexity.ai) |
| **PageSpeed API** | Not needed | Core Web Vitals (used automatically) | Free, no key required | [developers.google.com/speed](https://developers.google.com/speed) |

**Important:** Serper is a search API, not an LLM provider. If only `SERPER_API_KEY` is configured, the agent can do competitor/search research but it must not claim that ChatGPT, Claude, Gemini, Groq, or Perplexity prompts were run.

For automatic LLM visibility results, configure at least one LLM provider key. Without an LLM provider key, the agent should still generate `05-LLM-PROMPTS.md`, but `07-VISIBILITY-RESULTS.md` must say `Not run — no LLM provider configured`.

Use `.env.example` as a blank template:

```bash
SERPER_API_KEY=
GEMINI_API_KEY=
GOOGLE_API_KEY=
GROQ_API_KEY=
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
PERPLEXITY_API_KEY=
```

## Output Files

The agent generates a folder named `[domain]-geo-audit/` in your current directory:

| File | Contents |
|---|---|
| `00-START-HERE.md` | Plain-English summary: what happened, what matters, what to do first |
| `00-PREFLIGHT.md` | Initial site health check — SPA detection, robots.txt, llms.txt status |
| `01-FIX-GUIDE.md` | Step-by-step fixes in priority order (most important file) |
| `02-GEO-AUDIT.md` | Full GEO score with citability, crawler access, brand mentions, schema |
| `03-LLMS-TXT.md` | Ready-to-upload llms.txt file |
| `04-SCHEMA.md` | Schema markup JSON-LD code ready to implement |
| `05-LLM-PROMPTS.md` | Prompts to run in LLMs; this is not the measurement result |
| `06-BACKLOG.md` | Full task list prioritized by impact |
| `07-VISIBILITY-RESULTS.md` | Actual LLM answer results by prompt group; generated only when prompts were executed |

Important: `05-LLM-PROMPTS.md` is the test plan. `07-VISIBILITY-RESULTS.md` is the measured result. If no LLM provider API keys are configured, the agent must say that results were not collected.

## Objectives

When invoking the agent, choose one:

| Objective | What it does |
|---|---|
| `full-audit` | Complete GEO audit + all output files |
| `monitor` | Run LLM measurement prompts + extraction + validation |
| `refresh` | Update gaps, opportunities, and backlog from new data |
| `llms-txt` | Create or improve llms.txt only |
| `citability` | Score content for AI citation readiness |
| `schema` | Schema markup audit and implementation |
| `crawlers` | AI crawler access check and fix |
| `brand-mentions` | Brand presence across AI-cited platforms |
| `llm-prompts` | Generate LLM visibility monitoring prompt library |
| `quick-check` | Fast pre-flight status — no deep analysis |

## Prompt Run Modes

The 40 prompts are grouped into phases, so the agent can run the right level of depth:

| Mode | Prompt groups |
|---|---|
| `quick-check` | Pre-flight only |
| `monitor` | Measurement `10-17` + Extraction `20-25` + Validation `90` |
| `full-audit` | Discovery `01-05` + Measurement `10-17` + Extraction `20-25` + Validation `90` + Interpretation `30-34` + Audit `40-48` + Action `50-53` + Learning `60-61` |
| `refresh` | Interpretation `30-34` + selected Audit `40-48` + Action `50-53` + Learning `60-61` |

## Requirements

- [Claude Code](https://claude.ai/code) installed
- macOS or Linux
- `curl` and `python3` available (pre-installed on most systems)
