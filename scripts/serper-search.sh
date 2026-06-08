#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <query> [gl] [hl]" >&2
  exit 1
fi

: "${SERPER_API_KEY:?SERPER_API_KEY is required}"

query="$1"
gl="${2:-us}"
hl="${3:-en}"
run_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

query_json=$(python3 -c 'import json,sys; print(json.dumps(sys.argv[1]))' "$query")

body=$(cat <<EOF
{"q":$query_json,"gl":"$gl","hl":"$hl"}
EOF
)

response=$(curl -sS https://google.serper.dev/search \
  -H "X-API-KEY: $SERPER_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$body")

cat <<EOF
{
  "provider": "Serper",
  "interface": "API",
  "run_date": "$run_date",
  "query": $query_json,
  "gl": "$gl",
  "hl": "$hl",
  "evidence_status": "Search Evidence",
  "evidence_source_type": "Search API",
  "measurement_boundary": "Serper search evidence is not LLM visibility measurement.",
  "raw_response": $(printf '%s' "$response" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')
}
EOF
