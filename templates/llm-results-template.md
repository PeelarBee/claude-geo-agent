# LLM Visibility Results: [Brand]

Status: Live LLM results collected / Not run — no LLM provider configured / Manual run required — prompt library generated only

Choose exactly one status. Do not combine statuses. Do not use `Live LLM results collected` unless at least one LLM provider or documented manual UI run was actually executed and logged.

## Result Type

* Result type: Measured LLM results / Not run / Manual run required / Search Evidence only
* Run source: API / Manual UI / Mixed / Not run
* Cold-context baseline: Yes / No / Not applicable
* Prior audit context used: Yes / No
* Raw responses available: Yes / No / Not applicable
* Extraction completed: Yes / No / Not run

## Objective

[monitor / full-audit / refresh]

## Date/time of run

[YYYY-MM-DD HH:MM timezone]

## Domain

[domain]

## Provider Coverage

| Provider/tool | Status | Interface | Evidence Status | Evidence Source Type | Notes |
|---|---|---|---|---|---|
| Serper | Configured / Missing / Used | Search API | Search Evidence / Not available | Search API | Search only; not an LLM result provider |
| Gemini | Run / Not configured / Not run | API / Manual UI / Not run | Measured / Not run / Not available | LLM API / Manual check / Not available | [notes] |
| OpenAI | Run / Not configured / Not run | API / Manual UI / Not run | Measured / Not run / Not available | LLM API / Manual check / Not available | Use OpenAI API/model wording unless ChatGPT UI was actually measured |
| Claude / Anthropic | Run / Not configured / Not run | API / Manual UI / Not run | Measured / Not run / Not available | LLM API / Manual check / Not available | [notes] |
| Perplexity | Run / Not configured / Not run | API / Manual UI / Not run | Measured / Not run / Not available | LLM API / Manual check / Not available | [notes] |
| Groq | Run / Not configured / Not run | API / Manual UI / Not run | Measured / Not run / Not available | LLM API / Manual check / Not available | [notes] |
| Bing Copilot | Manual / Not run | Manual UI / Not run | Measured / Not run | Manual check / Not available | Manual result logging only unless supported measurement path exists |

## Evidence Status Values

Allowed values:
Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown

Rules:

* Executed LLM provider responses are `Measured`.
* Serper/search results are `Search Evidence`.
* Generated prompts that were not executed are `Not run`.
* Missing provider data is `Not available` or `Not configured` depending on the table.
* Interpretation based on measured logs may be `Inferred`; it must not be presented as raw measurement.

## Measurement Boundary

Search results, competitor research, external authority checks, prompt libraries, generated schema, and generated llms.txt files are not LLM answer visibility results.

Measured LLM visibility requires:

* configured LLM provider or documented manual UI run
* fresh/cold-context prompt execution, unless otherwise labeled
* provider logged
* interface logged: API / Manual UI
* model logged if known
* prompt group logged
* prompt text logged
* run date/time logged
* raw response or response summary logged
* citations/sources logged when available
* extraction result logged

## APIs/tools not configured

[List missing providers.]

## What was run

| Prompt group | Provider | Interface | Model | Prompts run | Run date/time | Evidence Status | Evidence Source | Evidence Source Type | Notes |
|---|---|---|---|---:|---|---|---|---|---|
| [group] | [provider] | API / Manual UI | [model if known] | [count] | [date/time] | Measured | [provider/API/manual log] | LLM API / Manual check | [notes] |

## What was not run

| Prompt group/provider | Reason | Blocked by | Required to run later | Status |
|---|---|---|---|---|
| [group/provider] | [reason] | [missing API/tool/manual run] | [requirement] | Not run / Not configured / Manual only |

## Assumptions

[Assumptions made during interpretation.]

## Limitations

- Search API results are not LLM visibility results.
- Prompt libraries are not measurement results.
- LLM answers vary by provider, model, date, prompt, location, personalization, retrieval mode, and index freshness.
- If Serper search evidence was collected, this is not LLM visibility measurement.
- API and UI results from the same provider may differ.
- Results may vary by date, model version, retrieval mode, geography, personalization, and prompt wording.
- A provider result is a point-in-time observation, not a permanent visibility state.
- Missing citations in a provider response do not prove the brand lacks authority.
- Presence in search results does not prove use in LLM answers.

## Executive Summary

[Measured summary only if prompts were run. Otherwise state not run.]

## Key Findings

[Measured findings or `Not run`.]

## Evidence Table

| Finding | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Confidence | Priority | Impact | Effort | Next Action | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|---|
| [finding] | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available | [date/time] | High / Medium / Low | Critical / High / Medium / Low | High / Medium / Low | High / Medium / Low | [action] | [criteria] |

## Group Results

If no LLM provider is configured:

Top-level status must be exactly:
`Status: Not run — no LLM provider configured`

