---
name: geo-citability
description: Audits pages and content blocks for AI citation readiness, answer-first structure, self-containment, entity clarity, evidence support, freshness, extractability, FAQ coverage, and trust signals. Use for citability, content readiness, and full audits.
allowed-tools:
  - WebFetch
  - Bash
  - Read
  - Write
---

# GEO Citability Skill

## Purpose

Evaluate whether website content is clear, factual, structured, self-contained, and evidence-backed enough to be useful in answer-style contexts.

This is a readiness audit. It does not prove that any LLM will cite the page.

## Inputs

- Confirmed CONFIG
- Target URL(s)
- Objective
- Output folder
- Competitors if supplied or search-discovered

## Scoring Dimensions

Score each important page or content block:

| Dimension | Weight | Checks |
|---|---:|---|
| Answer-first clarity | 25 | Opens with a direct answer or definition |
| Self-containment | 20 | Understandable without surrounding context |
| Entity clarity | 20 | Brand/category/ICP/problem/outcome are clear |
| Evidence support | 15 | Claims have sources, proof, dates, examples, or named evidence |
| Structure/extractability | 15 | Headings, lists, tables, FAQs, concise sections |
| Freshness | 5 | Dates and claims are current or clearly anchored |

Scores are diagnostic readiness scores only.

## Required Checks

1. Fetch target pages.
2. Extract H1/H2/H3, title, meta description, visible body copy, FAQ sections, proof points, dates, stats, testimonials, case studies, and external links.
3. Identify answer-ready passages.
4. Identify vague, unsupported, stale, or hard-to-extract passages.
5. Rewrite weak passages using answer-first structure when useful.
6. Map each issue to evidence status, priority, impact, effort, and acceptance criteria.

## Evidence Rules

- On-page content is `Observed`.
- Search or competitor/source comparisons are `Search Evidence` when collected from search surfaces.
- Recommendations about likely answer-engine usefulness are `Inferred`.
- Do not claim measured citations, ranking gains, CTR lift, or LLM visibility.

## Outputs

Update:

- `02-TECHNICAL-GEO-AUDIT.md` for citability/readiness score rationale
- `03-FIX-GUIDE.md` for rewrites and content fixes
- `08-BACKLOG.md` for prioritized content work
- `11-RUN-TRACE.md` with pages checked and skipped

## Prioritization

Critical:

- Core page cannot explain what the business does
- Important claims are unsupported or potentially misleading
- Target content is inaccessible or empty

High:

- Weak entity clarity on homepage/service pages
- Missing proof for commercial claims
- Missing direct answers for core buyer questions

Medium:

- FAQ gaps
- Long or vague sections that need extractable summaries
- Stale dates or weak source support

Low:

- Style or formatting improvements

## Required Worker Summary

```md
## geo-citability Summary

- Pages checked:
- Highest-risk content gaps:
- Citation-ready passages:
- Rewrites proposed:
- Files updated:
- Next actions:
```
