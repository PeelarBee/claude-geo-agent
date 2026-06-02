---
name: content-refresher
description: Revitalize declining or outdated content by detecting stale information, comparing against current top-ranking competitors, and producing a prioritized refresh brief. Works for own content, client content, and competitor analysis.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - WebFetch
  - Write
---

# Content Refresher Skill

## Purpose

Content decays. Stats get outdated, tools get deprecated, competitors publish better versions, and rankings drop. This skill audits existing content, detects decay signals, researches what's currently ranking, and produces a prioritized refresh brief with specific rewrite recommendations.

## Three Modes

### Mode A: Own Content / Client Content
Audit a URL owned by you or your client. Detect decay, compare against current top competitors, and produce a refresh brief.

### Mode B: Competitor Analysis
Audit a competitor's URL to find weaknesses, gaps, and opportunities to outrank it with a refreshed version.

### Mode C: Full Comparison
Audit your own URL head-to-head against a specific competitor URL to identify where you're losing and how to win.

---

## How to Use This Skill

Provide:
1. **Target URL** — the page to refresh (or the competitor page to analyze)
2. **Mode** — A (own/client), B (competitor), or C (comparison)
3. **Competitor URLs** (optional, for Mode A or C) — up to 3 competitor pages on the same topic

If no competitor URLs are provided, the skill will use Serper to find the top 5 currently ranking pages for the target topic and use those as comparison baseline.

---

## Step 1: Fetch and Parse Target Content

1. Use WebFetch to retrieve the target URL
2. Extract:
   - Page title and meta description
   - All headings (H1, H2, H3)
   - Full body text
   - All dates mentioned in content
   - All statistics and percentages
   - All tool names, software, and technology references
   - All external links and sources cited
   - Word count of main content
3. Note the URL structure, last-modified HTTP header if present

---

## Step 2: Content Decay Detection

Run each decay check against the extracted content:

### 2.1 Date Staleness
- Find all years mentioned in content (regex: `\b(20[0-9]{2})\b`)
- Flag any year older than 2 years as STALE
- Flag any year older than 1 year as WARNING
- Flag phrases like "this year", "recently", "new", "latest" without a year as VAGUE
- Check for copyright dates, "updated" dates, or publish dates in the page

**Decay signals:**
- "According to a 2022 study..." → STALE if current year is 2026
- "The best tools in 2023..." → STALE
- "Recently, X changed..." → VAGUE (no date anchor)

### 2.2 Statistics and Data Freshness
- Extract all statistics, percentages, dollar amounts, and counts
- Flag any stat attributed to a source older than 2 years
- Flag unattributed stats as UNVERIFIABLE
- Note stats that reference market conditions (prices, adoption rates, market size) as HIGH DECAY RISK — these change quickly

**Examples:**
- "73% of marketers use video (HubSpot 2022)" → STALE
- "The average CPL is $35" → UNVERIFIABLE (needs source + date)
- "AI tools market valued at $X billion" → HIGH DECAY RISK

### 2.3 Tool and Technology References
- Extract all tool names, platforms, software, and technology references
- Check for:
  - Tools that have been discontinued, rebranded, or acquired
  - Major version changes that affect described functionality
  - New market leaders that have displaced mentioned tools
  - Deprecated APIs, features, or methods

**Common decay patterns:**
- Recommending a tool that no longer exists or has a different name
- Describing features of a tool that changed significantly
- Missing newer tools that have become standard

### 2.4 Strategic Angle Decay
- Check if the content's core argument is still valid
- Look for:
  - Advice contradicted by current best practices
  - Recommendations based on algorithms, policies, or platforms that have changed
  - "Predictions" or "trends" sections that can now be evaluated
  - Case studies or examples using outdated data

### 2.5 Structural Completeness
- Identify questions the content does NOT answer that a reader would now expect
- Check if new subtopics have emerged since the content was written
- Flag missing sections that competitors now cover

---

## Step 3: Competitor Research via Serper

Use Serper (if available via MCP) or instruct the user to search manually:

**Search query to run:**
Extract the main topic/keyword from the target URL (use the H1 or title tag). Search for:
1. The exact target keyword — note top 5 organic results
2. "[keyword] [current year]" — find updated versions
3. "[keyword] guide [current year]" — find comprehensive alternatives

**For each top-ranking competitor page, note:**
- URL and domain authority signals (site age, brand recognition)
- Title and meta description
- Word count estimate
- Heading structure (H2s visible in SERP snippet or page)
- Publish/update date if visible
- Any featured snippets they own

