# Run Log And Traceability Spec

Every GEO audit must leave a run trace that explains what happened, what did not happen, and why.

The run trace is not client marketing copy. It is the audit receipt.

## Required Run Trace File

Each audit output folder must include:

`11-RUN-TRACE.md`

The final report may summarize this file, but must not replace it.

## Required Fields

```md
# GEO Run Trace: [Domain]

## Run Identity

- Run ID: [YYYYMMDD-HHMMSS-domain-objective]
- Run date/time:
- Agent version:
- Rules version:
- Prompt library version:
- Output contract version:
- Objective:
- Domain:
- Brand:
- Locale:

## Confirmed Input

- Website URL:
- Objective:
- Confirmed CONFIG source pages:
- User-confirmed CONFIG: Yes / No
- Competitors supplied by user:
- Competitors discovered by search:

## Provider Capability Check

| Provider/tool | Status | Evidence role | Notes |
|---|---|---|---|
| WebFetch/local crawl | Available / Not available | Observed | |
| curl/static checks | Available / Not available | Observed | |
| Serper | Configured / Missing | Search Evidence only | Not LLM measurement |
| Gemini API | Configured / Missing | Measured only if run | |
| OpenAI API | Configured / Missing | Measured only if run as OpenAI API | Not ChatGPT UI |
| Anthropic API | Configured / Missing | Measured only if run as Anthropic API | |
| Groq API | Configured / Missing | Measured only if run | |
| Perplexity API | Configured / Missing | Measured only if run | |
| Manual Prompt Mode | Offered / Selected / Not selected | Manual UI only | Requires pasted responses |
| Bing Copilot | Manual / Not run | Manual UI only | |

## Measurement Mode Decision

- Measurement mode offered: API / Manual Prompt Mode / Readiness-only
- Measurement mode selected: API / Manual Prompt Mode / Readiness-only / Not selected
- Reason:
- User-facing guidance shown: Yes / No
- If Manual Prompt Mode selected, copy/paste instructions shown: Yes / No
- If API selected, configured provider:
- If readiness-only selected, measurement limitation:

## Tier Decision

- Selected tier: Tier 0 / Tier 1 / Tier 2 / Mixed
- Reason:
- Readiness phases allowed:
- Search evidence phases allowed:
- Prompt plan phases allowed:
- Measurement phases allowed:
- Measurement phases blocked:

## Orchestration Checklist

| Phase | Worker/subskill | Planned | Ran | Status | Why / decision | Output updated |
|---|---|---|---|---|---|---|
| Capability check | provider scripts | Yes / No | Yes / No | Run / Not run / Blocked | | `01-RUN-PLAN.md` |
| API / Manual guidance | orchestrator | Yes / No | Yes / No | Run / Not run / Blocked | | `01`, `10`, `11` |
| Crawlers | geo-crawlers | Yes / No | Yes / No | Run / Not run / Blocked | | `02-TECHNICAL-GEO-AUDIT.md` |
| llms.txt | geo-llms-txt | Yes / No | Yes / No | Run / Not run / Blocked | | `04-LLMS-TXT.md` |
| Schema | geo-schema | Yes / No | Yes / No | Run / Not run / Blocked | | `05-SCHEMA.md` |
| Citability | geo-citability | Yes / No | Yes / No | Run / Not run / Blocked | | `02`, `03`, `08` |
| Brand mentions | geo-brand-mentions | Yes / No | Yes / No | Run / Not run / Blocked | | `02`, `03`, `08` |
| Prompt library | geo-llm-prompts | Yes / No | Yes / No | Run / Not run / Blocked | | `06-LLM-PROMPTS-TO-RUN.md` |
| LLM measurement | geo-monitor | Yes / No | Yes / No | Run / Not run / Blocked | | `07-LLM-VISIBILITY-RESULTS.md` |
| Claim QA | orchestrator | Yes / No | Yes / No | Run / Not run / Blocked | | `09-FINAL-REPORT.md` |
| API guidance | setup guide script | Yes / No | Yes / No | Run / Not run / Blocked | | `10-API-SETUP-GUIDE.md` |

## Prompt Execution Or Manual Prompt Log

| Prompt ID | Prompt group | Provider | Interface | Model | Run date/time | Cold context? | Status | Output location |
|---|---|---|---|---|---|---|---|---|
| [ID] | [group] | [provider] | API / Manual UI / Manual Prompt Pack | [model] | [timestamp] | Yes / No | Run / Not run / Manual required / Blocked | [file] |

## Manual Response Intake Log

Use this section only when the user pasted manual chatbot responses back.

| Prompt ID | Chatbot | Model if visible | Date/time | Fresh chat? | Full response captured? | Sources captured? | Analysis status |
|---|---|---|---|---|---|---|---|
| [ID] | ChatGPT / Claude / Gemini / Perplexity / Copilot | [model] | [timestamp] | Yes / No | Yes / No | Yes / No | Parsed / Not parsed |

## Decisions Made By The Agent

| Decision | Reason | Evidence used | Alternative rejected | Output affected |
|---|---|---|---|---|
| [decision] | [why] | [evidence] | [alternative] | [file] |

## Blocked Or Skipped Work

| Phase | Reason blocked/skipped | Required to run later | User guidance |
|---|---|---|---|
| [phase] | [reason] | [API/tool/input/manual responses] | [plain English next step] |

## Output Consistency Check

| Check | Pass / Fail | Notes |
|---|---|---|
| `01-RUN-PLAN.md` agrees with `07-LLM-VISIBILITY-RESULTS.md` | Pass / Fail | |
| `06-LLM-PROMPTS-TO-RUN.md` exists and has grouped copy/paste instructions when required | Pass / Fail | |
| `07-LLM-VISIBILITY-RESULTS.md` does not contain fake measurement | Pass / Fail | |
| `08-BACKLOG.md` does not treat unrun phases as measured | Pass / Fail | |
| `09-FINAL-REPORT.md` separates readiness, prompts, measurement, and recommendations | Pass / Fail | |
| OpenAI API is not labeled ChatGPT UI | Pass / Fail | |
| Serper/search evidence is not labeled LLM visibility | Pass / Fail | |
| Manual UI runs are labeled Manual UI | Pass / Fail | |

## Residual Risk

- [Known limitation]
- [Open question]
```

## Versioning Rules

Use semantic labels even before packaged releases exist:

- Agent version: `agent-rules-vYYYY.MM.DD`
- Prompt library version: `prompts-vYYYY.MM.DD`
- Output contract version: `outputs-vYYYY.MM.DD`
- Evals version: `evals-vYYYY.MM.DD`

If a prompt, guardrail, output contract, or eval changes, the next run trace must record the new version label.

## Consistency Requirement

`11-RUN-TRACE.md` must agree with:

- `01-RUN-PLAN.md`
- `06-LLM-PROMPTS-TO-RUN.md`
- `07-LLM-VISIBILITY-RESULTS.md`
- `08-BACKLOG.md`
- `09-FINAL-REPORT.md`

If there is a conflict, the final report must not be delivered as final until the conflict is resolved or clearly marked as a limitation.
