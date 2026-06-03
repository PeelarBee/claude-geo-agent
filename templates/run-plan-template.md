# GEO Run Plan: [Domain]

## Objective

[full-audit / monitor / refresh / llms-txt / citability / schema / crawlers / brand-mentions / llm-prompts / quick-check]

## Date/time of run

[YYYY-MM-DD HH:MM timezone]

## Domain

[domain]

## API Status

| API | Status | Used for |
|---|---|---|
| `SERPER_API_KEY` | Configured / Missing | Search evidence and competitor research only |
| `GEMINI_API_KEY` / `GOOGLE_API_KEY` | Configured / Missing | Gemini prompt execution |
| `GROQ_API_KEY` | Configured / Missing | Groq model prompt execution |
| `OPENAI_API_KEY` | Configured / Missing | OpenAI prompt execution |
| `ANTHROPIC_API_KEY` | Configured / Missing | Claude prompt execution |
| `PERPLEXITY_API_KEY` | Configured / Missing | Perplexity prompt execution |

## Measurement Status

- Search evidence: Available / Not available
- Live LLM visibility measurement: Available / Not available
- Providers to be measured: [list configured LLM providers]
- Providers not configured: [list missing LLM providers]
- Blocked phases: [list]

## Scenario Status

[Say the matching status exactly:]
- Partial full-audit: technical GEO completed, live LLM visibility not measured.
- Partial full-audit: technical GEO + search evidence completed, live LLM visibility not measured.
- Status: Live LLM results collected
- Status: Manual run required — prompt library generated only

## APIs/tools available

| API/tool | Status | Used for |
|---|---|---|
| Serper | Configured / Missing | Search evidence only; not LLM visibility |
| Gemini | Configured / Missing | Gemini prompt execution |
| Groq | Configured / Missing | Groq model prompt execution |
| OpenAI | Configured / Missing | OpenAI prompt execution |
| Anthropic | Configured / Missing | Claude prompt execution |
| Perplexity | Configured / Missing | Perplexity prompt execution |
| WebFetch/curl/local checks | Available / Not available | Technical audit evidence |

## APIs/tools not configured

[List missing providers and what each blocks.]

## What was run

- [Phase/tool/check]

## What was not run

- [Phase/tool/check and reason]

## Assumptions

- [Assumption]

## Limitations

- Search APIs are not LLM answer engines.
- Prompt libraries are not measurement results.
- LLM visibility is measured only when prompts are executed through configured LLM providers.

## Executive Summary

[Short run-plan summary.]

## Key Findings

[Known setup findings before execution.]

## Evidence Table

| Finding | Evidence Status | Evidence Source | Confidence | Priority | Impact | Effort | Next Action |
|---|---|---|---|---|---|---|---|
| [finding] | Observed / Measured / Inferred / Not run / Not available / Unknown | [source] | High / Medium / Low | Critical / High / Medium / Low | High / Medium / Low | High / Medium / Low | [action] |

## Priority Fixes

[Setup or access fixes needed before/after the run.]

## Backlog

| Priority | Task | Type | Evidence Status | Evidence Source | Impact | Effort | Owner | Status |
|---|---|---|---|---|---|---|---|---|
| [priority] | [task] | [type] | [status] | [source] | [impact] | [effort] | [owner] | Open |

## Next Actions

1. [Action]
2. [Action]
3. [Action]
