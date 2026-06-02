# claude-geo-agent — Full Documentation

## What This Agent Does — Simple Overview

A GEO (Generative Engine Optimization) agent that audits and improves how a business appears in AI-generated answers — ChatGPT, Perplexity, Claude, Gemini, and Bing Copilot.

**Step by step:**
1. Asks 7 questions about the business (name, domain, industry, services, customers, competitors, objective)
2. Runs 5 pre-flight checks: detects if the site is invisible to AI crawlers (SPA), checks which AI bots are blocked, verifies llms.txt exists and is accurate, checks schema markup, checks HTTPS
3. Creates or rewrites the `llms.txt` file using only real copy from the site
4. Scores content pages for AI citability — identifies which passages AI systems will quote and which they won't
5. Validates and generates schema markup (JSON-LD) ready to implement
6. Checks brand presence on Wikipedia, Reddit, YouTube, LinkedIn, and industry directories
7. Generates 40 monitoring prompts fully instanced for the business — ready to run in any LLM
8. Delivers an output folder with: pre-flight report, fix guide, GEO audit, llms.txt, schema code, prompt library, and prioritized backlog

**Output folder:**

| File | Contents |
|---|---|
| `00-PREFLIGHT.md` | Initial site health check |
| `01-FIX-GUIDE.md` | Step-by-step fixes in priority order *(most important)* |
| `02-GEO-AUDIT.md` | Full GEO score and analysis |
| `03-LLMS-TXT.md` | Ready-to-upload llms.txt file |
| `04-SCHEMA.md` | Schema markup code ready to implement |
| `05-LLM-PROMPTS.md` | 40 monitoring prompts for this business |
| `06-BACKLOG.md` | Prioritized task list |

---

## Prompt Library Index

| Module | Prompts | What they do | Frequency |
|---|---|---|---|
| 1 — Discovery | 5 | Generate full query universe, map market language, find competitor-dominant queries | Monthly |
| 2 — Measurement | 8 | Ready-to-run branded, category, comparison, transactional, local, educational queries | Weekly / Bi-weekly |
| 3 — Extraction | 6 | Parse LLM responses into structured data (mentions, sentiment, positioning, share of voice) | Every run |
| 4 — Interpretation | 5 | Explain why brand is missing, why competitors win, citation patterns, messaging gaps | Weekly |
| 5 — Audit | 9 | Score homepage, service pages, pricing, FAQ coverage, schema, content clusters, trust signals | Monthly |
| 6 — Action | 4 | Content gap plan, technical fixes plan, optimization backlog, URL-level recommendations | Weekly |
| 7 — Learning | 2 | Generate new prompts from gaps, detect emerging opportunities | Monthly |
| 8 — Validation | 1 | Validate JSON output before logging results | Every run |
| **Total** | **40** | | |

**Starter run (8 prompts for a fast first pass):** Branded visibility + Category visibility + Comparison + Mentions extractor + Gap analysis + Service page audit + Content action plan + Output validator

See [PROMPTS-INDEX.md](PROMPTS-INDEX.md) for the full breakdown of every prompt.

---

## What This Agent Is

`claude-geo-agent` is a Claude AI agent that audits and improves how a business appears in AI-generated answers. When someone asks ChatGPT, Perplexity, Claude, or Gemini for recommendations in your category, this agent helps ensure your brand shows up — and shows up well.

This is called **GEO: Generative Engine Optimization**. It is to AI search what SEO is to Google.

---

## Who It's For

- Marketers and SEO professionals managing AI visibility for clients or their own business
- Teams running AI Visibility audits
- Founders who want to understand why their brand doesn't appear in AI answers
- Any team that needs to audit and improve LLM visibility across verticals

No coding required to use the agent. Technical knowledge of SEO/GEO recommended.

---

## How to Run It

### Option A — Claude.ai Web (no installation)

