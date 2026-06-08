---
name: geo-schema
description: Audits existing JSON-LD/schema markup, checks Organization, WebSite, Service, Product, Article, FAQPage, BreadcrumbList, Person, LocalBusiness, sameAs, and proposes ready-to-implement schema with explicit validation status. Use for schema objectives and full audits.
allowed-tools:
  - Bash
  - WebFetch
  - Read
  - Write
---

# GEO Schema Skill

## Purpose

Assess whether structured data helps machines understand the brand, page type, services/products, authorship, FAQs, breadcrumbs, and entity relationships.

Schema can improve machine readability. It does not guarantee ranking, citation, inclusion, or LLM visibility.

## Inputs

- Confirmed CONFIG
- Domain and target pages
- Objective
- Output folder

## Required Checks

1. Fetch raw HTML with Bash/curl where possible.
2. Extract `application/ld+json` blocks.
3. Identify schema types present and missing.
4. Check JSON syntax locally when possible.
5. Label validation status as:
   - `Validated` when a parser/validator actually ran and passed
   - `Reviewed only` when the agent reviewed schema but no validator ran
   - `Not run` when validation did not happen
6. Recommend missing schema by page type.
7. Produce ready-to-implement JSON-LD based only on confirmed CONFIG and observed page facts.

## Recommended Schema By Page Type

| Page type | Recommended schema |
|---|---|
| Homepage | Organization, WebSite, WebPage |
| Service page | Service, WebPage, BreadcrumbList |
| Product page | Product, Offer when applicable |
| Blog/article | Article, Person/Organization, BreadcrumbList |
| FAQ section | FAQPage |
| Local business | LocalBusiness or relevant subtype |
| About page | Organization or Person when applicable |

## Evidence Rules

- Existing schema found in HTML is `Observed`.
- Syntax validation is `Measured` only as a local technical validation, not LLM visibility.
- Proposed schema is a `Generated artifact` and recommendations are usually `Inferred`.
- Do not say schema is valid unless validation actually ran.
- Do not claim schema will cause AI citation or visibility.

## Outputs

Update:

- `05-SCHEMA.md`
- `02-TECHNICAL-GEO-AUDIT.md` structured data score rationale
- `03-FIX-GUIDE.md` for implementation steps
- `08-BACKLOG.md` for schema tasks
- `11-RUN-TRACE.md` with pages checked and validation status

## Required Worker Summary

```md
## geo-schema Summary

- Pages checked:
- Existing schema:
- Missing schema:
- Validation status:
- Proposed JSON-LD:
- Files updated:
- Next actions:
```