* Prompts run must be `0`.
* Verdict must be `Not run`.
* Do not include answer summaries.
* Do not include brand mentioned or competitor mentioned values.
* Do not infer visibility from generated prompts or search results.

| Group | Prompts run | Verdict |
|---|---:|---|
| Branded | 0 | Not run |
| Category | 0 | Not run |
| Problem-aware | 0 | Not run |
| Comparison | 0 | Not run |
| Transactional | 0 | Not run |
| Local / geo | 0 | Not run |
| Educational | 0 | Not run |
| Alternative language | 0 | Not run |

If LLM providers are configured and executed:

| Provider | Interface | Model | Group | Prompt ID | Prompt text | Brand mentioned | Domain cited | Competitors mentioned | Citations/sources | Sentiment/framing | Verdict | Run date/time | Evidence Status | Evidence Source | Evidence Source Type | Response summary | Extraction result |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| [provider] | API / Manual UI | [model if known] | [group] | [ID] | [prompt] | Yes / No / Unclear | Yes / No / Unclear | [names] | [sources or none] | Positive / Neutral / Negative / Mixed / Unclear | Win / Gap / Risk / Inconclusive | [date/time] | Measured | [run log/provider/manual record] | LLM API / Manual check | [summary] | [parsed / failed / not run] |

## Prompt-Level Results

| Group | Prompt ID | Prompt | Provider | Interface | Model | Run date/time | Brand mentioned? | Domain cited? | Competitors mentioned | Sentiment/framing | Citations/sources | Response summary | Extraction result | Evidence Status | Evidence Source | Evidence Source Type | Result |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| [group] | [ID] | [prompt] | [provider] | API / Manual UI / Not run | [model if known] | [date/time] | Yes / No / Unclear / Not run | Yes / No / Unclear / Not run | [names] | Positive / Neutral / Negative / Mixed / Unclear / Not run | [sources] | [summary] | [parsed / failed / not run] | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | LLM API / Manual check / Not available | Win / Gap / Risk / Inconclusive / Not run |

## Raw Answer Samples

Include raw answer samples only when actual provider responses exist.

If no provider was run, say:
`Not applicable — no LLM provider responses were collected.`

If raw responses are not preserved, say:
`Raw responses not preserved. Results are based on logged response summaries and extraction outputs.`

Do not fabricate raw answer samples.

## Interpretation

Interpretation must be separated from measured answer results.

* Measured results:
* Search Evidence, if any:
* Inferred patterns:
* Confidence:
* Major gaps:
* Interpretation limitations:

Rules:

* Do not infer LLM visibility from Serper/search evidence alone.
* Do not treat generated prompts as results.
* Do not upgrade inferred patterns to measured findings.
* If evidence is insufficient, say so.

## Priority Fixes

| Priority | Fix | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Confidence | Impact | Effort | Recommended Action | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|---|
| Critical / High / Medium / Low | [fix] | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available | [date/time] | High / Medium / Low | High / Medium / Low | High / Medium / Low | [action] | [criteria] |

If no LLM provider was run, priority fixes should focus on provider setup, prompt execution, logging, or readiness gaps from non-LLM evidence. Do not create measured visibility fixes.

## Backlog

Allowed task types: measurement / content / authority / technical / schema / llms.txt / provider-setup / logging

| Priority | Task | Type | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Impact | Effort | Owner | Status | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Critical / High / Medium / Low | [task] | measurement / content / authority / technical / schema / llms.txt / provider-setup / logging | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available | [date/time] | High / Medium / Low | High / Medium / Low | [owner] | Open | [criteria] |

## Required Fallback Language

Use these exact phrases when applicable:

No LLM provider configured:
`Status: Not run — no LLM provider configured`

Serper/search evidence collected but no LLM provider was run:
`Serper search evidence was collected, but this is not LLM visibility measurement.`

Prompts generated but not executed:
`Status: Manual run required — prompt library generated only`

OpenAI API used:
`Results reflect OpenAI API/model responses, not ChatGPT UI, unless ChatGPT UI was separately measured and labeled.`

Bing Copilot not manually tested:
`Bing Copilot: Manual / Not run`

## Prohibited Claims

This file must not:

* Claim ChatGPT, Claude, Gemini, Perplexity, Groq, OpenAI, or Bing Copilot visibility unless that provider/interface was actually run.
* Claim ChatGPT UI results from OpenAI API runs.
* Treat Serper, Google, Bing, or third-party search results as LLM answer visibility.
* Treat generated prompts as measured visibility.
* Invent answer summaries, citations, competitors, sentiment, or verdicts.
* Report measured visibility when no LLM provider was configured and run.
* Claim llms.txt, schema, or technical fixes guarantee future LLM inclusion.
* Convert unexecuted prompt libraries into visibility scores.

## Next Actions

1. [Action]
2. [Action]
3. [Action]
