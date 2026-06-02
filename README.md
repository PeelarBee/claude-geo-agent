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

## Required API Keys

Set these in your environment or Claude Code settings before running the agent.

| API | Required | What it's used for | Cost | Link |
|---|---|---|---|---|
| **Serper** | Recommended | Competitor research, find what's ranking | 2,500 free searches/month — no credit card required. Most generous free tier of any SERP API. Effectively free for most audit use cases | [serper.dev](https://serper.dev) |
| **Gemini API** | Optional | Run LLM visibility prompts in Gemini | ✅ Free with limits (15 req/min) | [aistudio.google.com](https://aistudio.google.com) |
| **Groq API** | Optional | Run LLM visibility prompts (fast, free) | ✅ Free with generous limits | [console.groq.com](https://console.groq.com) |
| **OpenAI API** | Optional | Run LLM visibility prompts in ChatGPT | 💰 Paid (~$0.002/1K tokens) | [platform.openai.com](https://platform.openai.com) |
| **Anthropic API** | Optional | Run LLM visibility prompts in Claude | 💰 Paid (Haiku is cheapest) | [console.anthropic.com](https://console.anthropic.com) |
| **PageSpeed API** | Not needed | Core Web Vitals (used automatically) | ✅ Free, no key required | [developers.google.com/speed](https://developers.google.com/speed) |

**Note:** The agent runs pre-flight checks and GEO audits using `curl` and `WebFetch` — no API key required for the core audit. API keys are only needed for competitor research (Serper) and LLM visibility monitoring (AI provider APIs).

### Setting up Serper in Claude Code

Add to your `~/.claude.json` under MCP servers, or set the environment variable:

```bash
export SERPER_API_KEY=your_key_here
```

## Output Files

The agent generates a folder named `[domain]-geo-audit/` in your current directory:

| File | Contents |
|---|---|
| `00-PREFLIGHT.md` | Initial site health check — SPA detection, robots.txt, llms.txt status |
| `01-FIX-GUIDE.md` | Step-by-step fixes in priority order (most important file) |
| `02-GEO-AUDIT.md` | Full GEO score with citability, crawler access, brand mentions, schema |
| `03-LLMS-TXT.md` | Ready-to-upload llms.txt file |
| `04-SCHEMA.md` | Schema markup JSON-LD code ready to implement |
| `05-LLM-PROMPTS.md` | LLM visibility monitoring prompts instanced for your business |
| `06-BACKLOG.md` | Full task list prioritized by impact |

## Objectives

When invoking the agent, choose one:

| Objective | What it does |
|---|---|
| `full-audit` | Complete GEO audit + all output files |
| `llms-txt` | Create or improve llms.txt only |
| `citability` | Score content for AI citation readiness |
| `schema` | Schema markup audit and implementation |
| `crawlers` | AI crawler access check and fix |
| `brand-mentions` | Brand presence across AI-cited platforms |
| `llm-prompts` | Generate LLM visibility monitoring prompt library |
| `quick-check` | Fast pre-flight status — no deep analysis |

## Requirements

- [Claude Code](https://claude.ai/code) installed
- macOS or Linux
- `curl` and `python3` available (pre-installed on most systems)
