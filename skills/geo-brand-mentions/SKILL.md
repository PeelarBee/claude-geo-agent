---
name: geo-brand-mentions
description: Collects external brand authority and source-discovery evidence from search surfaces, Serper, third-party profiles, directories, Reddit, YouTube, LinkedIn, Wikipedia when applicable, and competitor/source results. Use for brand mentions, external authority, search evidence, and full audits.
allowed-tools:
  - Bash
  - WebFetch
  - Read
  - Write
---

# GEO Brand Mentions Skill

## Purpose

Assess external authority and source-discovery signals that may help answer engines understand the brand as an entity.

This skill produces Search Evidence and inferred readiness recommendations. It does not measure LLM visibility.

## Inputs

- Confirmed CONFIG
- Brand name
- Domain
- Category
- Geography
- Competitors if supplied
- Serper/search availability
- Output folder

## Required Boundary

Serper and search results are not LLM provider results.

If Serper/search was used and no LLM provider was run, include:

`Serper search evidence was collected, but this is not LLM visibility measurement.`

## Checks

When Serper or another search provider is configured, search for:

1. Brand name
2. Brand + category
3. Brand + reviews
4. Brand + alternatives
5. Brand + competitors
6. Category + geography
7. Competitor/source mentions
8. LinkedIn company page
9. YouTube official channel or notable mentions
10. Reddit discussions when relevant
11. Wikipedia when applicable, without penalizing brands that are not Wikipedia-eligible
12. Industry directories such as G2, Capterra, Trustpilot, Clutch, niche directories, associations, or local listings when relevant

When no search provider is configured, mark search-backed checks `Not run` and provide manual search prompts.

## Evidence Rules

- Serper/search findings are `Search Evidence`.
- Directly fetched third-party pages may be `Observed` for the content of that page.
- Strategic conclusions about authority or entity clarity are `Inferred`.
- Do not report ChatGPT, Claude, Gemini, Perplexity, Groq, OpenAI, Anthropic, or Bing Copilot visibility from search results.

## Outputs

Update:

- `02-TECHNICAL-GEO-AUDIT.md` external authority section
- `03-FIX-GUIDE.md` for external authority fixes
- `08-BACKLOG.md` for profile/listing/source tasks
- `11-RUN-TRACE.md` with search queries and blocked searches

## Prioritization

High:

- Brand cannot be found for exact brand queries
- External profiles conflict with core category, geography, or name
- Competitor/source results dominate core category queries while brand is absent from all relevant search evidence

Medium:

- Missing or thin LinkedIn/company profile
- Inconsistent naming across directories
- Weak third-party proof or review presence

Low:

- Optional directory expansion or social alignment improvements

## Required Worker Summary

```md
## geo-brand-mentions Summary

- Search provider status:
- Queries run:
- External signals found:
- Gaps:
- Evidence boundary:
- Files updated:
- Next actions:
```
