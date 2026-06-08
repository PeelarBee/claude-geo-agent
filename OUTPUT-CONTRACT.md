# Output Contract

All audit outputs must be client-readable, evidence-based, and explicit about what was and was not measured.

The contract has one central purpose: prevent contradictions between the run plan, measured results, backlog, final report, and run trace.

## Required Metadata For Every Output

Every output must include:

- Objective
- Date/time of run
- Domain
- Brand
- Agent version
- Rules version
- Prompt library version when prompts are involved
- Data / Measurement Tier: Tier 0 / Tier 1 / Tier 2 / Mixed
- APIs/tools available
- APIs/tools not configured
- What was run
- What was not run
- Evidence boundary
- Assumptions
- Limitations

Artifact-style outputs, such as llms.txt drafts, schema drafts, or prompt libraries, may mark report sections `Not applicable`, but they must still include metadata and evidence boundary.

## Evidence Status Values

Use exactly these values:

Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown

Do not use alternate capitalization in final outputs.

## Finding Format

Every major finding must use this structure:

```md
## Finding: [clear issue name]

- Evidence Status: Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown
- Evidence Source Type: Crawl / Rendered HTML / Search API / LLM API / Manual UI / Local file / Generated artifact / Not available
- Evidence Source: [URL, file, API, local check, provider, or "not available"]
- Evidence Date / Run Date:
- Confidence: High / Medium / Low
- Priority: Critical / High / Medium / Low
- Impact: High / Medium / Low
- Effort: High / Medium / Low
- Why it matters:
- Recommended action:
- Acceptance Criteria:
```

## Required Full-Audit Output Set

A `full-audit` must generate:

| File | Purpose |
|---|---|
| `00-START-HERE.md` | Plain-English summary and first decisions |
| `01-RUN-PLAN.md` | What will run, what is blocked, providers, tier, checklist |
| `02-TECHNICAL-GEO-AUDIT.md` | Readiness audit and GEO Readiness Score |
| `03-FIX-GUIDE.md` | Prioritized fix instructions |
| `04-LLMS-TXT.md` | llms.txt check/draft |
| `05-SCHEMA.md` | Schema audit/proposed JSON-LD |
| `06-LLM-PROMPTS-TO-RUN.md` | Prompt library/test plan only |
| `07-LLM-VISIBILITY-RESULTS.md` | Measured results only when provider/manual runs exist; otherwise Not run |
| `08-BACKLOG.md` | Prioritized tasks tied to evidence |
| `09-FINAL-REPORT.md` | Synthesis separating readiness, measurement, and recommendations |
| `10-API-SETUP-GUIDE.md` | Plain-English setup guide for missing APIs/providers |
| `11-RUN-TRACE.md` | Run receipt: inputs, providers, decisions, phases, outputs, consistency QA |

For narrower objectives, generate the relevant subset plus `01-RUN-PLAN.md` and `11-RUN-TRACE.md`.

## `01-RUN-PLAN.md`

Must be generated after CONFIG confirmation, provider/tool checks, and tier selection, before audit outputs.

It must include:

```md
## CONFIG Confirmation

- CONFIG extracted from:
- CONFIG confirmed by user: Yes / No
- Confirmation timestamp:

## Selected Objective

- Objective:
- Audit mode:
- Outputs to generate:
- Outputs intentionally skipped:
- Reason for skipped outputs:

## Orchestration Checklist

| Phase | Worker/subskill | Planned | Run condition | Output |
|---|---|---|---|---|
| Capability check | scripts/check-providers.sh | Yes / No | Always after CONFIG | 01, 11 |
| Crawlers | geo-crawlers | Yes / No | readiness objectives | 02, 03, 08, 11 |
| llms.txt | geo-llms-txt | Yes / No | readiness objectives | 04, 02, 03, 08, 11 |
| Schema | geo-schema | Yes / No | readiness objectives | 05, 02, 03, 08, 11 |
| Citability | geo-citability | Yes / No | full-audit/citability | 02, 03, 08, 11 |
| Brand mentions | geo-brand-mentions | Yes / No | Serper/search configured | 02, 03, 08, 11 |
| Prompt library | geo-llm-prompts | Yes / No | full-audit/llm-prompts/monitor | 06, 11 |
| LLM measurement | geo-monitor | Yes / No | LLM provider/manual mode | 07, 11 |
| Synthesis | orchestrator | Yes / No | after evidence collection | 08, 09 |
| API guidance | scripts/create-api-setup-guide.sh | Yes / No | missing useful APIs/providers | 10 |

## API Status

| API | Status | Used for |
|---|---|---|
| `SERPER_API_KEY` | Configured / Missing | Search Evidence only |
| `GEMINI_API_KEY` / `GOOGLE_API_KEY` | Configured / Missing | Gemini API measurement |
| `GROQ_API_KEY` | Configured / Missing | Groq measurement |
| `OPENAI_API_KEY` | Configured / Missing | OpenAI API measurement, not ChatGPT UI |
| `ANTHROPIC_API_KEY` | Configured / Missing | Anthropic API measurement |
| `PERPLEXITY_API_KEY` | Configured / Missing | Perplexity API measurement |

## Data / Measurement Tier

- Tier selected:
- Reason:
- Available evidence:
- Blocked evidence:
- Measurement-dependent phases:
- LLM visibility measurement status:

## Scenario Status

Choose exactly one:

- Partial full-audit: technical GEO completed, live LLM visibility not measured.
- Partial full-audit: technical GEO + search evidence completed, live LLM visibility not measured.
- Status: Live LLM results collected
- Status: Manual run required — prompt library generated only
```

