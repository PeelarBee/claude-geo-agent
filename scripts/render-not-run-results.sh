#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <output-folder> <brand> [serper-status]" >&2
  exit 1
fi

out="$1"
brand="$2"
serper_status="${3:-Missing}"
mkdir -p "$out"

warning=""
if [ "$serper_status" = "Configured" ]; then
  warning="Serper search evidence was collected, but this is not LLM visibility measurement."
fi

cat > "$out/07-LLM-VISIBILITY-RESULTS.md" <<EOF
# LLM Visibility Results: $brand

Status: Not run — no LLM provider configured

## Provider Coverage

| Provider | Status | Notes |
|---|---|---|
| Serper | $serper_status | Search only; not an LLM result provider |
| Gemini API | Not configured | Not run |
| OpenAI API | Not configured | Not run; OpenAI API is not ChatGPT UI |
| Anthropic API | Not configured | Not run |
| Perplexity API | Not configured | Not run |
| Groq | Not configured | Not run |
| Bing Copilot | Manual / Not run | No automatic provider configured unless explicitly supported |

## Measurement Boundary

Search results, competitor research, external authority checks, and generated prompts are not LLM answer visibility results. This file only reports measured LLM visibility when prompts were executed through configured LLM providers or documented manual UI runs.

$warning

## Prompt Groups

| Group | Prompts run | Verdict |
|---|---:|---|
| Branded | 0 | Not run |
| Category | 0 | Not run |
| Problem-aware | 0 | Not run |
| Comparison | 0 | Not run |
| Transactional | 0 | Not run |
| Local / geo | 0 | Not run |
| Educational | 0 | Not run |
| Alternative language | 0 | Not run |

## Next Step

Configure at least one LLM provider API or document manual UI runs before reporting measured LLM visibility.
EOF

printf 'Rendered not-run LLM visibility results: %s\n' "$out/07-LLM-VISIBILITY-RESULTS.md"
