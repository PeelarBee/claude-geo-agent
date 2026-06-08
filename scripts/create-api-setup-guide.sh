#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <output-folder> <brand>" >&2
  exit 1
fi

out="$1"
brand="$2"
mkdir -p "$out"

cat > "$out/10-API-SETUP-GUIDE.md" <<EOF
# API Setup Guide: $brand

This guide explains what you need if you want a real GEO audit with live measurement.

## What You Can Do Without APIs

You can still run a useful readiness audit:

- crawlability and robots.txt checks
- sitemap checks
- llms.txt check and draft
- schema recommendations
- content citability/readiness review
- prompt library generation
- fix guide and backlog

What you cannot do without an LLM provider:

- measure whether the brand appears in LLM answers
- measure citations, sentiment, competitor mentions, or share of voice
- claim ChatGPT, Claude, Gemini, Perplexity, Groq, or Bing Copilot visibility

## Serper

Serper is recommended for search evidence.

It helps the agent find:

- search results for your brand
- competitor/source pages
- third-party mentions
- LinkedIn, YouTube, Reddit, Wikipedia, and directories when visible in search

Serper does not run LLM prompts.

If only Serper is connected, the audit can include search evidence, but live LLM visibility is still not measured.

## LLM Provider APIs

To measure real prompt-based visibility, connect at least one LLM provider API:

| Provider | What it measures | Important label |
|---|---|---|
| Gemini API | Gemini API/model responses | Gemini API, not necessarily Gemini UI |
| OpenAI API | OpenAI API/model responses | OpenAI API, not ChatGPT UI |
| Anthropic API | Anthropic API/model responses | Anthropic API / Claude API |
| Groq | Groq-hosted model responses | Groq + model name |
| Perplexity API | Perplexity API responses | Perplexity API |

## OpenAI API vs ChatGPT

OpenAI API and ChatGPT are not the exact same measurement surface.

If the audit runs with an OpenAI API key, the result should be labeled OpenAI API or OpenAI model.

It should not say ChatGPT unless ChatGPT UI was manually tested and logged separately.

## Manual Option

If you do not want to connect APIs, you can still use the prompt library manually:

1. Open 06-LLM-PROMPTS-TO-RUN.md.
2. Copy one prompt.
3. Paste it into ChatGPT, Claude, Gemini, Perplexity, or another tool.
4. Save the provider name, interface, model if visible, date/time, prompt text, and raw answer.
5. Label it Manual UI.
6. Do not mix manual results with API results unless both are clearly labeled.

## What The Agent Should Say Without LLM APIs

07-LLM-VISIBILITY-RESULTS.md should say:

Status: Not run — no LLM provider configured

## Recommended Simple Setup

For a non-technical user:

1. Add Serper for search evidence.
2. Add one LLM provider, ideally Gemini or Groq if cost is a concern.
3. Run full-audit.
4. Read 00-START-HERE.md first.
5. Use 03-FIX-GUIDE.md and 08-BACKLOG.md to prioritize implementation.
6. Re-run monitor after fixes if an LLM provider is configured.
EOF

printf 'Created API setup guide: %s\n' "$out/10-API-SETUP-GUIDE.md"
