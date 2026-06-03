---
name: answer-readiness-content-audit
description: Audits existing content for freshness, evidence quality, entity clarity, source support, FAQ/prompt coverage, trust signals, and answer-engine readiness. Produces a prioritized content improvement brief without claiming ranking gains, CTR lift, AI citations, or measured LLM visibility.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - WebFetch
  - Write
---

# Answer Readiness Content Audit Skill

## Purpose

Existing content can become stale, vague, unsupported, hard to parse, or incomplete for answer-engine interpretation. This skill audits whether a page is fresh, clear, well-evidenced, source-supported, entity-aware, structured for extraction, and ready to be used in answer-style contexts.

It produces a prioritized content improvement brief with specific rewrite and evidence recommendations. It does not claim ranking gains, CTR lift, AI citations, or measured LLM visibility.

## Scope Boundary

This skill is not a traditional SEO ranking refresh workflow. It does not predict rankings, traffic, CTR, AI citations, or LLM visibility. It audits whether content is fresh, clear, well-evidenced, structured, and suitable for answer-engine interpretation.

Search Evidence may be used to compare publicly visible content and source coverage, but Search Evidence is not LLM visibility measurement.

## Evidence Rules

Approved Evidence Status values:

Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown

- On-page content extracted from the target URL is `Observed`.
- Serper or search results are `Search Evidence`.
- Competitor/source gap interpretation is usually `Inferred`.
- LLM visibility is `Not run` unless provider prompts were actually executed and logged.
- Rankings, CTR, and traffic impact must not be marked `Measured` unless analytics/search performance data exists.

Every major finding must include:

- Evidence Status
- Evidence Source
- Evidence Source Type: Crawl / Rendered HTML / Search API / Manual check / Local file / Generated artifact / Not available
- Evidence Date / Run Date
- Confidence
- Priority
- Impact
- Effort
- Recommended Action
- Acceptance Criteria

## Modes

### Mode A: Own Content / Client Content

Audit a URL owned by you or your client. Assess freshness, evidence quality, entity clarity, FAQ/prompt coverage, trust signals, extractability, and answer-engine readiness.

### Mode B: Competitor / Source Analysis

Audit a competitor or source URL to identify content clarity, evidence, structure, and trust-signal differences. Use findings as comparison context, not as proof of ranking, traffic, or LLM visibility.

### Mode C: Full Comparison

Audit your own URL head-to-head against a specific competitor/source URL to identify answer-readiness gaps and practical content improvements.

## How to Use This Skill

Provide:

1. **Target URL** — the page to audit
2. **Mode** — A (own/client), B (competitor/source), or C (comparison)
3. **Competitor/source URLs** (optional, for Mode A or C) — up to 3 pages on the same topic

If no competitor/source URLs are provided, the skill may use Serper or manual search to find competitor or source pages observed in search results at run time and use those as a comparison baseline.

Search results vary by date, query, location, personalization, and index freshness. Presence in search results does not prove LLM use or citation.

## Step 1: Fetch and Parse Target Content

1. Use WebFetch to retrieve the target URL.
2. Extract:
   - Page title and meta description
   - All headings (H1, H2, H3)
   - Full body text
   - All dates mentioned in content
   - All statistics and percentages
   - All named entities, tools, software, and technology references
   - All external links and sources cited
   - Word count of main content as a diagnostic signal only
   - FAQ sections, question-style headings, and answer-style sections
   - Trust signals: authorship, review date, case studies, customer proof, credentials, testimonials, certifications, media mentions
3. Note the URL structure, canonical URL, publish/update date, and last-modified HTTP header if present.

## Step 2: Freshness And Evidence Quality Detection

Run each check against the extracted content.

### 2.1 Date Freshness

- Find all years mentioned in content (regex: `\b(20[0-9]{2})\b`).
- Flag any year older than 2 years as STALE.
- Flag any year older than 1 year as WARNING.
- Flag phrases like "this year", "recently", "new", "latest" without a year as VAGUE.
- Check for copyright dates, "updated" dates, publish dates, and review dates.

Examples:

- "According to a 2022 study..." -> STALE if current year is 2026.
- "The best tools in 2023..." -> STALE.
- "Recently, X changed..." -> VAGUE because it has no date anchor.

### 2.2 Statistics And Data Freshness

- Extract all statistics, percentages, dollar amounts, and counts.
- Flag any stat attributed to a source older than 2 years.
- Flag unattributed stats as UNVERIFIABLE.
- Note stats that reference market conditions, prices, adoption rates, or market size as HIGH FRESHNESS RISK because these may change quickly.

Examples:

- "73% of marketers use video (HubSpot 2022)" -> STALE.
- "The average CPL is $35" -> UNVERIFIABLE unless a source and date are provided.
- "AI tools market valued at $X billion" -> HIGH FRESHNESS RISK.

### 2.3 Tool And Technology References

