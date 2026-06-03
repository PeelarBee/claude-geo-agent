# claude-geo-agent — Full Documentation

## What This Agent Does — Simple Overview

A GEO (Generative Engine Optimization) agent that audits, improves, and monitors a business's readiness to be discovered, understood, and cited in AI-generated answers.

**Step by step:**
1. Asks only for website URL and objective.
2. Fetches the site and proposes the business CONFIG for confirmation.
3. Generates a Run Plan showing what will run, what is blocked, and which APIs are needed.
4. Runs technical pre-flight checks: SPA visibility, AI crawler access, robots.txt, llms.txt, schema, sitemap, HTTPS.
5. Creates or rewrites the `llms.txt` file using factual summaries based only on fetched page content.
6. Scores content pages for AI citation readiness and reviews schema markup.
7. Generates monitoring prompts fully instanced for the business.
8. Runs LLM visibility prompts only when at least one LLM provider key is configured.
9. Delivers an output folder with: plain-English summary, run plan, technical GEO audit, fix guide, llms.txt, schema code, prompt library, visibility results when prompts were executed, and prioritized backlog.

**Output folder:**

| File | Contents |
|---|---|
| `00-START-HERE.md` | Plain-English summary and next actions |
| `01-RUN-PLAN.md` | What will run, what is blocked, and which APIs are needed |
| `02-TECHNICAL-GEO-AUDIT.md` | Technical site health check and GEO readiness score |
| `03-FIX-GUIDE.md` | Step-by-step fixes in priority order |
| `04-LLMS-TXT.md` | Ready-to-upload llms.txt file |
| `05-SCHEMA.md` | Schema markup code ready to implement |
| `06-LLM-PROMPTS-TO-RUN.md` | 40 monitoring prompts to run for this business |
| `07-LLM-VISIBILITY-RESULTS.md` | Measured LLM answer results by prompt group when provider prompts were executed, or explicit `not run` status |
| `08-BACKLOG.md` | Prioritized task list |

Important: generated prompts are not measured visibility. Prompt ideas go in `06-LLM-PROMPTS-TO-RUN.md`; measured answers from configured provider APIs or documented manual runs go in `07-LLM-VISIBILITY-RESULTS.md`.

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

`claude-geo-agent` is a Claude AI agent that audits and improves how ready a business is for AI-generated answers and answer-engine discovery. When someone asks an AI answer engine for recommendations in your category, this agent helps identify whether your public content gives answer systems clear, crawlable, evidence-backed context to understand the brand.

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

**Claude Code is required** for the full audit — including SPA detection, AI crawler access checks, and robots.txt sanity checks. These are the most critical GEO signals and cannot be detected from the browser.

