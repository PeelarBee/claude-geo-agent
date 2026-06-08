# GEO Agent Quality Gates

These gates define what must be true before a GEO audit can be considered ready.

They are stricter than normal documentation checks because this agent produces client-facing claims.

## Gate 1 - CONFIG Confirmed

Pass criteria:

- The user confirmed the extracted CONFIG before execution.
- `01-RUN-PLAN.md` records CONFIG confirmation.
- `11-RUN-TRACE.md` records CONFIG source pages and confirmation status.

Fail if:

- Audit outputs were generated before CONFIG confirmation.

## Gate 2 - Provider Boundary

Pass criteria:

- Provider availability is shown as Configured / Missing only.
- Secret values are never printed.
- Serper is labeled Search Evidence only.
- OpenAI API is labeled OpenAI API, not ChatGPT UI.
- Bing Copilot is Manual / Not run unless documented.

Fail if:

- Any API key value appears in outputs.
- Serper is treated as measured LLM visibility.
- OpenAI API is called ChatGPT UI without a documented manual ChatGPT run.

## Gate 3 - Readiness vs Measurement Separation

Pass criteria:

- Readiness findings use Observed, Search Evidence, Inferred, Not run, Not available, or Unknown as appropriate.
- Measured is used only for completed LLM provider/manual runs.
- `06-LLM-PROMPTS-TO-RUN.md` is a test plan.
- `07-LLM-VISIBILITY-RESULTS.md` is measured results or explicit Not run.

Fail if:

- Generated prompts are treated as results.
- Readiness checks are described as measured LLM visibility.

## Gate 4 - Prompt And API Guidance

Pass criteria:

- For `full-audit` and `llm-prompts`, `06-LLM-PROMPTS-TO-RUN.md` exists.
- If no LLM provider is configured, the user was told in the chat that generated prompts are not measurement.
- If no LLM provider is configured, the user was told which API keys can enable automatic measurement.
- If only Serper is configured, the user was told that Serper is search evidence only and cannot execute LLM prompts.
- The audit offers manual UI testing as an alternative path when provider APIs are missing.

Fail if:

- A full audit completes without a prompt plan.
- API setup guidance appears only in `10-API-SETUP-GUIDE.md` but was not surfaced to the user during the run.
- The user has to infer how to convert prompts into measured visibility.

## Gate 5 - Output Consistency

Pass criteria:

- `01-RUN-PLAN.md`, `06-LLM-PROMPTS-TO-RUN.md`, `07-LLM-VISIBILITY-RESULTS.md`, `08-BACKLOG.md`, `09-FINAL-REPORT.md`, and `11-RUN-TRACE.md` agree.
- If `01` says no LLM provider, `07` says `Status: Not run -- no LLM provider configured`.
- If `07` contains measured rows, `11` contains provider, prompt, model if known, and run timestamp.
- `08` does not treat blocked/unrun phases as measured.

Fail if:

- One output claims measurement while another says measurement was not run.

## Gate 6 - Evidence Completeness

Pass criteria:

Every major finding includes:

- Evidence Status
- Evidence Source Type
- Evidence Source
- Evidence Date / Run Date
- Confidence
- Priority
- Impact
- Effort
- Recommended Action
- Acceptance Criteria

Fail if:

- Major findings are unsupported bullet points.
- Priority appears without rationale.

## Gate 7 - Prioritization Quality

Pass criteria:

The backlog clearly distinguishes:

- Critical blockers
- High-impact readiness fixes
- Measurement setup tasks
- Nice-to-have improvements

The top priorities should explain why they matter for GEO.

Fail if:

- The backlog is a flat list without impact/effort/evidence.
- API setup tasks are mixed with site/content fixes without context.

## Gate 8 - Scoring Transparency

Pass criteria:

The GEO Readiness Score shows:

- component points
- evidence class
- evidence source
- confidence
- positive drivers
- negative drivers
- what would improve the score

Fail if:

- The score is a single unexplained number.
- The score includes fake measured visibility credit.

## Gate 9 - GEO Scope Discipline

Pass criteria:

The audit stays focused on:

- crawlability/access
- entity clarity
- structured context
- answer readiness/citability
- external authority/source evidence
- prompt planning
- measured LLM visibility when available
- prioritized GEO actions

Fail if:

- The report becomes a generic SEO checklist without GEO rationale.

## Gate 10 - Final Report Readiness

Pass criteria:

`09-FINAL-REPORT.md` has separate sections for:

1. Readiness
2. Search Evidence
3. Prompt Plan
4. Measured LLM Visibility
5. What Was Not Run
6. Recommendations
7. Next Setup Steps

Fail if:

- The final report blends readiness, search evidence, prompts, and measurement into one unsupported claim.

## Gate 11 - Human Review

Pass criteria:

The agent states remaining limitations and recommends human review for client-facing use.

Fail if:

- The agent presents the report as guaranteed truth or a guaranteed visibility plan.
