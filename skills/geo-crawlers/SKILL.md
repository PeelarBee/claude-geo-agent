---
name: geo-crawlers
description: Checks GEO crawlability and technical access signals including robots.txt, AI crawler directives, sitemap discovery, static files, rendering risk, security headers, noindex/canonical signals, and disallowed-route leakage. Use for readiness audits, quick checks, crawler checks, and full audits.
allowed-tools:
  - Bash
  - WebFetch
  - Read
  - Write
---

# GEO Crawlers Skill

## Purpose

Audit whether important site content can be reached, discovered, and interpreted by crawlers and answer-engine retrieval systems.

This is a readiness check. It does not measure LLM visibility.

## Inputs

- Confirmed CONFIG
- Domain / website URL
- Objective
- Output folder
- Provider/tool status from the orchestrator

## Required Checks

Use Bash/curl for static files. Do not use WebFetch to verify plain text files.

Check:

1. Homepage HTTP status and redirect target
2. `robots.txt` status and content
3. AI crawler directives for GPTBot, OAI-SearchBot, ChatGPT-User, ClaudeBot, PerplexityBot, Google-Extended, CCBot, Bytespider, Applebot-Extended, Amazonbot
4. Sitemap discovery from `/sitemap.xml` and `Sitemap:` directives in robots.txt
5. `llms.txt`, `security.txt`, and `humans.txt` status
6. Raw HTML availability of important content
7. SPA / client-side rendering risk markers
8. JSON-LD presence
9. noindex/canonical signals when visible
10. Basic HTTPS/security headers
11. Disallowed-route leakage when routes are listed in robots.txt

## Evidence Rules

- Direct HTTP, HTML, robots.txt, sitemap, and local static checks are `Observed`.
- A blocked check is `Not run`.
- A file returning 404 is `Not available`.
- A crawler risk inferred from SPA markers is `Inferred` unless raw/rendered content was compared.
- Do not label any crawler finding as `Measured` LLM visibility.

## Outputs

Update:

- `02-TECHNICAL-GEO-AUDIT.md`
- `03-FIX-GUIDE.md` when a crawler/access fix is needed
- `08-BACKLOG.md` for prioritized technical tasks
- `11-RUN-TRACE.md` with checks run and blocked checks

## Prioritization

Critical:

- Important public content blocked by robots.txt
- Important commercial/content pages not reachable
- Site unavailable or redirect loop
- noindex on key pages

High:

- Sitemap missing or undiscoverable
- Important content only available after client-side rendering
- Key AI crawlers blocked without intentional policy
- Disallowed routes return 200 for sensitive paths

Medium:

- Missing security headers
- Missing supplemental files
- Thin raw HTML but rendered content may exist

Low:

- Non-critical metadata polish

## Required Worker Summary

Return findings in this shape:

```md
## geo-crawlers Summary

- Ran:
- Blocked:
- Evidence tier:
- Critical findings:
- High findings:
- Files updated:
- Next actions:
```
