---
name: geo-llm-prompts
description: Instantiates the GEO prompt library for a confirmed business CONFIG and produces 06-LLM-PROMPTS-TO-RUN.md as a test plan. Use for llm-prompts, monitor setup, and full audits. This skill generates prompts; it does not measure LLM visibility.
allowed-tools:
  - Read
  - Bash
  - Write
---

# GEO LLM Prompts Skill

## Purpose

Generate a business-specific LLM visibility prompt library from the confirmed CONFIG.

This skill creates a test plan. It does not run prompts and does not report measured results.

## Inputs

- Confirmed CONFIG
- Prompt template or prompt index
- Objective
- Output folder
- Provider status

## Required Behavior

1. Load the prompt template/index from the repo.
2. Replace all CONFIG placeholders.
3. Do not leave unresolved `{{variables}}` in prompts.
4. Preserve runtime fields such as raw response placeholders as explicit manual fields when needed.
5. Start `06-LLM-PROMPTS-TO-RUN.md` with a warning that the file is a prompt library/test plan, not measurement results.
6. List which prompt groups are recommended for the selected objective.
7. For `full-audit`, always generate the prompt plan even when no LLM provider is configured.
8. If no LLM provider is configured, explain how to run prompts manually and how to log results.
9. Return a short, user-facing prompt summary that the orchestrator can show in chat.
10. Include the exact missing API guidance needed to turn the prompt plan into measured visibility.

## Required User-Facing Prompt Summary

When no LLM provider is configured, the worker summary must include this information so the orchestrator can show it to the user:

```md
## Prompt Measurement Setup

I generated the GEO prompt plan, but these prompts have not been executed yet.

To run them automatically, configure at least one LLM provider:

- `OPENAI_API_KEY` for OpenAI API results, not ChatGPT UI
- `GEMINI_API_KEY` or `GOOGLE_API_KEY` for Gemini API results
- `ANTHROPIC_API_KEY` for Anthropic API results
- `PERPLEXITY_API_KEY` for Perplexity API results
- `GROQ_API_KEY` for Groq model/API results

`SERPER_API_KEY` is search evidence only. It cannot run LLM prompts.

Representative prompts generated:

1. [prompt]
2. [prompt]
3. [prompt]

Next options:

1. Continue with readiness + search evidence only.
2. Configure an LLM provider and rerun measurement.
3. Run prompts manually in ChatGPT/Claude/Gemini UI and paste responses back as documented manual runs.
```

## Prompt Phase Rules

| IDs | Phase | Measurement boundary |
|---|---|---|
| 01-05 | Discovery | Can generate from CONFIG; not measured visibility |
| 10-17 | Measurement | Only measured after provider/manual execution |
| 20-25 | Extraction | Only after real responses exist |
| 30-34 | Interpretation | Must use available evidence and label inference |
| 40-48 | Audit | Readiness/audit prompts, not visibility proof |
| 50-53 | Action | Recommendations, not guarantees |
| 60-61 | Learning | Needs historical/prior evidence |
| 90 | Validation | Validates structure, not factual truth |

## Evidence Rules

- Generated prompts are `Not run` until executed.
- Prompt files are `Generated artifact` source type.
- Do not claim brand mention, sentiment, citation, share of voice, or competitor dominance from generated prompts.
- Do not let `06-LLM-PROMPTS-TO-RUN.md` be mistaken for `07-LLM-VISIBILITY-RESULTS.md`.

## Outputs

Update:

- `06-LLM-PROMPTS-TO-RUN.md`
- `01-RUN-PLAN.md` prompt status when needed
- `11-RUN-TRACE.md` prompt library version and selected prompt groups

## Required Worker Summary

```md
## geo-llm-prompts Summary

- Prompt template used:
- Prompt groups generated:
- Representative prompts shown to user:
- Providers available:
- Missing provider guidance:
- Measurement status:
- Files updated:
- Next actions:
```