**If WebFetch is available:**
Fetch the top 2-3 competitor pages and extract:
- All H2 headings (sections they cover that target page doesn't)
- First paragraph of each section (their angle)
- Any statistics or data points they cite
- Internal and external links

---

## Step 4: Gap Analysis

Compare target content vs. top competitors:

### 4.1 Topic Coverage Gaps
List sections/topics that competitors cover but target page doesn't.
Prioritize by: frequency (covered by 3+ competitors = HIGH priority gap).

### 4.2 Depth Gaps
Identify sections where competitors go deeper with:
- More specific examples
- Case studies or data
- Step-by-step breakdowns
- Visuals, tables, or comparisons

### 4.3 Freshness Advantage
Identify where target page can gain advantage by:
- Publishing more recent statistics
- Covering developments from the past 12 months
- Adding 2026-specific angles competitors haven't covered yet

### 4.4 Angle Gaps (Mode B/C only)
For competitor analysis: identify the competitor's weakest sections — places where their content is thin, generic, or outdated that your content can target.

---

## Step 5: Prioritization Framework

Score each refresh opportunity:

| Priority | Criteria | Action |
|---|---|---|
| **P1 — Critical** | Factually incorrect or dangerously outdated info | Fix immediately before publishing |
| **P2 — High** | Stats/dates older than 2 years, missing major topic sections | Fix in this refresh |
| **P3 — Medium** | Vague claims, tool references that changed, angle updates | Include if capacity allows |
| **P4 — Low** | Style improvements, better examples, structural tweaks | Future refresh |

---

## Step 6: Generate Refresh Brief

Output a file called `CONTENT-REFRESH-BRIEF.md`:

```markdown
# Content Refresh Brief: [Page Title]

**URL:** [URL]
**Mode:** [A / B / C]
**Analysis Date:** [Date]
**Overall Decay Score:** [1-10, where 10 = severely decayed]

---

## Executive Summary

[2-3 sentences: How decayed is this content? What's the biggest opportunity? What will refreshing this achieve?]

---

## Decay Signals Found

| Type | Finding | Priority |
|---|---|---|
| Date staleness | [specific finding] | P1/P2/P3 |
| Stale statistics | [specific finding] | P1/P2/P3 |
| Tool/tech decay | [specific finding] | P1/P2/P3 |
| Strategic decay | [specific finding] | P1/P2/P3 |

---

## Competitor Landscape

**Top ranking pages for [keyword]:**

1. [URL] — [key differentiator]
2. [URL] — [key differentiator]
3. [URL] — [key differentiator]

**Their strongest angle:** [1-2 sentences]
**Their biggest weakness:** [1-2 sentences — your opportunity]

---

## Sections to Add (Topic Gaps)

| Missing Section | Covered By | Priority |
|---|---|---|
| [H2 topic missing from target] | 3/3 competitors | High |
| [H2 topic missing from target] | 2/3 competitors | Medium |

---

## Sections to Update (Specific Rewrites)

### [Section heading]

**Current (outdated):**
> [quote the current problematic sentence/stat]

**Why it's stale:** [explanation]

**Suggested update:**
> [rewritten version with fresh angle, current date, or updated stat]

**Research needed:** [what to look up to complete this update]

---

## Quick Wins (Do First)

1. Update title tag to include [current year] — estimated +[X]% CTR lift
2. Replace [specific stat] with current data from [suggested source]
3. Add [missing section] — all top 3 competitors cover this
4. Update [tool name] references — tool was rebranded/acquired in [year]
5. Add publication/last-updated date to the page — trust signal for both users and AI

---

## Structural Improvements

- [ ] Add a comparison table for [X vs Y]
- [ ] Add a "TL;DR" or key takeaways box at the top
- [ ] Break [specific long section] into 2-3 shorter sections
- [ ] Add FAQ section covering: [list of questions competitors answer that this page doesn't]

---

## Estimated Refresh Scope

| Task | Time Estimate |
|---|---|
| Update statistics and dates | [X hours] |
| Add missing sections | [X hours] |
| Structural improvements | [X hours] |
| **Total** | **[X hours]** |

---

## Competitor-Specific Notes (Mode B/C only)

**If targeting [competitor URL]:**
- Their biggest gap: [specific weakness]
- The angle to beat them: [strategic recommendation]
- Word count to target: [N words — slightly more than competitor]
```

---

## Decay Score Reference

| Score | Meaning | Recommended Action |
|---|---|---|
| 9-10 | Severely decayed — multiple false/outdated claims | Full rewrite |
| 7-8 | Heavily decayed — major stats and sections outdated | Deep refresh (50%+ rewrite) |
| 5-6 | Moderately decayed — some stale data, missing sections | Standard refresh (25-40% update) |
| 3-4 | Mildly decayed — minor updates needed | Light refresh (10-20% update) |
| 1-2 | Fresh — content is current and competitive | Monitor, refresh in 6-12 months |
