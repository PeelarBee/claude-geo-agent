# claude-geo-agent

A Claude Code agent for GEO (Generative Engine Optimization) - helping businesses audit, improve, and monitor their readiness for AI-generated answers and answer-engine discovery.

## What This Agent Does

- Detects whether important content depends heavily on client-side rendering and may be difficult for crawlers or answer engines to access
- Audits robots.txt for blocked AI crawlers + disallowed route leaks
- Creates or optimizes your `llms.txt` file
- Scores content for AI citation readiness and provides rewrite suggestions
- Generates structured data recommendations and ready-to-implement JSON-LD
- Checks external brand authority signals across search and commonly surfaced third-party platforms such as Wikipedia, Reddit, YouTube, and LinkedIn
- Generates a full LLM visibility monitoring prompt library for your business
- Produces a client-ready output folder with run plan, technical audit, fix guide, prompts, visibility results, and backlog

## How to Use

Invoke in Claude Code:

```
@geo-agent
```

The agent asks for the website URL and objective, auto-detects the business context, asks you to confirm it, then runs the selected objective and generates an output folder.

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
| **Serper** | Recommended | Search evidence, competitor research, external authority signals, brand mentions in search surfaces. Does not run LLM prompts. | 2,500 free searches/month — no credit card required | [serper.dev](https://serper.dev) |
| **Gemini API** | Recommended for monitoring | Run LLM visibility prompts in Gemini | Free with limits | [aistudio.google.com](https://aistudio.google.com) |
| **Groq API** | Recommended for monitoring | Run LLM visibility prompts with fast, low-cost/open models | Free with generous limits | [console.groq.com](https://console.groq.com) |
| **OpenAI API** | Optional | Run LLM visibility prompts through OpenAI API models | Paid | [platform.openai.com](https://platform.openai.com) |
| **Anthropic API** | Optional | Run LLM visibility prompts in Claude | Paid | [console.anthropic.com](https://console.anthropic.com) |
| **Perplexity API** | Optional | Run answer-engine style visibility prompts | Paid | [docs.perplexity.ai](https://docs.perplexity.ai) |
| **PageSpeed API** | Not needed | Core Web Vitals (used automatically) | Free, no key required | [developers.google.com/speed](https://developers.google.com/speed) |

**Important:** Serper is a search provider only. It must never be treated as an LLM provider and must never be used to claim ChatGPT, Claude, Gemini, Groq, OpenAI, Perplexity, or Bing Copilot visibility. If only `SERPER_API_KEY` is configured, the agent can collect search evidence, competitor research, external authority signals, and brand mentions in search surfaces, but `07-LLM-VISIBILITY-RESULTS.md` must still say `Not run — no LLM provider configured`.

For automatic LLM visibility results, configure at least one LLM provider key. Without an LLM provider key, the agent should still generate `06-LLM-PROMPTS-TO-RUN.md`, but `07-LLM-VISIBILITY-RESULTS.md` must say `Not run — no LLM provider configured`.

## API Categories

Search provider:

| API | Used for |
|---|---|
| `SERPER_API_KEY` | Search evidence, competitor research, external authority signals, brand mentions in search surfaces |

LLM providers:

| API | Used for |
|---|---|
| `GEMINI_API_KEY` or `GOOGLE_API_KEY` | Gemini prompt execution |
| `GROQ_API_KEY` | Groq model prompt execution |
| `OPENAI_API_KEY` | OpenAI prompt execution |
| `ANTHROPIC_API_KEY` | Claude prompt execution |
| `PERPLEXITY_API_KEY` | Perplexity prompt execution |

At least one LLM provider key is required to run measurement prompts and create measured LLM visibility results.

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

## Measurement Boundaries

- Search APIs are not LLM answer engines.
- Prompt libraries are not measurement results.
- LLM answers vary by model, provider, date, location, personalization, retrieval mode, and prompt wording.
- The agent must not report measured visibility unless the relevant provider was configured and the prompt run was completed.
- If no LLM provider is configured, `07-LLM-VISIBILITY-RESULTS.md` must say: `Not run — no LLM provider configured`.

## Quality & Reliability

These files keep the agent repeatable, evidence-based, and safe for client-facing GEO audits:

- [EVIDENCE-RULES.md](EVIDENCE-RULES.md) - evidence classes and claim rules
- [SCORING.md](SCORING.md) - GEO Visibility Score framework
- [OUTPUT-CONTRACT.md](OUTPUT-CONTRACT.md) - required report structure
- [LIMITATIONS.md](LIMITATIONS.md) - client-safe limitations
- [EVALS.md](EVALS.md) - practical eval cases for agent behavior
- [AGENT.md](AGENT.md) - operating instructions and guardrails

## Output Files

The agent generates a folder named `[domain]-geo-audit/` in your current directory:

| File | Contents |
|---|---|
| `00-START-HERE.md` | Plain-English summary: what happened, what matters, what to do first |
| `01-RUN-PLAN.md` | What will run, what is blocked, and which APIs are needed |
| `02-TECHNICAL-GEO-AUDIT.md` | Technical site health check — SPA detection, robots.txt, llms.txt status, schema |
| `03-FIX-GUIDE.md` | Step-by-step fixes in priority order |
| `04-LLMS-TXT.md` | Ready-to-upload or improved llms.txt file |
| `05-SCHEMA.md` | Schema markup JSON-LD code ready to implement |
| `06-LLM-PROMPTS-TO-RUN.md` | Prompts to run in LLMs; this is not the measurement result |
| `07-LLM-VISIBILITY-RESULTS.md` | Actual LLM answer results by prompt group, or explicit `not run` status |
| `08-BACKLOG.md` | Full task list prioritized by impact |

Important: `06-LLM-PROMPTS-TO-RUN.md` is the test plan. `07-LLM-VISIBILITY-RESULTS.md` is the measured result file only when prompts were executed through configured LLM providers. If no LLM provider API keys are configured, `full-audit` still completes the readiness audit and prompt library, while `monitor` must ask whether to add a provider key or generate prompts for manual execution only.

## Objectives

When invoking the agent, choose one:

| Objective | What it does |
|---|---|
| `full-audit` | Complete GEO readiness audit + prompt library + measured LLM visibility when provider keys are configured |
| `monitor` | Run LLM measurement prompts + extraction + validation |
| `refresh` | Update gaps, opportunities, and backlog from new data |
| `llms-txt` | Create or improve llms.txt only |
| `citability` | Score content for AI citation readiness |
| `schema` | Schema markup audit and implementation |
| `crawlers` | AI crawler access check and fix |
| `brand-mentions` | External brand authority signals across search and commonly surfaced third-party platforms |
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

For `full-audit`, measurement phases run only when at least one LLM provider key is configured. If no LLM provider is configured, the agent completes the readiness audit, generates the prompt library, and marks `07-LLM-VISIBILITY-RESULTS.md` as `Not run — no LLM provider configured`.

## Requirements

- [Claude Code](https://claude.ai/code) installed
- macOS or Linux
- `curl` and `python3` available (pre-installed on most systems)
