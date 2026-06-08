#!/usr/bin/env bash
set -u

json=false
if [ "${1:-}" = "--json" ]; then
  json=true
fi

is_set() {
  var="$1"
  eval "value=\${$var:-}"
  [ -n "$value" ]
}

status_var() {
  if is_set "$1"; then
    printf 'Configured'
  else
    printf 'Missing'
  fi
}

status_any() {
  for var in "$@"; do
    if is_set "$var"; then
      printf 'Configured'
      return 0
    fi
  done
  printf 'Missing'
}

serper=$(status_var SERPER_API_KEY)
gemini=$(status_any GEMINI_API_KEY GOOGLE_API_KEY)
groq=$(status_var GROQ_API_KEY)
openai=$(status_var OPENAI_API_KEY)
anthropic=$(status_var ANTHROPIC_API_KEY)
perplexity=$(status_var PERPLEXITY_API_KEY)

llm_count=0
for s in "$gemini" "$groq" "$openai" "$anthropic" "$perplexity"; do
  [ "$s" = "Configured" ] && llm_count=$((llm_count + 1))
done

if [ "$llm_count" -gt 0 ]; then
  llm_status="Configured"
else
  llm_status="Missing"
fi

if [ "$json" = true ]; then
  cat <<EOF
{
  "search_provider": {
    "serper": "$serper"
  },
  "llm_providers": {
    "gemini": "$gemini",
    "groq": "$groq",
    "openai_api": "$openai",
    "anthropic_api": "$anthropic",
    "perplexity_api": "$perplexity"
  },
  "any_llm_provider": "$llm_status",
  "notes": [
    "Serper is search evidence only, not LLM measurement.",
    "OpenAI API results are not ChatGPT UI results unless ChatGPT UI was separately measured and logged."
  ]
}
EOF
  exit 0
fi

cat <<EOF
# GEO Provider Status

Do not print secret values. Status is Configured or Missing only.

| Provider | Status | Used for |
|---|---|---|
| Serper | $serper | Search Evidence only; not LLM measurement |
| Gemini API | $gemini | LLM measurement only if prompts run |
| Groq | $groq | LLM measurement only if prompts run |
| OpenAI API | $openai | OpenAI API/model results; not ChatGPT UI |
| Anthropic API | $anthropic | Anthropic API / Claude API results |
| Perplexity API | $perplexity | Perplexity API results |

Any LLM provider configured: $llm_status
EOF