- Extract all tool names, platforms, software, and technology references.
- Check for:
  - Tools that have been discontinued, rebranded, or acquired
  - Major version changes that affect described functionality
  - Newer relevant tools or standards that may need to be acknowledged
  - Deprecated APIs, features, or methods

### 2.4 Strategic And Source Support Freshness

- Check whether the content's core argument is still valid.
- Look for:
  - Advice contradicted by current best practices
  - Recommendations based on policies, tools, or platforms that have changed
  - "Predictions" or "trends" sections that can now be evaluated
  - Case studies or examples using outdated data
  - Claims without evidence, sources, examples, or named proof

### 2.5 Structural Completeness And Extractability

- Identify questions the content does not answer that a reader or answer engine would reasonably expect.
- Check if new subtopics have emerged since the content was written.
- Flag missing answer-style sections, clear definitions, concise summaries, tables, source citations, FAQs, and step-by-step explanations.
- Check whether important claims are easy to extract without surrounding context.

## Step 3: Competitor / Source Research Via Search Evidence

Use Serper if available, or instruct the user to search manually.

Search query suggestions:

1. The main topic from the target URL (use the H1 or title tag).
2. "[topic] [current year]" for updated source coverage.
3. "[topic] guide [current year]" for comprehensive alternatives.
4. "[topic] FAQ" for question coverage.
5. "[topic] statistics" for source and proof coverage.

For each competitor or source page observed in search results at run time, note:

- URL and source context
- Title and meta description
- Heading structure visible from the page
- Publish/update date if visible
- Evidence and source support
- FAQ or answer-style coverage
- Trust signals and author/source transparency

If WebFetch is available, fetch the top 2-3 comparison pages and extract:

- All H2 headings
- First paragraph of each major section
- Statistics or data points they cite
- Internal and external links
- FAQ/prompt-style coverage
- Entity and source clarity signals

Search results vary by date, query, location, personalization, and index freshness. Presence in search results does not prove LLM use or citation.

## Step 4: GEO Gap Analysis

Compare target content against observed page evidence and Search Evidence.

### 4.1 Topic Coverage Gaps

List sections/topics that comparison pages cover but the target page does not.

### 4.2 Depth Gaps

Identify sections where comparison pages go deeper with:

- More specific examples
- Case studies or data
- Step-by-step breakdowns
- Visuals, tables, or comparisons
- Clear definitions or answer-first summaries

### 4.3 Freshness Gaps

Identify where the target page needs:

- More recent statistics
- Updated examples
- Current tool/platform names
- Stronger date anchors
- A visible publication or review date

### 4.4 Evidence / Source Gaps

Identify:

- Unsupported claims
- Missing citations or source links
- Outdated sources
- Missing customer proof or case evidence
- Missing named entities, definitions, or concrete examples

### 4.5 Entity Clarity Gaps

Identify whether the content clearly explains:

- Who the brand is
- What category it belongs to
- Who it serves
- What problem it solves
- What outcomes it supports
- Where it operates
- Which products/services are relevant

### 4.6 FAQ / Prompt Coverage Gaps

Identify missing:

- FAQs
- Question-style headings
- Direct answers to likely user prompts
- Comparison questions
- Problem-aware questions
- Local or market-specific questions when relevant

### 4.7 Answer-Style Section Gaps

Identify missing:

- Short direct answer blocks
- Summary boxes
- Definitions
- Tables
- Step-by-step instructions
- "What to know" or "Key takeaways" sections

### 4.8 Trust Signal Gaps

Identify missing:

- Author/reviewer information
- Last updated/reviewed date
- Case studies
- Testimonials
- Customer examples
- Credentials
- Certifications
- Media mentions
- Relevant third-party proof

### 4.9 Extractability Gaps

Identify sections that are hard to quote, parse, or reuse because they are:

- Too vague
- Too long
- Missing clear headings
- Dependent on surrounding context
- Visually embedded without text equivalents
- Unsupported by sources or examples

## Step 5: Prioritization Framework

Score each improvement opportunity:

| Priority | Criteria | Action |
|---|---|---|
| **P1 — Critical** | Factually incorrect, dangerously outdated, unsupported core claim, or key content inaccessible | Fix immediately before publishing |
| **P2 — High** | Stale stats/dates, missing major answer sections, weak entity clarity, missing proof for important claims | Fix in this update |
| **P3 — Medium** | Vague claims, changed tools, missing examples, FAQ/prompt gaps, extractability issues | Include if capacity allows |
| **P4 — Low** | Style improvements, better examples, structural polish | Future update |

## Step 6: Generate Answer Readiness Brief

Output a file called `CONTENT-ANSWER-READINESS-BRIEF.md`:

