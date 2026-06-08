#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 3 ]; then
  echo "Usage: $0 <template-file> <config-file> <output-file>" >&2
  echo "Config format: KEY=value lines. Keys replace {{KEY}} and {{key}}." >&2
  exit 1
fi

template="$1"
config="$2"
output="$3"

if [ ! -f "$template" ]; then
  echo "Template not found: $template" >&2
  exit 1
fi

if [ ! -f "$config" ]; then
  echo "Config not found: $config" >&2
  exit 1
fi

cp "$template" "$output.tmp"

while IFS='=' read -r key value; do
  case "$key" in
    ''|'#'*) continue ;;
  esac
  clean_key=$(printf '%s' "$key" | tr -d ' ')
  upper=$(printf '%s' "$clean_key" | tr '[:lower:]' '[:upper:]')
  lower=$(printf '%s' "$clean_key" | tr '[:upper:]' '[:lower:]')
  value=${value%$'\r'}
  safe=$(printf '%s' "$value" | sed 's/[&/]/\\&/g')
  sed -i.bak "s/{{$upper}}/$safe/g; s/{{$lower}}/$safe/g; s/{{$clean_key}}/$safe/g" "$output.tmp"
  rm -f "$output.tmp.bak"
done < "$config"

cat > "$output" <<'EOF'
This file is the prompt library, not the measurement result.

Measured LLM answer results belong in `07-LLM-VISIBILITY-RESULTS.md` only after these prompts are executed through configured LLM provider APIs or documented manual UI runs.

EOF
cat "$output.tmp" >> "$output"
rm -f "$output.tmp"

# Convert unresolved runtime placeholders into explicit manual fields instead of leaving template syntax.
# CONFIG placeholders should already be replaced. Runtime fields such as {{response}} become [PASTE_RESPONSE_HERE].
sed -i.bak -E 's/\{\{[[:space:]]*response[[:space:]]*\}\}/[PASTE_RAW_LLM_RESPONSE_HERE]/g; s/\{\{[[:space:]]*raw_response[[:space:]]*\}\}/[PASTE_RAW_LLM_RESPONSE_HERE]/g; s/\{\{[[:space:]]*model_response[[:space:]]*\}\}/[PASTE_RAW_LLM_RESPONSE_HERE]/g' "$output"
rm -f "$output.bak"

if grep -E '\{\{[A-Za-z0-9_ -]+\}\}' "$output" >/dev/null; then
  echo "Warning: unresolved placeholders remain in $output" >&2
  grep -Eo '\{\{[A-Za-z0-9_ -]+\}\}' "$output" | sort -u >&2
fi

printf 'Instantiated prompt library: %s\n' "$output"
