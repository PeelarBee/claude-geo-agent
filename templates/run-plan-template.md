# GEO Run Plan: [Domain]

This run plan must be created after CONFIG confirmation and before audit execution. It defines what will run, what will not run, what is blocked, and which evidence classes are allowed for this run.

## CONFIG Confirmation

* CONFIG extracted from: [homepage + up to 3 key pages]
* CONFIG presented to user: Yes / No
* CONFIG confirmed by user: Yes / No
* Confirmation timestamp: [YYYY-MM-DD HH:MM timezone]
* Audit/output generation allowed: Yes / No

If CONFIG confirmed by user is `No`, stop. Do not generate audit outputs.

## Selected Objective

* Objective: [full-audit / monitor / refresh / llms-txt / citability / schema / crawlers / brand-mentions / llm-prompts / quick-check / custom]
* Audit mode: [full-audit / technical-only / llms.txt / schema / monitoring / fix-guide / custom]
* Domain: [domain]
* Business CONFIG summary: [short confirmed business category, ICP, services/products, geography]
* Outputs to generate:
  * [output file]
* Outputs intentionally skipped:
  * [output file or phase]
* Reason for skipped outputs:
  * [reason]

## Date/time of run

[YYYY-MM-DD HH:MM timezone]

## API Status

| API | Status | Used for |
|---|---|---|
| `SERPER_API_KEY` | Configured / Missing | Search Evidence and competitor research only |
| `GEMINI_API_KEY` / `GOOGLE_API_KEY` | Configured / Missing | Gemini prompt execution |
| `GROQ_API_KEY` | Configured / Missing | Groq model prompt execution |
| `OPENAI_API_KEY` | Configured / Missing | OpenAI prompt execution |
| `ANTHROPIC_API_KEY` | Configured / Missing | Claude prompt execution |
| `PERPLEXITY_API_KEY` | Configured / Missing | Perplexity prompt execution |
| Bing Copilot | Manual / Not run | Manual result logging only unless a supported measurement path exists |

## Measurement Status

Do not print API secret values. Report provider status only as Configured / Missing / Manual / Not run.

* Search Evidence: Available / Not available
* Live LLM visibility measurement: Available / Not available
* LLM providers configured: [list configured LLM providers]
* LLM providers to be run: [list providers actually selected for this run]
* LLM providers not configured: [list missing LLM providers]
* Manual-only providers: [Bing Copilot or others]
* Measurement-dependent phases: Run / Blocked / Manual only
* Blocked phases:
  * [phase]: [reason]
* Prompt library status: Generated / Not generated / Not applicable
* LLM visibility result status: Live LLM results collected / Not run — no LLM provider configured / Manual run required — prompt library generated only

If no LLM provider is configured, `07-LLM-VISIBILITY-RESULTS.md` must say exactly: `Status: Not run — no LLM provider configured`

## Provider Boundary

* Serper: Search Evidence only.
* Gemini: Measured only if prompts were executed through configured Gemini provider.
* Groq: Measured only if prompts were executed through configured Groq provider.
* OpenAI: Measured only as OpenAI API/model results unless ChatGPT UI was manually measured and labeled.
* Anthropic / Claude: Measured only if prompts were executed through configured Anthropic provider.
* Perplexity: Measured only if prompts were executed through configured Perplexity provider.
* Bing Copilot: Manual / Not run unless a supported measurement path exists.

## Measurement Boundary

Search results, competitor research, external authority checks, prompt libraries, generated schema, and generated llms.txt files are not LLM answer visibility results.

Measured LLM visibility requires:

* configured LLM provider or documented manual run
* fresh/cold-context prompt execution
* provider logged
* model logged if known
* prompt text logged
* run date/time logged
* raw response or response summary logged
* extraction result logged

## Scenario Status

Choose exactly one Scenario Status. Do not combine statuses.

Use exactly one of the following:

* If no LLM provider is configured and Serper is missing:
  Partial full-audit: technical GEO completed, live LLM visibility not measured.

* If Serper is configured but no LLM provider is configured:
  Partial full-audit: technical GEO + search evidence completed, live LLM visibility not measured.

* If at least one LLM provider was actually run:
  Status: Live LLM results collected

* If prompts were generated but no provider was run:
  Status: Manual run required — prompt library generated only

## APIs/tools available

| API/tool | Status | Used for |
|---|---|---|
| WebFetch/curl/local checks | Available / Not available | Technical audit evidence |
| Crawl/render checks | Available / Not available | Crawlability, rendered HTML, metadata, robots.txt, sitemap |
| Search API checks | Available / Not available | Search Evidence only; external authority and competitor discovery |
| LLM provider execution | Available / Not available | Measured only for configured providers actually run |
| Manual run logging | Available / Not available | Manual UI results when documented with provider interface and run date/time |
| Generated artifacts | Available / Not available | Prompt library, schema draft, llms.txt draft; not measurement results |

## APIs/tools not configured

[List missing providers and what each blocks.]

## What was run

| Phase | Status | Evidence Status | Evidence Source | Evidence Source Type | Notes |
|---|---|---|---|---|---|
| [phase/tool/check] | Run / Not run / Blocked / Manual only | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available | [notes] |

## What was not run

| Phase | Reason | Blocked by | Required to run later |
|---|---|---|---|
| [phase/tool/check] | [reason] | [missing API/tool/access/config] | [next requirement] |

## Assumptions

- [Assumption]

## Limitations

- Search APIs are not LLM answer engines.
- Prompt libraries are not measurement results.
- LLM visibility is measured only when prompts are executed through configured LLM providers.
- Serper/Search Evidence can support external authority and competitor discovery, but cannot prove LLM visibility.
- OpenAI API results are not ChatGPT UI results unless ChatGPT UI was actually measured.
- Bing Copilot must be marked Manual / Not run unless a supported measurement path or documented manual run exists.
- Generated prompts are not visibility results until executed and logged.
- Scores from this run are diagnostic readiness scores, not predictions of AI answer inclusion.

## Executive Summary

[Short run-plan summary.]

## Key Findings

[Known setup findings before execution.]

## Evidence Table

| Finding | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Confidence | Priority | Impact | Effort | Next Action | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|---|
| [finding] | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available | [date/time or Not available] | High / Medium / Low | Critical / High / Medium / Low | High / Medium / Low | High / Medium / Low | [action] | [criteria] |

## Priority Fixes

| Priority | Fix | Evidence Status | Evidence Source | Evidence Source Type | Impact | Effort | Recommended Action | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|
| Critical / High / Medium / Low | [fix] | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available | High / Medium / Low | High / Medium / Low | [action] | [criteria] |

## Backlog

| Priority | Task | Type | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Impact | Effort | Owner | Status | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Critical / High / Medium / Low | [task] | [type] | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available | [date/time or Not available] | High / Medium / Low | High / Medium / Low | [owner] | Open | [criteria] |

## Next Actions

1. [Action]
2. [Action]
3. [Action]
