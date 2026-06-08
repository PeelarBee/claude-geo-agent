# GEO Support Scripts

These scripts make the GEO agent more repeatable.

They are support tools for the orchestrator. Users normally do not call them directly.

## Scripts

| Script | Purpose |
|---|---|
| `check-providers.sh` | Checks whether Serper and LLM provider keys are configured without printing secrets |
| `create-output-skeleton.sh` | Creates the standard output files from `00` to `11` |
| `static-geo-checks.sh` | Checks robots.txt, sitemap.xml, llms.txt, security.txt, humans.txt, homepage raw HTML signals |
| `instantiate-prompts.sh` | Turns the prompt template into `06-LLM-PROMPTS-TO-RUN.md` for a confirmed business CONFIG |
| `render-not-run-results.sh` | Writes honest `07-LLM-VISIBILITY-RESULTS.md` when no LLM provider is configured |
| `serper-search.sh` | Runs a Serper search and labels it Search Evidence, not LLM measurement |
| `run-llm-prompt.sh` | Runs one prompt against a configured LLM provider and logs provider/interface/model/date/prompt/response |
| `create-api-setup-guide.sh` | Creates plain-English API setup guidance |
| `assemble-final-report.sh` | Combines outputs into `09-FINAL-REPORT.md` |
| `validate-output-consistency.sh` | Checks that run plan, results, backlog, final report, and run trace do not contradict each other |

## Important Boundaries

Serper search output is `Search Evidence`.

LLM provider output is `Measured` only when a prompt actually ran.

OpenAI API output must be labeled `OpenAI API`, not `ChatGPT UI`.

Generated prompts are a test plan, not measured results.

## Typical Full-Audit Support Flow

```bash
scripts/check-providers.sh
scripts/create-output-skeleton.sh example.com-geo-audit
scripts/static-geo-checks.sh https://example.com > example.com-geo-audit/02-TECHNICAL-GEO-AUDIT.md
scripts/render-not-run-results.sh example.com-geo-audit "Example Brand" Missing
scripts/create-api-setup-guide.sh example.com-geo-audit "Example Brand"
scripts/assemble-final-report.sh example.com-geo-audit
scripts/validate-output-consistency.sh example.com-geo-audit
```

The real orchestrator should decide which scripts to run based on objective, provider status, and evidence tier.

## Final QA Rule

Before the agent presents a full audit as final, it should run or apply the same checks as `validate-output-consistency.sh`.

If the validator fails, the final report should not be delivered as final until the contradiction is fixed or clearly marked as a limitation.
