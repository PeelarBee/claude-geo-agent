# GEO Visibility Score /100

The GEO Visibility Score is a diagnostic readiness score, not an absolute prediction of AI answer inclusion.

Every score must include:

- Rationale
- Evidence class: Observed / Measured / Inferred / Not run / Not available / Unknown
- Evidence source
- Confidence
- Major gaps affecting the score

## 1. Crawlability & Access - 15 pts

Criteria:

- `robots.txt` does not block important content
- Important pages are accessible
- Sitemap exists and is discoverable
- Important content is available in initial or rendered HTML
- Key pages are not accidentally noindexed

## 2. Entity Clarity - 20 pts

Criteria:

- Clear business category
- Clear ICP/audience
- Clear services/products
- Clear geography/market
- Clear About/company information
- Clear `sameAs` or external entity links

## 3. Structured Data - 15 pts

Criteria:

- Organization schema
- WebSite schema
- Service/Product schema where relevant
- FAQ schema where relevant
- `sameAs` links
- Valid JSON-LD

## 4. AI Citability - 20 pts

Criteria:

- Answer-ready content
- Clear definitions
- Concrete claims
- Proof points
- Case studies/testimonials
- Original insights/data
- Structured FAQs
- Content that can be quoted/cited without ambiguity

## 5. External Authority Signals - 15 pts

Criteria:

- Brand appears in search results for relevant queries
- Third-party mentions exist
- LinkedIn/company presence exists
- Relevant directory/listing presence exists
- Reddit/YouTube/Wikipedia presence where applicable
- External signals align with the brand/category

## 6. Measurement Readiness - 15 pts

Criteria:

- Monitoring prompt library generated
- LLM provider configured
- Results separated from prompt plan
- Baseline stored
- Prompt groups documented
- Refresh cadence defined

## Score Interpretation

- 0-39 = Poor GEO readiness
- 40-59 = Basic readiness, significant gaps
- 60-74 = Moderate readiness, needs focused improvements
- 75-89 = Strong readiness, needs optimization
- 90-100 = Excellent readiness, monitor and refine

## Scoring Rules

- Do not award Measured LLM visibility credit unless prompts were actually run through a configured LLM provider.
- If no LLM provider is configured, Measurement Readiness can still receive credit for prompt library, baseline structure, and cadence, but measured-results criteria must be `Not run`.
- Search results may contribute to External Authority Signals, not LLM visibility measurement.
- Missing evidence should lower confidence, not be treated as proof of absence unless the source was checked and returned no usable result.
- Every recommendation tied to a low score must include evidence, confidence, priority, impact, effort, and next action.

