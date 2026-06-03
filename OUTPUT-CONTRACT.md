# Output Contract

All audit outputs must be client-readable, evidence-based, and explicit about what was and was not measured.

## Required Sections For Every Audit Output

Every audit output must include:

- Objective
- Date/time of run
- Domain
- APIs/tools available
- APIs/tools not configured
- What was run
- What was not run
- Assumptions
- Limitations
- Executive Summary
- Key Findings
- Evidence Table
- Priority Fixes
- Backlog
- Next Actions

If a section is not applicable to the objective, include the section and mark it `Not applicable` with a short reason.

## Finding Format

Every finding must use this structure:

```md
## Finding: [clear issue name]

- Evidence Status: Observed / Measured / Inferred / Not run / Not available / Unknown
- Evidence Source: [URL, file, API, local check, or "not available"]
- Confidence: High / Medium / Low
- Priority: Critical / High / Medium / Low
- Impact: High / Medium / Low
- Effort: High / Medium / Low
- Why it matters:
- Recommended action:
- Acceptance criteria:
```

## Evidence Table Format

```md
| Finding | Evidence Status | Evidence Source | Confidence | Priority | Impact | Effort | Next Action |
|---|---|---|---|---|---|---|---|
| [finding] | Observed / Measured / Inferred / Not run / Not available / Unknown | [source] | High / Medium / Low | Critical / High / Medium / Low | High / Medium / Low | High / Medium / Low | [action] |
```

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

## `07-LLM-VISIBILITY-RESULTS.md`

If LLM prompts were not run, the file must clearly say:

```md
Status: Not run — no LLM provider configured
```

or an equivalent objective-specific reason, such as:

```md
Status: Not run — objective was prompt library only
```

It must:

- List which providers were configured and which were not
- Separate measured answer results from interpretation
- Include prompt group, prompt text, provider, run date/time, response summary, citations if present, and extraction result
- Mark every unrun group as `Not run`
- Preserve raw answer samples only when actual provider responses exist

It must not:

- Contain fake answer results
- Treat Serper, Google results, or third-party search results as LLM answer visibility
- Treat generated prompts as measured visibility
- Claim ChatGPT/Claude/Gemini/Perplexity/Groq/Bing Copilot visibility unless the corresponding provider/API/run mode was executed

## Priority Fixes

Every priority fix must include:

- Evidence
- Confidence
- Priority
- Impact
- Effort
- Recommended action
- Next action
- Acceptance criteria

## Backlog

Backlog items must be prioritized by impact and effort. Use this structure:

```md
| Priority | Task | Type | Evidence Status | Evidence Source | Impact | Effort | Owner | Status |
|---|---|---|---|---|---|---|---|---|
| Critical / High / Medium / Low | [task] | technical/content/schema/messaging/measurement/llms.txt | [class] | [source] | High / Medium / Low | High / Medium / Low | [owner] | Open |
```

