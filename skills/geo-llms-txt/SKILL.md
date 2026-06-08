---
name: geo-llms-txt
description: Checks, audits, creates, or improves llms.txt as a supplemental machine-readable context file for GEO readiness. Use for llms-txt objectives, quick checks, and full audits.
allowed-tools:
  - Bash
  - WebFetch
  - Read
  - Write
---

# GEO llms.txt Skill

## Purpose

Create or improve `llms.txt` so answer engines and AI crawlers have a concise, factual map of the brand and its important public pages.

`llms.txt` is supplemental context. It does not guarantee discovery, ranking, citation, inclusion, or visibility.

## Inputs

- Confirmed CONFIG
- Domain
- Key page URLs
- Objective
- Output folder

## Required Checks

1. Check `https://[domain]/llms.txt` with Bash/curl.
2. Record HTTP status and evidence date.
3. If present, audit quality:
   - clear brand description
   - absolute canonical URLs
   - important pages included
   - factual page descriptions
   - contact/attribution info when available
   - no invented claims
4. If missing or weak, draft an improved file based only on fetched page evidence and confirmed CONFIG.
5. For JS-heavy sites, explain that llms.txt is useful supplemental context but not a replacement for crawlable HTML, schema, sitemap, and public proof.

## Evidence Rules

- HTTP status and existing file content are `Observed` or `Not available`.
- Generated llms.txt is a `Generated artifact`.
- Recommendations are `Inferred`.
- Do not claim the file guarantees visibility or citation.

## Outputs

Update:

- `04-LLMS-TXT.md`
- `02-TECHNICAL-GEO-AUDIT.md` llms.txt status
- `03-FIX-GUIDE.md` implementation instructions
- `08-BACKLOG.md` for upload/fix tasks
- `11-RUN-TRACE.md` with current file status and draft status

## Required Output Warning

Include this warning in `04-LLMS-TXT.md`:

`llms.txt is a supplemental context file. It does not guarantee AI visibility, ranking, citation, or inclusion.`

## Required Worker Summary

```md
## geo-llms-txt Summary

- Current llms.txt status:
- Quality issues:
- Draft created:
- Evidence boundary:
- Files updated:
- Next actions:
```
