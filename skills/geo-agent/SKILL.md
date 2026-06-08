---
name: geo-agent
description: Run a GEO (Generative Engine Optimization) audit for a website. Use when the user wants to check AI search readiness, answer-engine discoverability, llms.txt, schema, crawler access, citability, brand mentions, prompt libraries, or measured LLM visibility when providers are configured. This is the main portable Codex/OpenAI skill; it orchestrates internal GEO workers automatically.
---

# GEO Agent Skill

This is the main portable GEO skill for Codex/OpenAI Skills.

The user installs this main skill. They do not need to install or call each subagent manually.

When installed with `install-codex.sh`, supporting docs, prompts, scripts, agents, and templates are bundled under this skill's `references/` folder.

## Simple Mental Model

- The main skill is `geo-agent`.
- The user asks for a GEO audit.
- The skill confirms URL, objective, and business CONFIG.
- The skill checks which providers are available.
- The skill runs the right internal modules.
- The skill applies quality gates.
- The skill creates a clear report.

## Core Rule

Separate these three things:

1. Readiness: whether the website is prepared to be crawled, understood, and cited.
2. Measurement: whether prompts were actually run in configured LLM providers or documented manual UI runs.
3. Recommendations: what to fix first based on evidence.

Do not mix them.

## Required Flow

1. Ask only for Website URL and objective.
2. Fetch homepage and up to 3 key pages to infer CONFIG.
3. Ask the user to confirm CONFIG.
4. Do not run the audit until CONFIG is confirmed.
5. Check providers and tools.
6. Select evidence tier.
7. Show checklist.
8. Run readiness modules first.
9. Run search evidence only if search provider exists.
10. Run LLM measurement only if LLM provider or documented manual mode exists.
11. Write outputs.
12. Apply `QUALITY-GATES.md` before finalizing.
13. Check that outputs do not contradict each other.
14. If available, run or apply `references/scripts/validate-output-consistency.sh` to validate output consistency.

## Objectives

- `full-audit`
- `monitor`
- `refresh`
- `llms-txt`
- `citability`
- `schema`
- `crawlers`
- `brand-mentions`
- `llm-prompts`
- `quick-check`

## Internal Modules

When the environment supports local files/subskills, use these internal skill files:

- `skills/geo-crawlers/SKILL.md`
- `skills/geo-citability/SKILL.md`
- `skills/geo-brand-mentions/SKILL.md`
- `skills/geo-schema/SKILL.md`
- `skills/geo-llms-txt/SKILL.md`
- `skills/geo-llm-prompts/SKILL.md`
- `skills/geo-monitor/SKILL.md`

If those files are not available in the environment, continue with the same responsibilities but tell the user that portable subskills are missing and results may be less modular.

## Reference Files

Use these supporting files when available:

- `references/CLAIM-GUARDRAILS.md`
- `references/EVIDENCE-RULES.md`
- `references/RUN-LOG-SPEC.md`
- `references/ORCHESTRATION.md`
- `references/OUTPUT-CONTRACT.md`
- `references/SCORING.md`
- `references/QUALITY-GATES.md`
- `references/EVALS.md`
- `references/NON-TECHNICAL-USER-GUIDE.md`

## Provider Rules

Serper:

- `SERPER_API_KEY` is search evidence only.
- It does not measure LLM visibility.

LLM providers:

- `GEMINI_API_KEY` or `GOOGLE_API_KEY` measures Gemini API results when run.
- `OPENAI_API_KEY` measures OpenAI API results when run. This is not ChatGPT UI.
- `ANTHROPIC_API_KEY` measures Anthropic API results when run.
- `GROQ_API_KEY` measures Groq results when run.
- `PERPLEXITY_API_KEY` measures Perplexity API results when run.

If no LLM provider is configured, write:

`Status: Not run -- no LLM provider configured`

## OpenAI API vs ChatGPT

Do not call OpenAI API results `ChatGPT`.

Use:

`OpenAI API results are not ChatGPT UI results unless ChatGPT UI was separately measured and logged.`

## Outputs

A full audit should create or describe these outputs:

- `00-START-HERE.md`
- `01-RUN-PLAN.md`
- `02-TECHNICAL-GEO-AUDIT.md`
- `03-FIX-GUIDE.md`
- `04-LLMS-TXT.md`
- `05-SCHEMA.md`
- `06-LLM-PROMPTS-TO-RUN.md`
- `07-LLM-VISIBILITY-RESULTS.md`
- `08-BACKLOG.md`
- `09-FINAL-REPORT.md`
- `10-API-SETUP-GUIDE.md`
- `11-RUN-TRACE.md`

For narrower objectives, create the relevant subset plus a run plan and run trace.

## User-Facing Checklist

Show this after CONFIG is confirmed:

```md
I will run this audit in phases:

- [ ] Capability check - confirm tools and APIs
- [ ] Readiness audit - crawlability, llms.txt, schema, content readiness
- [ ] Search evidence - only if Serper/search provider is configured
- [ ] LLM measurement - only if an LLM provider is configured
- [ ] Synthesis - prioritize fixes and create the report
- [ ] Quality gates - verify claims, evidence labels, scope, and scoring
- [ ] Consistency QA - make sure Run Plan, Results, Backlog, and Final Report agree
```

## Final QA

Before finishing, verify:

- Readiness is separate from measured visibility.
- Search evidence is not labeled LLM visibility.
- OpenAI API is not labeled ChatGPT UI.
- Unrun phases are marked Not run.
- Recommendations are tied to evidence.
- Scores explain which inputs raised or lowered them.
- The run plan, results, backlog, final report, and run trace agree.
- Any quality gate failure is fixed or documented as a limitation.
