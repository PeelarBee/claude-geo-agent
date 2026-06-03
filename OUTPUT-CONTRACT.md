# Output Contract

All audit outputs must be client-readable, evidence-based, and explicit about what was and was not measured.

## Required Sections For Every Audit Output

Every audit output must include the required metadata block below:

- Objective
- Date/time of run
- Domain
- APIs/tools available
- APIs/tools not configured
- What was run
- What was not run
- Assumptions
- Limitations

Full report-style outputs must include the full report sections below:

- Executive Summary
- Key Findings
- Evidence Table
- Priority Fixes
- Backlog
- Next Actions

Artifact-style outputs, such as llms.txt drafts, schema drafts, or prompt libraries, may include a full report section and mark it `Not applicable` with a short reason when the section does not apply. Do not omit required metadata. If a required report section is not applicable to the objective or artifact type, include the section and mark it `Not applicable` with a short reason.

## Finding Format

Every finding must use this structure:

```md
## Finding: [clear issue name]

- Evidence Status: Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown
- Evidence Source Type: Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available
- Evidence Source: [URL, file, API, local check, or "not available"]
- Evidence Date / Run Date:
- Confidence: High / Medium / Low
- Priority: Critical / High / Medium / Low
- Impact: High / Medium / Low
- Effort: High / Medium / Low
- Why it matters:
- Recommended action:
- Acceptance Criteria:
```

## Evidence Table Format

```md
| Finding | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Confidence | Priority | Impact | Effort | Next Action | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|---|
| [finding] | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available | [date/time or Not available] | High / Medium / Low | Critical / High / Medium / Low | High / Medium / Low | High / Medium / Low | [action] | [criteria] |
```

## `01-RUN-PLAN.md`

`01-RUN-PLAN.md` must be generated after CONFIG confirmation and before audit outputs are generated.

The run plan must report provider availability without printing secret values. Use only `Configured` or `Missing`.

```md
## Selected Objective

- Objective:
- Audit mode: full-audit / technical-only / llms.txt / schema / monitoring / fix-guide / custom
- Outputs to generate:
- Outputs intentionally skipped:
- Reason for skipped outputs:

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

[Choose exactly one matching status. Do not combine statuses.]
- Partial full-audit: technical GEO completed, live LLM visibility not measured.
- Partial full-audit: technical GEO + search evidence completed, live LLM visibility not measured.
- Status: Live LLM results collected
- Status: Manual run required — prompt library generated only
```

Scenario status rules:

- If no LLM provider is configured and Serper is missing, use: `Partial full-audit: technical GEO completed, live LLM visibility not measured.`
- If Serper is configured but no LLM provider is configured, use: `Partial full-audit: technical GEO + search evidence completed, live LLM visibility not measured.`
- If at least one LLM provider was run, use: `Status: Live LLM results collected`
- If prompts were generated for a prompt-only or manual-run mode but no provider was run, use: `Status: Manual run required — prompt library generated only`

For `full-audit`, use the first two no-provider statuses when LLM providers are missing. Use the manual-run status only when the selected objective or user-confirmed mode is prompt-only/manual execution.

Serper must be labeled as search evidence only. It must never be listed as an LLM provider.

## `06-LLM-PROMPTS-TO-RUN.md`

This file is a prompt library / test plan, not a measurement result.

It must include:

- Objective
- Date/time of run
- Domain
- Prompt groups
- Intended provider or provider type
- Expected signal
- Interpretation notes
- A clear statement that prompts must be executed before any measured visibility claim is made

It must not:

- Claim that the brand appeared in an LLM answer
- Report visibility scores based only on generated prompts
- Mix prompt text with fake answer results

## `05-SCHEMA.md`

Schema outputs may include proposed JSON-LD, but must not claim schema is valid unless validation was actually run through a parser, validator, or local JSON-LD syntax check. If validation was not run, mark validation status as `Not run`.

Schema outputs must separate:

- Existing observed schema
- Proposed JSON-LD
- Validation status: Validated / Reviewed only / Not run
- Evidence Status: Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown
- Evidence Source Type: Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available
- Evidence Source
- Evidence Date / Run Date

## `07-LLM-VISIBILITY-RESULTS.md`

The file must always include:

```md
# LLM Visibility Results: [Brand]

Status: Live LLM results collected / Not run — no LLM provider configured / Manual run required — prompt library generated only

## Provider Coverage

| Provider | Status | Notes |
|---|---|---|
| Serper | Configured / Missing | Search only; not an LLM result provider |
| Gemini | Run / Not configured / Not run | |
| OpenAI | Run / Not configured / Not run | |
| Claude / Anthropic | Run / Not configured / Not run | |
| Perplexity | Run / Not configured / Not run | |
| Groq | Run / Not configured / Not run | |
| Bing Copilot | Manual / Not run | No automatic provider configured unless explicitly supported |

## Measurement Boundary

Search results, competitor research, and external authority checks are not the same as LLM answer visibility. This file only reports measured LLM visibility when prompts were executed through configured LLM providers.
```

If no LLM provider is configured, the file must say exactly:

```md
Status: Not run — no LLM provider configured
```

If no LLM provider is configured, all prompt groups must be marked:

```md
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
```

It must:

- List which providers were configured and which were not
- Separate measured answer results from interpretation
- Include provider, model if known, prompt group, prompt text, brand mentioned, competitors mentioned, citations/sources, sentiment/framing, verdict, run date/time, response summary, extraction result, evidence status, evidence source, and evidence source type
- Mark every unrun group as `Not run`
- Preserve raw answer samples only when actual provider responses exist
- Include the warning `Serper search evidence was collected, but this is not LLM visibility measurement.` when Serper was used and no LLM provider was run

Measured result rows must use this structure:

```md
| Provider | Model | Prompt Group | Prompt Text | Brand Mentioned | Competitors Mentioned | Citations/Sources | Sentiment/Framing | Verdict | Run Date/Time | Response Summary | Extraction Result | Evidence Status | Evidence Source | Evidence Source Type |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| [provider] | [model if known] | [group] | [prompt] | Yes / No | [names] | [sources or none] | Positive / Neutral / Negative / Mixed | Win / Gap / Risk / Not run | [timestamp] | [summary] | [structured extraction] | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [provider/API run] | LLM API |
```

It must not:

- Contain fake answer results
- Treat Serper, Google results, or third-party search results as LLM answer visibility
- Treat generated prompts as measured visibility
- Claim ChatGPT/Claude/Gemini/Perplexity/Groq/Bing Copilot visibility unless the corresponding provider/API/run mode was executed
- Claim ChatGPT UI results if only the OpenAI API was used; say `OpenAI API` or `OpenAI model`

## Priority Fixes

Every priority fix must include:

- Evidence Status: Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown
- Evidence Source Type: Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available
- Evidence Source
- Evidence Date / Run Date
- Confidence
- Priority
- Impact
- Effort
- Recommended action
- Next action
- Acceptance Criteria

## Backlog

Backlog items must be prioritized by impact and effort. Use this structure:

```md
| Priority | Task | Type | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Impact | Effort | Acceptance Criteria | Owner | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Critical / High / Medium / Low | [task] | technical/content/schema/messaging/measurement/llms.txt | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / LLM API / Manual check / Local file / Generated artifact / Not available | [date/time or Not available] | High / Medium / Low | High / Medium / Low | [criteria] | [owner] | Open |
```
