# Limitations

## General Limits

- This agent cannot guarantee inclusion in AI-generated answers. It can improve readiness, clarity, crawlability, structured context, and measurement discipline, but it cannot force or guarantee selection by any AI answer engine.
- AI answer visibility varies by model, provider, date, prompt, location, personalization, retrieval mode, and index freshness. Visibility may change over time without any website changes. Different interfaces from the same vendor may produce different answers, and API model responses are not necessarily identical to consumer UI responses.

## Measurement Boundaries

- Search API results are not the same as LLM answer results.
- Serper, Google, Bing, or other search results may be used only as Search Evidence.
- Search Evidence can support external authority, discoverability, competitor research, and source presence checks.
- Search Evidence must not be reported as measured LLM visibility.
- Without LLM provider APIs, the agent can generate readiness audits and prompt libraries, but cannot report measured LLM visibility.
- If no LLM provider is configured, `07-LLM-VISIBILITY-RESULTS.md` must say exactly: `Status: Not run — no LLM provider configured`.
- Generated prompts are a test plan only, not visibility results.
- Prompt libraries must not be converted into scores or claims unless prompts were actually executed.

## Provider Coverage

- The agent can only measure providers that are configured and actually run.
- Missing providers must be marked `Not configured` or `Not run`.
- Bing Copilot must be treated as `Manual / Not run` unless an actual supported measurement path exists.
- OpenAI API results must be labeled as OpenAI API/model results, not ChatGPT UI results, unless ChatGPT UI was actually measured.
- Serper is Search Evidence only, not an LLM provider.

## Evidence Classes

Approved evidence statuses:

Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown

- Findings must not be upgraded from Inferred or Search Evidence to Measured unless a qualifying measurement was actually run.
- Unknown must be used when the agent cannot determine a fact from available evidence.

## llms.txt Limits

- `llms.txt` is not a guaranteed ranking factor.
- `llms.txt` is treated as a supplemental discovery/context file.
- It must not be presented as a guaranteed ranking, citation, or visibility lever.
- Its effect may be unknown, provider-specific, or not observable.

## External Authority Limits

- External authority checks are partial and depend on accessible search/index results.
- Absence from search results does not prove absence from the web.
- Presence in search results does not prove use by LLMs.
- External authority checks may be affected by API limits, index freshness, geography, personalization, query phrasing, and accessible sources.

## Scoring Limits

- Scores are diagnostic, not absolute truth.
- Scores are readiness/diagnostic scores, not predictions of inclusion in AI-generated answers.
- Scoring should include rationale, evidence class, source, confidence, and gaps.
- Measurement-dependent scoring areas must be marked `Not run` when required providers are unavailable.

## Schema Limits

- Generated schema is proposed JSON-LD unless validation was actually run.
- The agent must not claim schema is valid unless validated with a parser, validator, or local JSON-LD syntax check.
- Schema can improve machine readability but does not guarantee search ranking, LLM citation, or AI visibility.

## Crawl And Render Limits

- The agent may inspect accessible HTML, rendered content, `robots.txt`, sitemap, metadata, and selected key pages.
- It may miss gated content, blocked content, JavaScript-dependent content, personalized content, region-specific content, or content not included in the configured crawl scope.
- The initial CONFIG extraction is intentionally limited to homepage and up to 3 key pages.

## Monitoring Limits

- Monitoring detects changes only when scheduled checks, provider APIs, or manual runs are configured.
- The agent does not continuously monitor providers unless an explicit monitoring workflow exists.
- Changes in LLM answers may happen without a detectable website-side change.

## Client-Facing QA

- Human QA is recommended before sending client-facing reports.
- Human QA is required before using generated recommendations as final client-facing strategy, technical implementation, or public claims.
- The agent may propose actions, but humans should verify business context, legal/compliance constraints, brand claims, and technical feasibility.

## Prohibited Claims

- Do not say the agent guarantees AI visibility.
- Do not say `llms.txt` guarantees LLM discovery, citation, ranking, or inclusion.
- Do not say schema guarantees AI visibility or ranking.
- Do not say search results prove LLM answer visibility.
- Do not say prompt libraries are measurement results.
- Do not say Serper is an LLM provider.
- Do not say OpenAI API results are ChatGPT UI results unless ChatGPT UI was actually measured.
- Do not say Bing Copilot was measured unless an actual supported measurement path or manual run exists.
- Do not report measured visibility when no LLM provider was configured and run.

## Required Fallback Language

When no LLM provider is configured:

`Status: Not run — no LLM provider configured`

When Serper/search evidence was collected but no LLM provider was run:

`Serper search evidence was collected, but this is not LLM visibility measurement.`

When prompts were generated but not executed:

`These prompts are a test plan only. They do not represent measured LLM visibility until executed through configured providers or documented manual runs.`

When schema was generated but not validated:

`Schema validation status: Not run.`
