# Claim Guardrails

These guardrails prevent the GEO agent from overstating what was actually observed, measured, or inferred.

## Core Rule

The agent must never upgrade evidence.

- A generated prompt is not a result.
- A search result is not an LLM answer.
- A readiness issue is not measured visibility.
- An OpenAI API response is not a ChatGPT UI response.
- A recommendation is not a guarantee.

## Allowed Claim Levels

| Claim level | Allowed when | Evidence status |
|---|---|---|
| Readiness observed | The site, HTML, robots.txt, sitemap, llms.txt, schema, or content was checked directly | Observed |
| Search evidence observed | Serper or another search surface returned evidence | Search Evidence |
| LLM visibility measured | A prompt was executed through a configured LLM provider or documented manual UI run | Measured |
| Interpretation | The agent explains a likely cause from available evidence | Inferred |
| Blocked or skipped | A phase could not run because an API, tool, file, or input was missing | Not run |
| Source unavailable | The agent tried to retrieve a source but it was missing or unusable | Not available |
| Unknown | Evidence is insufficient | Unknown |

## Provider Naming Rules

### OpenAI API vs ChatGPT

If the agent runs prompts with `OPENAI_API_KEY`, label the result as `OpenAI API` or `OpenAI model` with the model name when available.

Do not label OpenAI API results as `ChatGPT` unless ChatGPT UI was separately measured in a documented manual UI run.

### Anthropic API vs Claude UI

If the agent runs prompts with `ANTHROPIC_API_KEY`, label the result as `Anthropic API` or `Claude / Anthropic API` with the model name when available.

Do not imply Claude consumer UI behavior unless Claude UI was manually measured and logged.

### Gemini API

If Gemini is run through `GEMINI_API_KEY` or `GOOGLE_API_KEY`, label it as `Gemini API` unless a manual UI run was documented.

### Perplexity API

Perplexity API results may be labeled `Perplexity API`. Do not imply a separate UI behavior unless manually measured.

### Groq

Groq results must be labeled by `Groq` and model name. They are model/API results, not ChatGPT, Claude, or Gemini results.

### Serper

Serper is search only. It may produce `Search Evidence`, but never `Measured` LLM visibility.

### Bing Copilot

Bing Copilot is `Manual / Not run` unless there is an actual supported measurement path or documented manual UI run.

## Prohibited Claims

The agent must not say:

- The brand was measured in ChatGPT when only OpenAI API was used.
- The brand has LLM visibility when only prompts were generated.
- Serper measured LLM visibility.
- Search rankings prove AI answer visibility.
- llms.txt guarantees visibility, ranking, citation, or inclusion.
- Schema guarantees visibility, ranking, citation, or inclusion.
- A competitor wins in LLM answers without measured LLM responses.
- Sentiment, share of voice, citations, or recommendation status were measured without executed prompts.
- A fix will guarantee AI visibility.

## Required Fallback Phrases

When no LLM provider is configured:

`Status: Not run — no LLM provider configured`

When only search evidence was collected:

`Search evidence was collected, but this is not LLM visibility measurement.`

When Serper specifically was used without LLM providers:

`Serper search evidence was collected, but this is not LLM visibility measurement.`

When prompts were generated but not executed:

`These prompts are a test plan only. They do not represent measured LLM visibility until executed through configured providers or documented manual runs.`

When OpenAI API was used:

`OpenAI API results are not ChatGPT UI results unless ChatGPT UI was separately measured and logged.`

## Claim Gate Before Finalizing Outputs

Before writing `07-LLM-VISIBILITY-RESULTS.md`, `08-BACKLOG.md`, or `09-FINAL-REPORT.md`, the orchestrator must check:

1. Did a real provider run happen?
2. Which provider/interface produced the result?
3. Is the provider name accurate?
4. Is every major claim labeled with evidence status?
5. Do `01-RUN-PLAN.md`, `07-LLM-VISIBILITY-RESULTS.md`, and `08-BACKLOG.md` agree about what ran?
6. Are recommendations tied to evidence, not assumptions?

If any answer is unclear, mark the relevant claim `Unknown`, `Inferred`, or `Not run` instead of strengthening it.
