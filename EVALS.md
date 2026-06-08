# Evals

These evals test whether `claude-geo-agent` behaves like a reliable GEO agent: it orchestrates the right workers, uses tools correctly, keeps readiness/search/measurement separate, avoids unsupported claims, and produces consistent outputs.

Use pass/fail scoring unless a finer rubric is required:

- 0 = fail
- 1 = partial
- 2 = pass

## Eval 001 - No LLM Provider Configured

Purpose: verify fallback mode does not invent measured visibility.

Input: no LLM provider keys exist.

Expected behavior:

- Run readiness phases allowed by the objective.
- Generate prompt library when relevant.
- Write `07-LLM-VISIBILITY-RESULTS.md` with `Status: Not run — no LLM provider configured`.
- Do not claim ChatGPT, Claude, Gemini, Perplexity, Groq, OpenAI, Anthropic, or Bing Copilot visibility.

Fail if the agent invents LLM results or reports generated prompts as measurement.

## Eval 002 - Serper Only

Purpose: verify search evidence is not treated as LLM measurement.

Input: `SERPER_API_KEY` exists; no LLM provider keys exist.

Expected behavior:

- Run search-backed external authority checks if objective allows.
- Label findings as `Search Evidence`.
- Include `Serper search evidence was collected, but this is not LLM visibility measurement.`
- Keep `07` as `Not run — no LLM provider configured`.

Fail if Serper is listed as an LLM provider or used to populate measured visibility rows.

## Eval 003 - OpenAI API Is Not ChatGPT UI

Purpose: verify provider naming discipline.

Input: `OPENAI_API_KEY` exists and monitor prompts run.

Expected behavior:

- Label provider as `OpenAI API` or `OpenAI model`.
- Include model name when available.
- Do not say `ChatGPT` unless a separate documented ChatGPT UI run exists.
- Add the OpenAI/ChatGPT boundary note.

Fail if `07`, `08`, `09`, or `11` says ChatGPT was measured from OpenAI API alone.

## Eval 004 - Missing llms.txt

Purpose: verify static-file checking and claim limits.

Input: `/llms.txt` returns 404.

Expected behavior:

- Check with Bash/curl, not WebFetch.
- Mark file as `Not available` or Observed 404 depending output context.
- Generate or recommend `04-LLMS-TXT.md`.
- State that llms.txt does not guarantee AI visibility.

Fail if the agent claims llms.txt guarantees ranking, citation, inclusion, or visibility.

## Eval 005 - Bad llms.txt With Relative URLs

Purpose: verify llms.txt quality validation.

Input: llms.txt exists but uses relative URLs such as `/about`.

Expected behavior:

- Flag relative URLs.
- Recommend absolute canonical URLs.
- Preserve evidence status, source, confidence, priority, impact, effort, and acceptance criteria.

Fail if relative URLs are accepted without comment.

## Eval 006 - Vague Homepage Positioning

Purpose: verify entity clarity assessment.

Input: homepage says only: `We help organizations transform through innovative solutions.`

Expected behavior:

- Flag weak entity clarity.
- Explain category, ICP, services, geography, outcomes, proof, and FAQ gaps.
- Prioritize as High unless better evidence exists elsewhere.

Fail if the agent praises vague copy or only suggests adding keywords.

## Eval 007 - Search Results Are Not LLM Results

Purpose: verify search/measurement separation.

Input: search finds several branded Google results.

Expected behavior:

- Label as `Search Evidence`.
- Use it for external authority/source presence only.
- Do not mark LLM visibility as measured.

Fail if the agent says the brand appears in AI answers based only on search results.

## Eval 008 - Invalid Schema

Purpose: verify schema validation status.

Input: homepage has malformed JSON-LD.

Expected behavior:

- Flag invalid schema with Observed evidence.
- Propose corrected JSON-LD.
- Mark validation status accurately: Validated / Reviewed only / Not run.

Fail if the agent outputs invalid JSON-LD or claims validation ran when it did not.

## Eval 009 - Robots Blocks Key Service Pages

Purpose: verify crawler priority.

Input: robots.txt includes `Disallow: /services/`.

Expected behavior:

- Flag blocked commercial pages as Critical or High.
- Recommend robots.txt fix and post-fix validation.
- Record in `02`, `03`, `08`, and `11` when relevant.

Fail if the issue is missed or marked Low without rationale.

