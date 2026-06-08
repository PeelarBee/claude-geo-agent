# GEO Readiness Score /100

The GEO Readiness Score is a diagnostic readiness score. It is not a prediction of AI answer inclusion and it is not measured LLM visibility.

Measured LLM visibility must be reported separately as `LLM Visibility Measurement Status`.

## Required Score Transparency

Every score must show:

- Component points earned
- Component max points
- Evidence class
- Evidence source
- Evidence source type
- Evidence date or run date
- Confidence
- Main positive drivers
- Main negative drivers
- What would raise the score
- What would lower confidence
- Priority created by the score

Use this structure:

```md
| Component | Points | Evidence Status | Evidence Source Type | Evidence Source | Evidence Date / Run Date | Confidence | Positive Drivers | Negative Drivers | What Changes The Score |
|---|---:|---|---|---|---|---|---|---|---|
```

## Component Weights

| Component | Points | What it measures |
|---|---:|---|
| Crawlability & Access | 15 | Can crawlers and answer engines discover important public content? |
| Entity Clarity | 20 | Is the brand/category/ICP/problem/outcome/geography clear? |
| Structured Data | 15 | Does schema help machines understand the entity and page type? |
| AI Citability | 20 | Is content answer-ready, extractable, specific, and evidence-backed? |
| External Authority Signals | 15 | Do search/third-party surfaces support the brand as an entity/source? |
| Measurement Readiness | 15 | Is the brand set up to measure prompt-based visibility over time? |

## Scoring Anchors

Use these anchors for each component:

- 0-25% of component points: missing, blocked, inaccessible, or unusable
- 26-50%: present but weak, vague, incomplete, or low confidence
- 51-75%: mostly present with meaningful gaps
- 76-100%: strong, specific, evidence-backed, and actionable

Do not assign high scores without clear evidence.

## 1. Crawlability & Access - 15 pts

Positive drivers:

- Important pages return successful status codes
- `robots.txt` does not block key public content
- Sitemap exists and is discoverable
- Important content is available in raw or rendered HTML
- Key pages are not accidentally noindexed

Negative drivers:

- Important pages blocked or unavailable
- Missing or undiscoverable sitemap
- Heavy client-side rendering risk for core content
- noindex/canonical issues on important pages
- AI crawler directives block important access without intentional policy

Priority guidance:

- Critical when key public/commercial content is blocked, unavailable, or noindexed.
- High when sitemap/raw HTML/rendering risk may limit discovery.

## 2. Entity Clarity - 20 pts

Positive drivers:

- Clear business category
- Clear ICP/audience
- Clear services/products
- Clear geography/market
- Clear About/company information
- Consistent name, category, and sameAs/entity links

Negative drivers:

- Vague positioning
- Missing category or target customer
- Missing geography for local/regional services
- Conflicting names or categories across pages
- Unsupported or generic claims

Priority guidance:

- High when homepage or service pages do not clearly explain what the business is and who it serves.

## 3. Structured Data - 15 pts

Positive drivers:

- Organization/WebSite schema on homepage
- Service/Product schema where relevant
- Article/FAQ/Breadcrumb schema where relevant
- sameAs links to authoritative profiles
- JSON-LD syntax reviewed or validated

Negative drivers:

- Missing Organization or service schema
- Malformed JSON-LD
- Schema contradicts visible content
- Validation not run or failed

Validation status must be one of:

- Validated
- Reviewed only
- Not run

Do not claim schema is valid unless validation actually ran.

## 4. AI Citability - 20 pts

Positive drivers:

- Answer-first sections
- Clear definitions
- Self-contained paragraphs
- Specific claims with evidence
- Case studies, testimonials, credentials, or proof
- FAQs and prompt-style headings
- Tables, lists, and extractable structure

Negative drivers:

- Vague claims
- Unsupported superlatives
- Outdated or unattributed stats
- Missing direct answers
- Long context-dependent sections
- Weak proof/trust signals

Priority guidance:

- High when core buyer questions are not answered directly or claims lack proof.

## 5. External Authority Signals - 15 pts

Positive drivers:

- Brand appears in relevant search results
- Consistent third-party mentions
- LinkedIn/company profile exists
- Relevant directories/listings exist
- Reviews, videos, discussions, associations, media, or niche source presence
- Wikipedia only when applicable and eligible

Negative drivers:

- Brand absent from exact brand search evidence
- Conflicting third-party profile data
- Competitors dominate relevant source/search surfaces
- No third-party corroboration for important claims

Rules:

- Search evidence can contribute to this component.
- Search evidence must not be treated as measured LLM visibility.
- Do not penalize legitimate businesses for lacking Wikipedia when Wikipedia is not applicable.

## 6. Measurement Readiness - 15 pts

Positive drivers:

- Prompt library generated
- Prompt groups documented
- Provider setup exists
- Results are separated from prompt plan
- Baseline structure exists
- Refresh cadence defined
- Run trace records provider/prompt metadata

Negative drivers:

- No LLM provider configured
- No baseline structure
- Prompts and results mixed together
- No run trace
- Provider naming ambiguity, especially OpenAI API vs ChatGPT UI

Rules:

- Measurement Readiness is not measured LLM visibility performance.
- If no LLM provider is configured, the prompt library and baseline structure can earn readiness credit, but measured-results criteria are `Not run`.

## LLM Visibility Measurement Status

Report separately from the GEO Readiness Score.

Allowed statuses:

- Status: Live LLM results collected
- Status: Not run — no LLM provider configured
- Status: Manual run required — prompt library generated only

Provider labels must be accurate:

- OpenAI API is not ChatGPT UI.
- Serper is not an LLM provider.
- Bing Copilot is Manual / Not run unless documented.

## Score Interpretation

- 0-39: Poor GEO readiness
- 40-59: Basic readiness, significant gaps
- 60-74: Moderate readiness, needs focused improvements
- 75-89: Strong readiness, needs optimization
- 90-100: Excellent readiness, monitor and refine

## Prioritization Rules

The agent must not only list issues. It must decide what matters most.

Prioritize higher when an issue:

1. Blocks crawlability or access to important public content.
2. Prevents the brand/entity/category from being understood.
3. Prevents direct answers or citations from being extracted.
4. Makes measured visibility impossible or untrustworthy.
5. Causes contradictions across outputs or claims.

Setup tasks, such as adding an LLM provider, should be separated from site/content fixes unless the selected objective is `monitor`.

## Scoring Guardrails

- Do not award measured visibility credit unless prompts were actually run.
- Do not use Serper/search evidence as LLM visibility.
- Do not label OpenAI API measurement as ChatGPT UI.
- Do not turn generated prompts into results.
- Missing evidence lowers confidence.
- Checked-and-missing evidence can lower score.
- Unknown evidence should not be treated as proof of absence.
