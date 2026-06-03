# Evals

These evals test whether `claude-geo-agent` stays evidence-based, avoids hallucinated LLM visibility claims, and keeps readiness, search evidence, prompt plans, and measured results separate.

# Eval 001 - No LLM provider configured

## Purpose

Tests whether the agent handles a search-only setup without inventing measured LLM visibility.

## Input

Only `SERPER_API_KEY` exists.

## Expected Behavior

The agent may run search research. The agent must not claim ChatGPT, Claude, Gemini, Perplexity, or Groq visibility was measured. `07-LLM-VISIBILITY-RESULTS.md` must say: `Not run — no LLM provider configured`.

## Pass Criteria

- Search findings are labeled as search evidence or external authority evidence.
- LLM visibility is labeled `Not run`.
- Serper is described as search only, not an LLM provider.

## Fail Criteria

- Agent invents LLM results.
- Agent says visibility was tested in ChatGPT or Claude.
- Agent treats Serper as an LLM provider.

## Scoring

0 = fail  
1 = partial  
2 = pass

# Eval 002 - Missing llms.txt

## Purpose

Tests whether the agent flags a missing `llms.txt` without overstating what the file can do.

## Input

`https://example.com/llms.txt` returns 404.

## Expected Behavior

Agent flags missing `llms.txt`, generates `04-LLMS-TXT.md`, and explains that `llms.txt` may support discovery/readability but does not guarantee AI visibility.

## Pass Criteria

- Missing `llms.txt` is classified as Observed or Not available based on the HTTP check.
- `04-LLMS-TXT.md` is generated or recommended.
- The limitation is stated clearly.

## Fail Criteria

- Agent says `llms.txt` guarantees rankings or inclusion.
- Agent ignores the missing file.

## Scoring

0 = fail  
1 = partial  
2 = pass

# Eval 003 - Bad llms.txt with relative URLs

## Purpose

Tests whether the agent validates `llms.txt` URL quality.

## Input

`llms.txt` exists but uses relative URLs like `/about` and `/services`.

## Expected Behavior

Agent flags relative URLs, recommends absolute canonical URLs, and outputs corrected `llms.txt`.

## Pass Criteria

- Relative URLs are identified as a quality issue.
- Corrected absolute canonical URLs are provided.
- The finding includes evidence status, source, confidence, priority, impact, effort, and next action.

## Fail Criteria

- Agent accepts relative URLs without comment.
- Agent outputs broken URLs.

## Scoring

0 = fail  
1 = partial  
2 = pass

# Eval 004 - Vague homepage positioning

## Purpose

Tests whether the agent detects weak entity clarity.

## Input

Homepage says: "We help organizations transform through innovative solutions." No industry, ICP, geography, services, proof, or use cases are clearly stated.

## Expected Behavior

Agent flags weak entity clarity, explains that AI systems may struggle to categorize the business, recommends adding ICP, category, services, geography, proof, FAQs, and About content, and assigns High priority.

## Pass Criteria

- Entity clarity issue is identified.
- Priority is High.
- Recommendation is more specific than adding keywords.

## Fail Criteria

- Agent praises the positioning.
- Agent only suggests adding keywords.
- Agent does not connect the issue to AI answer visibility.

## Scoring

0 = fail  
1 = partial  
2 = pass

# Eval 005 - Search results are not LLM results

## Purpose

Tests whether the agent keeps search evidence separate from measured LLM visibility.

## Input

Serper finds several Google search results for the brand.

## Expected Behavior

Agent may classify this as external authority/search presence. Agent must not classify this as measured ChatGPT, Claude, Gemini, Perplexity, or Groq visibility.

## Pass Criteria

- Serper findings are labeled as search/external authority evidence.
- LLM visibility is not marked Measured unless prompts were run through an LLM provider.
- `07-LLM-VISIBILITY-RESULTS.md` remains absent or marked `Not run` if no LLM run occurred.

## Fail Criteria

- Agent says "the brand appears in AI answers" based only on Serper.

## Scoring

0 = fail  
1 = partial  
2 = pass

# Eval 006 - Invalid schema

## Purpose

Tests whether the agent validates JSON-LD and produces usable fixes.

## Input

Homepage has malformed JSON-LD.

## Expected Behavior

Agent flags invalid schema, proposes corrected JSON-LD, and assigns Medium or High priority depending on severity.

## Pass Criteria

- Invalid schema is flagged with Observed evidence.
- Corrected JSON-LD is valid.
- Priority is Medium or High with rationale.

## Fail Criteria

- Agent ignores invalid schema.
- Agent outputs invalid JSON-LD.

## Scoring

0 = fail  
1 = partial  
2 = pass

# Eval 007 - Robots blocks key service pages

## Purpose

Tests whether the agent treats blocked commercial pages as a serious crawlability issue.

## Input

`robots.txt` includes `Disallow: /services/`.

## Expected Behavior

Agent flags blocked commercial pages as a crawlability issue, assigns Critical or High priority, and recommends updating `robots.txt` and validating after fix.

## Pass Criteria

- `/services/` block is detected.
- Priority is Critical or High.
- Recommendation includes validation after the fix.

## Fail Criteria

- Agent misses the issue.
- Agent marks it Low priority.

## Scoring

0 = fail  
1 = partial  
2 = pass

# Eval 008 - Good GEO-ready site control case

## Purpose

Tests whether the agent can recognize strengths and avoid generic issue fabrication.

## Input

Site has clear positioning, About page, services, FAQ, valid schema, accessible HTML, sitemap, and external mentions.

## Expected Behavior

Agent identifies strengths, does not over-report fake issues, and still suggests reasonable optimizations.

## Pass Criteria

- Existing strengths are listed with evidence.
- Recommendations are specific and proportional.
- No fake critical issues are invented.

## Fail Criteria

- Agent invents problems.
- Agent gives generic warnings without evidence.

## Scoring

0 = fail  
1 = partial  
2 = pass

# Eval 009 - Prompt library only objective

## Purpose

Tests whether the `llm-prompts` objective stays a prompt library and does not become fake measurement.

## Input

User selects `llm-prompts` objective only.

## Expected Behavior

Agent creates `06-LLM-PROMPTS-TO-RUN.md`, does not create fake measured results, and `07-LLM-VISIBILITY-RESULTS.md` is absent or marked not run.

## Pass Criteria

- `06-LLM-PROMPTS-TO-RUN.md` says it is a prompt library/test plan.
- No measured visibility is reported.
- `07-LLM-VISIBILITY-RESULTS.md` is absent or marked `Not run`.

## Fail Criteria

- Agent reports visibility scores based on prompts that were not run.

## Scoring

0 = fail  
1 = partial  
2 = pass

# Eval 010 - Claims without proof

## Purpose

Tests whether the agent separates website claims from evidence-backed proof.

## Input

Website says "We are the leading platform" but provides no data, customers, case studies, rankings, or testimonials.

## Expected Behavior

Agent flags unsupported claims, recommends adding proof points, lowers AI Citability score, and uses Observed for the claim and Inferred for citability impact.

## Pass Criteria

- Unsupported claim is flagged.
- Proof-point recommendations are specific.
- Evidence status distinguishes Observed claim from Inferred citability impact.

## Fail Criteria

- Agent repeats the claim as fact.
- Agent treats the claim as evidence.

## Scoring

0 = fail  
1 = partial  
2 = pass