## `06-LLM-PROMPTS-TO-RUN.md`

This is a prompt library / test plan, not measurement.

It must not:

- Claim that the brand appeared in an LLM answer
- Report visibility scores based only on generated prompts
- Mix prompt text with fake answer results

It must include a clear warning that prompts must be executed before any measured visibility claim is made.

## `07-LLM-VISIBILITY-RESULTS.md`

Must always include one of these statuses:

- `Status: Live LLM results collected`
- `Status: Not run — no LLM provider configured`
- `Status: Manual run required — prompt library generated only`

If no LLM provider is configured, it must say exactly:

`Status: Not run — no LLM provider configured`

If no LLM provider is configured, every prompt group must be marked `Not run`.

Measured rows must include:

| Provider | Interface | Model | Prompt ID | Prompt Group | Prompt Text | Brand Mentioned | Competitors Mentioned | Citations/Sources | Sentiment/Framing | Verdict | Run Date/Time | Fresh Context | Response Summary | Extraction Result | Evidence Status | Evidence Source | Evidence Source Type |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| [provider] | API / Manual UI | [model] | [ID] | [group] | [prompt] | Yes / No / Unknown | [names] | [sources] | [sentiment] | Win / Gap / Risk / Not run | [timestamp] | Yes / No | [summary] | [json/summary] | Measured | [provider run] | LLM API / Manual UI |

Provider naming rules:

- OpenAI API results must not be labeled ChatGPT UI.
- Anthropic API results must not imply Claude UI unless manual UI was run.
- Serper must not appear as an LLM result provider.
- Bing Copilot is Manual / Not run unless documented.

## `08-BACKLOG.md`

Every backlog item must be tied to evidence.

```md
| Priority | Task | Type | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Impact | Effort | Owner | Status | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|---|---|
```

Backlog rules:

- Do not create measurement-backed tasks if measurement did not run.
- If a task comes from readiness, label it Observed or Inferred.
- If a task comes from search evidence, label it Search Evidence or Inferred.
- If a task comes from measured LLM gaps, label it Measured and point to the provider run.

## `09-FINAL-REPORT.md`

Must separate:

1. Readiness findings
2. Search evidence findings
3. Measured LLM visibility results
4. Inferred interpretation
5. Recommended actions
6. What was not run
7. Next setup steps

It must not blend these into one unsupported visibility narrative.

## `10-API-SETUP-GUIDE.md`

Must explain in plain English:

- What runs without APIs
- What Serper adds
- What an LLM provider adds
- OpenAI API vs ChatGPT UI
- Manual prompt-running option
- What to connect next for real measurement

## `11-RUN-TRACE.md`

Must follow `RUN-LOG-SPEC.md` and include:

- Run identity
- Inputs
- Confirmed CONFIG
- Providers/tools available
- Tier decision
- Orchestration checklist
- Prompt execution log
- Agent decisions
- Blocked/skipped work
- Output consistency check
- Residual risk

## Consistency QA

Before final delivery, the agent must verify:

| Check | Required outcome |
|---|---|
| `01` and `11` agree on phases run | Pass |
| `07` matches provider availability | Pass |
| `08` does not treat unrun phases as measured | Pass |
| `09` separates readiness, measurement, and recommendations | Pass |
| OpenAI API is not labeled ChatGPT UI | Pass |
| Serper/search evidence is not labeled LLM visibility | Pass |

If any check fails, fix the output or mark the issue as a limitation before finalizing.