1. Install Claude Code: [claude.ai/code](https://claude.ai/code)
2. Clone this repo and run `./install.sh`
3. Open Claude Code in your terminal
4. Type: `@geo-agent`

The agent will ask for the URL, fetch the site automatically, extract the business context, and confirm with you before starting.

> **Note:** A partial version can run in Claude.ai Projects (browser), but technical pre-flight checks — SPA detection, AI crawler access, robots.txt verification — require Claude Code. Without these checks, the most critical GEO issues may go undetected.

---

## What the Agent Does — Full Capability List

### Pre-Flight Checks (always runs first)
- **SPA / JS-heavy content detection** — identifies whether important content depends heavily on client-side rendering and may be difficult for crawlers or answer engines to access.
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
- Supports JS-heavy sites with supplemental context, while still recommending crawlable HTML, schema, sitemap discovery, and strong public content

### Schema Markup
- Detects existing JSON-LD
- Generates missing schemas: Organization, Service, Article, FAQPage, BreadcrumbList, Person
- Output is ready-to-implement code

### Brand Mentions Audit
- Wikipedia check when applicable; it can be a strong entity signal for eligible/public-interest brands, but many legitimate businesses will not qualify for a Wikipedia page
- Reddit presence
- YouTube presence
- LinkedIn company page
- Industry directories (G2, Capterra, Trustpilot, niche sites)

### LLM Visibility Prompt Library
- Generates 40 monitoring prompts fully instanced for the business
- 8 modules: Discovery, Measurement, Extraction, Interpretation, Audit, Action, Learning, Validation
- Ready to run through configured LLM provider APIs or documented manual UI runs to monitor prompt-based visibility over time
- See [PROMPTS-INDEX.md](PROMPTS-INDEX.md) for the full breakdown

### Output Folder
Generates `[domain]-geo-audit/` with:

| File | Contents |
|---|---|
| `00-START-HERE.md` | Plain-English summary and next actions |
| `01-RUN-PLAN.md` | What will run, what is blocked, and which APIs are needed |
| `02-TECHNICAL-GEO-AUDIT.md` | Technical site health check and GEO readiness score |
| `03-FIX-GUIDE.md` | Step-by-step fixes in priority order |
| `04-LLMS-TXT.md` | Ready-to-upload llms.txt |
| `05-SCHEMA.md` | JSON-LD schema code ready to implement |
| `06-LLM-PROMPTS-TO-RUN.md` | 40 monitoring prompts to run for this business |
| `07-LLM-VISIBILITY-RESULTS.md` | Measured LLM answer results by prompt group when provider prompts were executed, or explicit `not run` status |
| `08-BACKLOG.md` | Prioritized task list |

---

## API Setup

Claude Code is the required runtime for full audits and automated monitoring.

Use `.env.example` as a blank setup template. Fill in only the keys you want to use:

```bash
SERPER_API_KEY=
GEMINI_API_KEY=
GOOGLE_API_KEY=
GROQ_API_KEY=
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
PERPLEXITY_API_KEY=
```

| API | Required | What it enables | Cost | Link |
|---|---|---|---|---|
| **Serper** | Recommended | Search evidence and competitor research. Does not run LLM prompts. | 2,500 free searches/month — no credit card required | [serper.dev](https://serper.dev) |
| **Gemini API** | Recommended for monitoring | Run LLM visibility prompts in Gemini | Free with limits | [aistudio.google.com](https://aistudio.google.com) |
| **Groq API** | Recommended for monitoring | Run LLM visibility prompts with fast, low-cost/open models | Free with generous limits | [console.groq.com](https://console.groq.com) |
| **OpenAI API** | Optional | Run LLM visibility prompts through OpenAI API models | 💰 Paid — see note below | [platform.openai.com](https://platform.openai.com) |
| **Anthropic API** | Optional | Run LLM visibility prompts through Claude / Anthropic API models | 💰 Paid — see note below | [console.anthropic.com](https://console.anthropic.com) |
| **Perplexity API** | Optional | Run answer-engine style visibility prompts | Paid | [docs.perplexity.ai](https://docs.perplexity.ai) |
| **PageSpeed API** | Not needed | Core Web Vitals (automatic) | ✅ Free, no key needed | [developers.google.com/speed](https://developers.google.com/speed) |


> **Note on OpenAI and Anthropic cost:** For LLM visibility monitoring, the actual cost is usually negligible — under $0.01/month for the starter run using GPT-4o mini (OpenAI) or under $0.02/month using Claude Haiku (Anthropic). These APIs are only needed if you specifically want to track how your brand appears in OpenAI API/model or Claude / Anthropic API responses. OpenAI API results are not ChatGPT UI results unless ChatGPT UI was separately measured and labeled. For most teams, Gemini and Groq (both free) cover the same measurement workflow.

**Without Serper:** The agent still runs technical GEO audits using `curl` and `WebFetch`. You only lose search-backed competitor research.

**Without an LLM provider key:** The agent must not claim that LLM prompts were run. It should ask for at least one LLM provider key in `01-RUN-PLAN.md`, generate `06-LLM-PROMPTS-TO-RUN.md`, and create `07-LLM-VISIBILITY-RESULTS.md` with status `Not run — no LLM provider configured`.

---

## Feature Overview

| Feature | Claude Code |
|---|---|
| Business onboarding | ✅ |
| Pre-flight checks | ✅ Full |
| GEO audit report | ✅ |
| llms.txt creation | ✅ |
| Schema markup generation | ✅ |
| LLM visibility prompts | ✅ |
| LLM visibility results with provider keys | ✅ |
| Fix guide | ✅ |
| SPA detection | ✅ |
| robots.txt curl checks | ✅ |
| Disallowed routes check | ✅ |
| Direct file editing | ✅ |
| Serper integration | ✅ |
| API key integrations | ✅ |

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
| `brand-mentions` | External brand authority signals across search and commonly surfaced third-party platforms |
| `llm-prompts` | Generate LLM visibility monitoring prompt library |
| `quick-check` | Fast pre-flight status only |

## Prompt Run Modes

The prompt library is grouped into phases. A complete audit can use all 40 prompts, but narrower objectives should run only the relevant groups.

| Mode | Prompt groups |
|---|---|
| `quick-check` | Pre-flight checks only |
| `monitor` | Measurement `10-17` + Extraction `20-25` + Validation `90` |
| `full-audit` | Discovery `01-05` + Measurement `10-17` + Extraction `20-25` + Validation `90` + Interpretation `30-34` + Audit `40-48` + Action `50-53` + Learning `60-61` |
| `refresh` | Interpretation `30-34` + selected Audit `40-48` + Action `50-53` + Learning `60-61` |