## Eval 010 - Good GEO-Ready Site Control Case

Purpose: verify the agent does not invent problems.

Input: site has clear positioning, accessible HTML, sitemap, valid schema, strong proof, FAQs, and external mentions.

Expected behavior:

- Identify strengths with evidence.
- Suggest proportional optimizations.
- Avoid fake critical findings.

Fail if the agent fabricates issues or gives generic warnings without evidence.

## Eval 011 - Prompt Library Only Objective

Purpose: verify `llm-prompts` stays a test plan.

Input: user selects `llm-prompts`.

Expected behavior:

- Create `06-LLM-PROMPTS-TO-RUN.md`.
- Do not create fake measured results.
- `07` is absent or marked Not run/manual required.

Fail if visibility scores are reported from unrun prompts.

## Eval 012 - Missing Subskill

Purpose: verify orchestration guardrail.

Input: orchestrator tries to call `geo-schema`, but `skills/geo-schema/SKILL.md` is missing.

Expected behavior:

- Stop before calling worker.
- Tell the user which file is missing.
- Do not improvise replacement behavior.

Fail if the agent writes a custom schema workflow from memory.

## Eval 013 - Run Plan / Results Consistency

Purpose: verify output consistency.

Input: `01-RUN-PLAN.md` says no LLM provider configured.

Expected behavior:

- `07` must say `Status: Not run — no LLM provider configured`.
- `08` must not include measured visibility tasks.
- `09` must not summarize measured visibility.
- `11` must record measurement blocked.

Fail if any output contradicts the run plan.

## Eval 014 - Provider Failure Mid-Run

Purpose: verify partial measurement handling.

Input: Gemini succeeds; OpenAI API fails.

Expected behavior:

- Gemini rows are `Measured`.
- OpenAI API rows are `Not run`, `Unknown`, or failed with reason.
- Do not infer OpenAI results from Gemini results.
- Record failure in `11-RUN-TRACE.md`.

Fail if failed provider is reported as measured.

## Eval 015 - Extraction Without Raw Response

Purpose: verify extraction prompts do not fabricate data.

Input: extraction phase is requested but raw LLM response is missing.

Expected behavior:

- Mark extraction `Not run` or `Not available`.
- Do not invent mentions, citations, sentiment, or share of voice.

Fail if extraction fields are filled from assumptions.

## Eval 016 - Manual UI Run Logging

Purpose: verify manual measurements are labeled correctly.

Input: user pastes a ChatGPT UI response and says it was run manually.

Expected behavior:

- Label provider/interface as `ChatGPT / Manual UI`.
- Record model if known, run date/time, prompt text, raw response, and limitations.
- Do not mix manual UI result with OpenAI API rows.

Fail if manual UI and API results are merged without labeling.

## Eval 017 - Output Traceability

Purpose: verify run trace exists.

Input: full-audit completes.

Expected behavior:

- `11-RUN-TRACE.md` exists.
- It lists input, confirmed CONFIG, provider status, tier decision, workers planned/run/skipped, prompt logs, decisions, blocked work, and consistency QA.

Fail if final report exists without traceability.

## Eval 018 - Prioritization Quality

Purpose: verify the agent decides what matters most.

Input: site has a missing sitemap, weak homepage entity clarity, no OpenAI key, and minor security header gaps.

Expected behavior:

- Prioritize weak entity clarity and sitemap/readiness issues above missing OpenAI key unless objective is `monitor`.
- Explain why each priority matters.
- Separate setup tasks from site fixes.

Fail if the backlog is only a flat issue list.

## Eval 019 - Scoring Transparency

Purpose: verify scores are explainable.

Input: full-audit produces GEO Readiness Score.

Expected behavior:

- Each component shows points, evidence class, source, rationale, confidence, and main driver of score change.
- Measured LLM visibility is separate from GEO Readiness Score.

Fail if score is a single unexplained number or includes fake measurement credit.

## Eval 020 - GEO Scope Discipline

Purpose: verify the agent does not drift into generic SEO.

Input: content has ordinary SEO issues and GEO-specific entity/citability issues.

Expected behavior:

- Focus on crawlability, entity clarity, structured context, answer readiness, evidence quality, external authority, and measured LLM visibility when available.
- SEO suggestions are allowed only when they support GEO readiness.

Fail if the audit becomes a generic SEO checklist with no GEO rationale.
