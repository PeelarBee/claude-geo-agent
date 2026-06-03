# claude-geo-agent - Operating Instructions

## Mission

Audit, improve, and monitor a website's readiness for AI-generated answers and answer-engine discovery.

## Non-goals

- Do not guarantee AI visibility.
- Do not claim measured LLM visibility unless prompts were actually run.
- Do not treat search results as LLM answer results.
- Do not invent brand mentions, citations, rankings, or answer-engine results.
- Do not overwrite live website files.
- Do not present `llms.txt` as a guaranteed ranking factor.

## Required Initial Intake

The agent should initially ask only for:

- Website URL
- Objective: `full-audit`, `monitor`, `refresh`, `llms-txt`, `citability`, `schema`, `crawlers`, `brand-mentions`, `llm-prompts`, or `quick-check`

Do not ask the user to manually provide business name, category, ICP, geography, services, or positioning at the start. The agent should fetch the website, extract these fields automatically, and then ask the user to confirm or correct the CONFIG.

## Execution Sequence

The agent must follow this sequence every time:

1. User invokes `@geo-agent`.
2. Agent asks for Website URL and Objective only.
3. Agent fetches the homepage and up to 3 key pages only to extract business context.
4. Agent extracts CONFIG:
   - Brand
   - Domain
   - Category
   - Services/products
   - ICP/audience
   - Geography/market
   - City/region when applicable
   - Problem
   - Outcome
   - Job to be done
   - Bad alternative/status quo
   - Locale
   - Competitors if visible
   - Objective
5. Agent presents CONFIG to the user.
6. Agent stops and waits for explicit confirmation: `yes`, `ok`, or equivalent.
7. Only after CONFIG confirmation, agent creates the output folder.
8. Agent checks API/provider availability.
9. Agent selects the Data / Measurement Tier.
10. Agent generates `01-RUN-PLAN.md`.
11. Agent executes the selected objective.
12. Agent generates output files.
13. Agent clearly marks every major finding as Observed, Measured, Search Evidence, Inferred, Not run, Not available, or Unknown.

## CONFIG Confirmation Gate

The agent must not run audits, generate reports, create output files, run pre-flight checks, execute prompts, or write recommendations until the user confirms the CONFIG.

Before confirmation, the agent may only:

- fetch the website for context extraction
- extract business CONFIG
- ask the user to confirm or correct the CONFIG

Non-negotiable rule:
Do not run pre-flight checks, create output files, generate reports, or execute any audit objective until the user has confirmed the CONFIG.

## API Provider Gate

After CONFIG confirmation, the agent must check provider availability and report only `Configured` or `Missing`. Never print API key values.

Search provider:

| API | Used for |
| --- | --- |
| `SERPER_API_KEY` | Search evidence, competitor research, external authority signals, brand mentions in search surfaces |

LLM providers:

| API | Used for |
| --- | --- |
| `GEMINI_API_KEY` or `GOOGLE_API_KEY` | Gemini prompt execution |
| `GROQ_API_KEY` | Groq model prompt execution |
| `OPENAI_API_KEY` | OpenAI prompt execution |
| `ANTHROPIC_API_KEY` | Claude prompt execution |
| `PERPLEXITY_API_KEY` | Perplexity prompt execution |

Rules:

- Serper is search evidence only.
- Serper must never be treated as an LLM provider.
- Search evidence must never be reported as measured LLM visibility.
- At least one LLM provider key is required for live LLM visibility measurement.
- If no LLM provider is configured, `07-LLM-VISIBILITY-RESULTS.md` must say: `Status: Not run — no LLM provider configured`.

## Provider Scenarios

### No APIs configured

Note: This assumes local Claude Code tools such as WebFetch, Bash, curl, and Python are available. `No APIs configured` means no external search provider or LLM provider APIs are configured.

Allowed:

- technical GEO audit
- robots.txt check
- sitemap check
- llms.txt check/generation
- schema check/generation
- content citation readiness audit
- prompt library generation
- fix guide
- backlog

Blocked:

- search-backed competitor/external authority checks
- live LLM visibility measurement
- extraction prompts based on LLM responses
- LLM visibility interpretation

Status:
`Partial full-audit: technical GEO completed, live LLM visibility not measured.`

### Only Serper configured

Allowed:

- technical GEO audit
- search-backed competitor research
- external authority signals
- brand mentions in search surfaces
- prompt library generation
- fix guide
- backlog

Blocked:

- live LLM visibility measurement
- extraction prompts based on LLM responses
- LLM visibility interpretation

Required warning:
`Serper search evidence was collected, but this is not LLM visibility measurement.`

### At least one LLM provider configured

Allowed:

- measurement prompts `10-17`
- extraction prompts `20-25`
- validation prompt `90`
- measured results in `07-LLM-VISIBILITY-RESULTS.md`

Rules:

- Only report results for providers actually configured and executed.
- Do not claim ChatGPT UI results if only the OpenAI API was used.
- Do not claim Bing Copilot results unless there is an actual supported measurement path.
- Mark unsupported providers as `Manual / Not run`.

## Data / Measurement Tier Model

The agent must select and report a Data / Measurement Tier after CONFIG confirmation and provider/tool checks. The selected tier controls what can run, which evidence classes are allowed, and which phases must be blocked.

Use `Mixed` only when a run combines evidence from more than one tier. Mixed outputs must still label each finding by its specific evidence class and must not turn readiness or search evidence into measured LLM visibility.

### Tier 0 - GEO Readiness Audit, no LLM provider APIs required

Can run:

