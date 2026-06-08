---
name: geo-monitor
description: Runs or logs real LLM visibility measurement only when configured LLM provider APIs or documented manual UI runs exist. Separates OpenAI API from ChatGPT UI, records provider/model/prompt/response metadata, extracts structured results, validates output shape, and writes 07-LLM-VISIBILITY-RESULTS.md.
allowed-tools:
  - Bash
  - Read
  - Write
---

# GEO Monitor Skill

## Purpose

Measure prompt-based LLM visibility only when prompts are actually executed through configured LLM providers or documented manual UI runs.

This is the only GEO skill that may produce `Measured` LLM visibility rows.

## Inputs

- Confirmed CONFIG
- Provider status
- Selected prompt IDs
- Prompt file
- Output folder
- Existing run trace

## Provider Boundary

- `OPENAI_API_KEY` results are `OpenAI API`, not ChatGPT UI.
- `ANTHROPIC_API_KEY` results are `Anthropic API` or `Claude / Anthropic API`, not necessarily Claude UI.
- `GEMINI_API_KEY` or `GOOGLE_API_KEY` results are `Gemini API`, not necessarily Gemini UI.
- `GROQ_API_KEY` results are `Groq` with model name.
- `PERPLEXITY_API_KEY` results are `Perplexity API`.
- Bing Copilot is `Manual / Not run` unless a supported measurement path or documented manual run exists.
- Serper is search only and must not appear as an LLM provider result.

## Required Gate

Before running measurement:

1. Confirm at least one LLM provider is configured, or manual UI logging mode is explicitly selected.
2. Confirm prompt file exists.
3. Confirm measurement prompt IDs are selected.
4. Confirm run date/time will be logged.
5. Confirm provider/interface/model will be logged.

If no LLM provider is configured and no manual mode is selected, do not run prompts. Write:

`Status: Not run — no LLM provider configured`

## Measurement Prompt Flow

1. Run measurement prompts `10-17` for each configured provider selected by the orchestrator.
2. Use fresh/cold-context execution where supported.
3. Log raw response or response summary.
4. Run extraction prompts `20-25` only on real responses.
5. Run validation prompt `90` or structured validation only on actual extracted output.
6. Write measured result rows only for completed provider runs.
7. Mark failed provider runs as `Not run` or `Unknown` with reason.

## Required Result Fields

Every measured row must include:

- Provider
- Interface: API / Manual UI / Other
- Model if known
- Prompt ID
- Prompt group
- Prompt text
- Run date/time
- Fresh/cold context status
- Raw response or response summary
- Brand mentioned: Yes / No / Unknown
- Domain cited: Yes / No / Unknown
- Competitors mentioned
- Citations/sources
- Sentiment/framing
- Extraction result
- Evidence Status: Measured
- Evidence Source: provider/API/manual run
- Evidence Source Type: LLM API or Manual UI
- Confidence
- Limitations / notes

## Outputs

Update:

- `07-LLM-VISIBILITY-RESULTS.md`
- `11-RUN-TRACE.md`
- `09-FINAL-REPORT.md` measurement summary when final synthesis runs
- `08-BACKLOG.md` only with actions tied to measured gaps or clearly labeled inferred recommendations

## Consistency Rules

- If `01-RUN-PLAN.md` says no LLM provider was configured, `07-LLM-VISIBILITY-RESULTS.md` must not contain measured rows.
- If `07` contains measured rows, `11-RUN-TRACE.md` must show provider, prompt ID, model if known, and run date/time.
- If OpenAI API was used, `07` must not say ChatGPT UI.
- If Serper was used, `07` must not list it as an LLM provider result.

## Required Worker Summary

```md
## geo-monitor Summary

- LLM providers configured:
- Providers run:
- Prompt IDs run:
- Results written:
- Providers blocked:
- OpenAI/ChatGPT boundary checked:
- Files updated:
- Next actions:
```