```markdown
# Content Answer Readiness Brief: [Page Title]

## Objective

Audit existing content for freshness, evidence quality, entity clarity, source support, FAQ/prompt coverage, trust signals, and answer-engine readiness.

## Metadata

**URL:** [URL]
**Mode:** [A / B / C]
**Analysis Date:** [Date]
**Domain:** [domain]
**Tools/APIs used:** [WebFetch / Serper / manual search / local checks]
**Tools/APIs not configured:** [missing tools/APIs]

## Run Summary

**What was run:**
- [check/tool/source]

**What was not run:**
- [check/tool/source and reason]

**Assumptions:**
- [assumption]

**Limitations:**
- Search Evidence is not LLM visibility measurement.
- This audit does not predict rankings, traffic, CTR, AI citations, or LLM visibility.

## Answer Readiness Content Score

**Score:** [1-10]

This score is diagnostic. It is not a ranking prediction, traffic forecast, CTR estimate, LLM visibility score, or AI citation prediction.

## Executive Summary

[2-3 sentences: What is the content's current answer readiness? What are the biggest evidence, freshness, entity clarity, or structure gaps?]

## Evidence Freshness Findings

| Finding | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Confidence | Priority | Impact | Effort | Recommended Action | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|---|
| [finding] | Observed / Measured / Search Evidence / Inferred / Not run / Not available / Unknown | [source] | Crawl / Rendered HTML / Search API / Manual check / Local file / Generated artifact / Not available | [date/time] | High / Medium / Low | Critical / High / Medium / Low | High / Medium / Low | High / Medium / Low | [action] | [criteria] |

## Entity Clarity Findings

[Findings using the required evidence fields.]

## Source / Proof Findings

[Findings using the required evidence fields.]

## FAQ / Prompt Coverage Findings

[Findings using the required evidence fields.]

## Competitor / Source Coverage Comparison

Search results vary by date, query, location, personalization, and index freshness. Presence in search results does not prove LLM use or citation.

| Source URL | Evidence Status | Evidence Source Type | Observed Coverage | Gaps Compared To Target | Confidence |
|---|---|---|---|---|---|
| [URL] | Search Evidence / Observed / Inferred | Search API / Crawl / Rendered HTML / Manual check | [coverage] | [gap] | High / Medium / Low |

## Priority Fixes

| Priority | Fix | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Impact | Effort | Recommended Action | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|
| Critical / High / Medium / Low | [fix] | [status] | [source] | [type] | [date/time] | High / Medium / Low | High / Medium / Low | [action] | [criteria] |

## Backlog

| Priority | Task | Type | Evidence Status | Evidence Source | Evidence Source Type | Evidence Date / Run Date | Impact | Effort | Owner | Status | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Critical / High / Medium / Low | [task] | content / evidence / entity / FAQ / trust / technical | [status] | [source] | [type] | [date/time] | High / Medium / Low | High / Medium / Low | [owner] | Open | [criteria] |

## Next Actions

1. [Action]
2. [Action]
3. [Action]
```

## Score Reference

| Score | Meaning | Recommended Action |
|---|---|---|
| 9-10 | Strong answer readiness — fresh, specific, well-evidenced, clear entity signals | Monitor and refine |
| 7-8 | Good answer readiness — useful content with focused gaps | Targeted update |
| 5-6 | Moderate answer readiness — some stale data, missing proof, or unclear sections | Standard update |
| 3-4 | Weak answer readiness — multiple clarity, evidence, freshness, or extractability gaps | Deep update |
| 1-2 | Poor answer readiness — outdated, vague, unsupported, or hard to parse | Full rewrite |

Scores are diagnostic readiness scores only.

## Quick Wins

- Update title/meta only when it improves clarity, specificity, and freshness. Any CTR impact must be validated through analytics or testing.
- Replace stale or unsupported statistics with current sourced data.
- Add or update a visible publication/review date when appropriate.
- Add answer-first summary blocks for key questions.
- Add FAQ sections covering observed question gaps.
- Add source links, proof points, case examples, or trust signals for important claims.
- Improve headings, tables, and section structure for content extractability.

Do not invent CTR percentages.

## Prohibited Claims

This skill must not:

- Claim content updates will improve rankings.
- Claim content updates will improve CTR unless analytics/testing evidence exists.
- Claim search results are LLM visibility.
- Claim Serper is an LLM provider.
- Claim updated content will be cited by AI systems.
- Claim FAQs, freshness, schema, or llms.txt guarantee AI answer inclusion.
- Claim competitor search presence is permanent.
- Treat word count as a ranking factor or goal by itself.
- Claim measured LLM visibility unless LLM provider prompts were executed and logged.

## Required Fallback Language

When Serper/search evidence was used:

`Search evidence was collected, but this is not LLM visibility measurement.`

When no LLM provider was run:

`Status: Not run — no LLM visibility measurement was performed for this content audit.`

When a claim/stat/tool cannot be verified:

`Status: Needs verification — insufficient evidence available.`
