#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <output-folder>" >&2
  exit 1
fi

out="$1"
mkdir -p "$out"

files=(
  "00-START-HERE.md"
  "01-RUN-PLAN.md"
  "02-TECHNICAL-GEO-AUDIT.md"
  "03-FIX-GUIDE.md"
  "04-LLMS-TXT.md"
  "05-SCHEMA.md"
  "06-LLM-PROMPTS-TO-RUN.md"
  "07-LLM-VISIBILITY-RESULTS.md"
  "08-BACKLOG.md"
  "09-FINAL-REPORT.md"
  "10-API-SETUP-GUIDE.md"
  "11-RUN-TRACE.md"
)

for f in "${files[@]}"; do
  path="$out/$f"
  if [ ! -e "$path" ]; then
    printf '# %s\n\nStatus: Draft\n' "${f%.md}" > "$path"
  fi
done

printf 'Created GEO output skeleton: %s\n' "$out"