1. Go to [claude.ai](https://claude.ai)
2. Create a new **Project**
3. In Project Instructions, paste the full content of `agents/geo-agent.md`
4. Start a conversation and tell Claude: *"Run a GEO audit for [domain]"*

**Best for:** Getting audit reports and fix guides to share with developers. Claude will guide you through everything and generate all output files as text you can copy.

**Limitation:** Claude cannot run terminal commands or edit files directly from the web. All fixes need to be implemented manually.

### Option B — Claude Code (full power)

1. Clone the repo and run `./install.sh`
2. Open Claude Code in your terminal
3. Type: `@geo-agent`

**Best for:** Full automation. Claude can run technical checks, create files, and implement fixes directly in your project without manual steps.

**Requirement:** Claude Code installed ([claude.ai/code](https://claude.ai/code)), basic terminal comfort.

---

## What the Agent Does — Full Capability List

### Pre-Flight Checks (always runs first)
- **SPA Detection** — identifies if the site is built with React, Vue, or Vite (common in Lovable). SPAs are invisible to AI crawlers.
- **robots.txt audit** — checks which AI crawlers are blocked (GPTBot, ClaudeBot, PerplexityBot, etc.)
- **Disallowed routes sanity check** — verifies that blocked routes are actually closed (not returning 200 OK)
- **llms.txt status** — checks if the file exists and evaluates its quality
- **Schema markup detection** — identifies existing JSON-LD structured data
- **HTTPS and security headers** — basic security check

### GEO Audit
- **Citability scoring** — scores every content block on 5 dimensions: Answer Quality, Self-Containment, Structural Readability, Statistical Density, Uniqueness
- **AI Crawler Access** — scores access for 10 AI crawlers with specific fix recommendations
- **Brand Mentions** — checks presence on Wikipedia, Reddit, YouTube, LinkedIn, and industry directories
- **llms.txt quality** — evaluates and rewrites if needed
- **Schema validation** — validates existing schemas and generates missing ones

### Content Citability Optimization
- Identifies passages AI systems are likely to cite
- Rewrites low-scoring passages using answer-first pattern
- Recommends structural improvements (tables, lists, definition patterns)

### llms.txt Creation
- Fetches every key page via WebFetch
- Uses only real copy from the site (never fabricates)
- Writes a complete, structured llms.txt ready to upload
- Handles SPA sites where this file is the only AI-readable content

### Schema Markup
- Detects existing JSON-LD
- Generates missing schemas: Organization, Service, Article, FAQPage, BreadcrumbList, Person
- Output is ready-to-implement code

### Brand Mentions Audit
- Wikipedia API check (most important AI citation signal)
- Reddit presence
- YouTube presence
- LinkedIn company page
- Industry directories (G2, Capterra, Trustpilot, niche sites)

### LLM Visibility Prompt Library
- Generates 40 monitoring prompts fully instanced for the business
- 8 modules: Discovery, Measurement, Extraction, Interpretation, Audit, Action, Learning, Validation
- Ready to run in Gemini, Groq, ChatGPT, or any LLM to track visibility over time
- See [PROMPTS-INDEX.md](PROMPTS-INDEX.md) for the full breakdown

### Output Folder
Generates `[domain]-geo-audit/` with:

| File | Contents |
|---|---|
| `00-PREFLIGHT.md` | Pre-flight check results |
| `01-FIX-GUIDE.md` | Step-by-step fixes in priority order |
| `02-GEO-AUDIT.md` | Full GEO score and analysis |
| `03-LLMS-TXT.md` | Ready-to-upload llms.txt |
| `04-SCHEMA.md` | JSON-LD schema code ready to implement |
| `05-LLM-PROMPTS.md` | 40 monitoring prompts for this business |
| `06-BACKLOG.md` | Prioritized task list |

---

## API Setup

### Option A — Claude.ai Web

No API setup required. Claude.ai handles everything.

If you want to run the LLM visibility prompts (Module 2) against real AI systems, run them manually in each platform's interface (ChatGPT, Gemini, Claude, Perplexity).

### Option B — Claude Code

Set these in your terminal before running the agent:

```bash
export SERPER_API_KEY=your_key_here      # recommended
export GEMINI_API_KEY=your_key_here      # optional
export GROQ_API_KEY=your_key_here        # optional
export OPENAI_API_KEY=your_key_here      # optional
export ANTHROPIC_API_KEY=your_key_here   # optional
```

| API | Required | What it enables | Cost | Link |
|---|---|---|---|---|
| **Serper** | Recommended | Competitor research, find what's ranking | 2,500 free searches/month — no credit card required. Most generous free tier of any SERP API. Effectively free for most audit use cases | [serper.dev](https://serper.dev) |
| **Gemini API** | Optional | Run LLM visibility prompts in Gemini | ✅ Free with limits (15 req/min) | [aistudio.google.com](https://aistudio.google.com) |
| **Groq API** | Optional | Run LLM visibility prompts (fast, free) | ✅ Free with generous limits | [console.groq.com](https://console.groq.com) |
| **OpenAI API** | Optional | Run LLM visibility prompts in ChatGPT | 💰 Paid — see note below | [platform.openai.com](https://platform.openai.com) |
| **Anthropic API** | Optional | Run LLM visibility prompts in Claude | 💰 Paid — see note below | [console.anthropic.com](https://console.anthropic.com) |
| **PageSpeed API** | Not needed | Core Web Vitals (automatic) | ✅ Free, no key needed | [developers.google.com/speed](https://developers.google.com/speed) |


> **Note on OpenAI and Anthropic cost:** For LLM visibility monitoring, the actual cost is usually negligible — under $0.01/month for the starter run using GPT-4o mini (OpenAI) or under $0.02/month using Claude Haiku (Anthropic). These APIs are only needed if you specifically want to track how your brand appears in ChatGPT or Claude responses. For most teams, Gemini and Groq (both free) cover the same use case.

**Without Serper:** The agent still runs full audits using `curl` and `WebFetch`. You only lose the real-time competitor research feature.

---

## Web vs Claude Code — Feature Comparison

| Feature | Claude.ai Web | Claude Code |
|---|---|---|
| Business onboarding | ✅ | ✅ |
| Pre-flight checks | ⚠️ Partial (no curl) | ✅ Full |
| GEO audit report | ✅ | ✅ |
| llms.txt creation | ✅ | ✅ |
| Schema markup generation | ✅ (code only) | ✅ (implements directly) |
| LLM visibility prompts | ✅ | ✅ |
| Fix guide | ✅ (instructions) | ✅ (can implement) |
| SPA detection | ❌ | ✅ |
| robots.txt curl checks | ❌ | ✅ |
| Disallowed routes check | ❌ | ✅ |
| Direct file editing | ❌ | ✅ |
| Serper integration | ❌ | ✅ |
| API key integrations | ❌ | ✅ |

---

## Objectives Quick Reference

| Command | What it runs |
|---|---|
| `full-audit` | Everything — pre-flight + full GEO audit + all output files |
| `monitor` | LLM measurement prompts + extraction + validation |
| `refresh` | Update gaps, opportunities, and backlog from new data |
| `llms-txt` | Create or improve llms.txt only |
| `citability` | Score content for AI citation readiness |
| `schema` | Schema markup audit and implementation |
| `crawlers` | AI crawler access check and fix |
| `brand-mentions` | Brand presence across AI-cited platforms |
| `llm-prompts` | Generate LLM visibility monitoring prompt library |
| `quick-check` | Fast pre-flight status only |

## Prompt Run Modes

The prompt library is grouped into phases. A complete audit can use all 40 prompts, but narrower objectives should run only the relevant groups.

| Mode | Prompt groups |
|---|---|
| `quick-check` | Pre-flight checks only |
| `monitor` | Measurement `10-17` + Extraction `20-25` + Validation `90` |
| `full-audit` | Discovery `01-05` + Measurement `10-17` + Extraction `20-25` + Validation `90` + Interpretation `30-34` + Audit `40-48` + Action `50-53` |
| `refresh` | Interpretation `30-34` + selected Audit `40-48` + Action `50-53` + Learning `60-61` |