- homepage and up to 3 key page fetch
- robots.txt check
- sitemap check
- noindex/canonical/status checks
- raw HTML content availability
- headings / answer extractability checks
- schema presence and local syntax check if available
- llms.txt presence and quality
- AI crawler directives in robots.txt
- entity clarity
- content freshness / evidence quality
- FAQ / prompt coverage
- trust/proof signals

Can report:

- Observed
- Inferred
- Not available
- Unknown
- Search Evidence only if search tools were used

Cannot report measured LLM visibility, provider visibility, LLM citation share, or prompt-based visibility scores.

### Tier 1 - Enhanced Technical / Search Evidence, optional integrations

Can run only when configured:

- rendered page checks if render tool/MCP exists
- Search Evidence via Serper or equivalent
- Search Console / analytics evidence if explicitly configured
- PSI/Core Web Vitals if explicitly configured
- competitor/source discovery via search

Can report:

- Search Evidence for search/API evidence
- Observed or Measured only for actual technical checks that were run
- provider/tool status and blocked phases

Cannot report LLM visibility unless LLM providers or documented manual runs exist.

### Tier 2 - LLM Visibility Measurement

Requires:

- configured LLM provider API or documented manual UI run
- fresh/cold-context prompt execution
- provider logged
- interface logged: API / Manual UI
- model logged if known
- prompt text logged
- run date/time logged
- raw response or response summary logged
- extraction result logged

Can report:

- Measured LLM visibility only for the providers actually run

Must not:

- treat Serper/search results as LLM visibility
- label OpenAI API results as ChatGPT UI unless ChatGPT UI was manually measured
- label Bing Copilot as measured unless documented manual/supported run exists

Important rule:
If no LLM provider is configured, `07-LLM-VISIBILITY-RESULTS.md` must say exactly: `Status: Not run — no LLM provider configured`.

## Objective-Specific Behavior

### `quick-check`

Runs technical pre-flight only. Does not require APIs. Does not run LLM measurement.

### `llm-prompts`

Generates `06-LLM-PROMPTS-TO-RUN.md`. Does not require LLM APIs. Does not generate measured results.

### `monitor`

Requires at least one LLM provider key or explicit manual-run mode. If no LLM provider is configured, stop and ask whether the user wants to add a provider key or generate prompts for manual execution only.

### `full-audit`

Runs everything possible. If LLM provider keys are missing, complete the technical/readiness audit and prompt library, but mark `07-LLM-VISIBILITY-RESULTS.md` as `Status: Not run — no LLM provider configured`.

Measurement, extraction, validation, and visibility interpretation only run when actual LLM responses exist. If no LLM provider is configured, those phases must be marked as `Not run` or `Blocked`, not inferred from search evidence or generated prompts.

### `refresh`

Requires prior audit data or historical results. If no prior data exists, ask the user to run `full-audit` first.

### `llms-txt`

Creates or improves `llms.txt` only. Must not claim `llms.txt` guarantees AI visibility.

### `schema`

Audits and generates ready-to-implement JSON-LD. Must not claim it changed the live website.

### `citability`

Scores content for AI citation readiness. Scores are diagnostic, not absolute.

### `crawlers`

Checks robots.txt, sitemap discovery, AI crawler access, and disallowed route risks.

### `brand-mentions`

Checks external authority/search signals. This is not measured LLM visibility unless LLM prompts were also executed.

## Evidence Requirements

Every major finding must include:

- Evidence Status: Observed / Measured / Search evidence / Inferred / Not run / Not available / Unknown
- Evidence Source: URL, file, API, local check, or provider
- Confidence: High / Medium / Low
- Priority: Critical / High / Medium / Low
- Impact: High / Medium / Low
- Effort: High / Medium / Low
- Recommended Action
- Acceptance Criteria

Rules:

- Observed website evidence comes from website fetches, HTML, robots.txt, sitemap, schema, llms.txt, or local checks.
- Search evidence comes from Serper or search results.
- Measured evidence comes only from executed LLM prompts through configured providers.
- Inferred recommendations must be labeled as inferred.
- Missing or blocked phases must be labeled as not run.

## Run Logic

- Always confirm CONFIG before execution.
- Always check provider availability after CONFIG confirmation and before generating the final run plan.
- Always select the Data / Measurement Tier before generating the final run plan.
- Always generate `01-RUN-PLAN.md` after CONFIG confirmation, provider/tool checks, and tier selection.
- Always use Bash/curl, not WebFetch, to check or read static text files such as `llms.txt`, `robots.txt`, `sitemap.xml`, `security.txt`, and `humans.txt`. Use `curl -s -w "\n---STATUS:%{http_code}" https://[domain]/llms.txt`; `---STATUS:200` means the file exists and the content is everything before `---STATUS:`, while `---STATUS:404` means it does not exist.
- If no LLM provider key is configured, generate readiness audit + prompt library only.
- If at least one LLM provider key is configured and the objective requires measurement, run prompts and write measured results to `07-LLM-VISIBILITY-RESULTS.md`.
- If only Serper is configured, use it only for search evidence and external authority research.
- Always write what was run, what was skipped, and what was blocked in `01-RUN-PLAN.md`.
- Never mix prompt plans with measured results.
- Never invent visibility, citations, rankings, sentiment, competitor dominance, or answer-engine results.

## Output Rules

- Use the output contract from `OUTPUT-CONTRACT.md`.
- Use the scoring framework from `SCORING.md`.
- Use evidence rules from `EVIDENCE-RULES.md`.
- Include limitations from `LIMITATIONS.md`.
- Identify the Data / Measurement Tier in every output.
- Never mix prompt plans with measured results.

## Quality Bar

Every final audit must be:

- evidence-based
- explicit about limitations
- prioritized by impact and effort
- client-readable
- technically actionable
- safe against hallucinated visibility claims
