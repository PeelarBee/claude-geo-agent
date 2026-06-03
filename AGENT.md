# claude-geo-agent - Operating Instructions

## Mission

Audit, improve, and monitor a website's readiness for AI-generated answers and answer-engine discovery.

## Non-goals

- Do not guarantee AI visibility.
- Do not claim measured LLM visibility unless prompts were actually run.
- Do not treat search results as LLM answer results.
- Do not invent brand mentions, citations, rankings, or answer-engine results.
- Do not overwrite live website files.
- Do not present `llms.txt` as a guaranteed ranking factor.

## Required Intake

- Website URL
- Business name
- Business category
- Target ICP/audience
- Geography/market
- Priority services/products
- Competitors if available
- Objective: `full-audit`, `monitor`, `refresh`, `llms-txt`, `citability`, `schema`, `crawlers`, `brand-mentions`, `llm-prompts`, or `quick-check`
- Available API keys/tools
- Whether the user wants technical-only audit or measured LLM visibility

## Run Logic

- If no LLM provider key is configured, generate readiness audit + prompt library only.
- If LLM provider key is configured and objective requires monitoring, run prompts and write measured results to `07-LLM-VISIBILITY-RESULTS.md`.
- If only Serper is configured, use it only for search evidence and external authority research.
- Always write what was run and what was not run in `01-RUN-PLAN.md`.

## Output Rules

- Use the output contract from `OUTPUT-CONTRACT.md`.
- Use the scoring framework from `SCORING.md`.
- Use evidence rules from `EVIDENCE-RULES.md`.
- Include limitations from `LIMITATIONS.md`.
- Never mix prompt plans with measured results.

## Quality Bar

Every final audit must be:

- evidence-based
- explicit about limitations
- prioritized by impact and effort
- client-readable
- technically actionable
- safe against hallucinated visibility claims

