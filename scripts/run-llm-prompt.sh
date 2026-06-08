#!/usr/bin/env bash
set -euo pipefail

provider=""
model=""
prompt_file=""
prompt_text=""

while [ $# -gt 0 ]; do
  case "$1" in
    --provider) provider="${2:-}"; shift 2 ;;
    --model) model="${2:-}"; shift 2 ;;
    --prompt-file) prompt_file="${2:-}"; shift 2 ;;
    --prompt) prompt_text="${2:-}"; shift 2 ;;
    *) echo "Unknown argument: $1" >&2; exit 1 ;;
  esac
done

if [ -z "$provider" ]; then
  echo "Missing --provider" >&2
  exit 1
fi

if [ -n "$prompt_file" ]; then
  if [ ! -f "$prompt_file" ]; then
    echo "Prompt file not found: $prompt_file" >&2
    exit 1
  fi
  prompt_text=$(cat "$prompt_file")
fi

if [ -z "$prompt_text" ]; then
  echo "Missing --prompt or --prompt-file" >&2
  exit 1
fi

run_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

json_escape() {
  python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}

prompt_json=$(printf '%s' "$prompt_text" | json_escape)

case "$provider" in
  openai)
    : "${OPENAI_API_KEY:?OPENAI_API_KEY is required for provider openai}"
    model="${model:-gpt-4o-mini}"
    body=$(cat <<EOF
{"model":"$model","messages":[{"role":"user","content":$prompt_json}],"temperature":0}
EOF
)
    response=$(curl -sS https://api.openai.com/v1/chat/completions \
      -H "Authorization: Bearer $OPENAI_API_KEY" \
      -H "Content-Type: application/json" \
      -d "$body")
    answer=$(printf '%s' "$response" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("choices", [{}])[0].get("message", {}).get("content", ""))')
    interface="API"
    provider_label="OpenAI API"
    ;;
  anthropic)
    : "${ANTHROPIC_API_KEY:?ANTHROPIC_API_KEY is required for provider anthropic}"
    model="${model:-claude-3-5-haiku-latest}"
    body=$(cat <<EOF
{"model":"$model","max_tokens":1200,"temperature":0,"messages":[{"role":"user","content":$prompt_json}]}
EOF
)
    response=$(curl -sS https://api.anthropic.com/v1/messages \
      -H "x-api-key: $ANTHROPIC_API_KEY" \
      -H "anthropic-version: 2023-06-01" \
      -H "Content-Type: application/json" \
      -d "$body")
    answer=$(printf '%s' "$response" | python3 -c 'import json,sys; d=json.load(sys.stdin); print("\n".join([c.get("text","") for c in d.get("content",[]) if c.get("type")=="text"]))')
    interface="API"
    provider_label="Anthropic API"
    ;;
  gemini)
    key="${GEMINI_API_KEY:-${GOOGLE_API_KEY:-}}"
    if [ -z "$key" ]; then
      echo "GEMINI_API_KEY or GOOGLE_API_KEY is required for provider gemini" >&2
      exit 1
    fi
    model="${model:-gemini-1.5-flash}"
    body=$(cat <<EOF
{"contents":[{"parts":[{"text":$prompt_json}]}],"generationConfig":{"temperature":0}}
EOF
)
    response=$(curl -sS "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$key" \
      -H "Content-Type: application/json" \
      -d "$body")
    answer=$(printf '%s' "$response" | python3 -c 'import json,sys; d=json.load(sys.stdin); print("\n".join([p.get("text","") for c in d.get("candidates",[]) for p in c.get("content",{}).get("parts",[])]))')
    interface="API"
    provider_label="Gemini API"
    ;;
  groq)
    : "${GROQ_API_KEY:?GROQ_API_KEY is required for provider groq}"
    model="${model:-llama-3.1-8b-instant}"
    body=$(cat <<EOF
{"model":"$model","messages":[{"role":"user","content":$prompt_json}],"temperature":0}
EOF
)
    response=$(curl -sS https://api.groq.com/openai/v1/chat/completions \
      -H "Authorization: Bearer $GROQ_API_KEY" \
      -H "Content-Type: application/json" \
      -d "$body")
    answer=$(printf '%s' "$response" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("choices", [{}])[0].get("message", {}).get("content", ""))')
    interface="API"
    provider_label="Groq"
    ;;
  perplexity)
    : "${PERPLEXITY_API_KEY:?PERPLEXITY_API_KEY is required for provider perplexity}"
    model="${model:-sonar}"
    body=$(cat <<EOF
{"model":"$model","messages":[{"role":"user","content":$prompt_json}],"temperature":0}
EOF
)
    response=$(curl -sS https://api.perplexity.ai/chat/completions \
      -H "Authorization: Bearer $PERPLEXITY_API_KEY" \
      -H "Content-Type: application/json" \
      -d "$body")
    answer=$(printf '%s' "$response" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("choices", [{}])[0].get("message", {}).get("content", ""))')
    interface="API"
    provider_label="Perplexity API"
    ;;
  *)
    echo "Unsupported provider: $provider" >&2
    exit 1
    ;;
esac

answer_json=$(printf '%s' "$answer" | json_escape)
raw_json=$(printf '%s' "$response" | json_escape)

cat <<EOF
{
  "provider": "$provider_label",
  "interface": "$interface",
  "model": "$model",
  "run_date": "$run_date",
  "fresh_context": "Yes - single prompt API request",
  "evidence_status": "Measured",
  "evidence_source_type": "LLM API",
  "prompt": $prompt_json,
  "response_summary": $answer_json,
  "raw_response": $raw_json,
  "notes": "Provider result only. OpenAI API is not ChatGPT UI unless ChatGPT UI was separately measured and logged."
}
EOF
