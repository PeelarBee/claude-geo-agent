#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <output-folder>" >&2
  exit 1
fi

out="$1"
failures=0
warnings=0

fail() {
  failures=$((failures + 1))
  printf 'FAIL: %s\n' "$1"
}

warn() {
  warnings=$((warnings + 1))
  printf 'WARN: %s\n' "$1"
}

pass() {
  printf 'PASS: %s\n' "$1"
}

require_file() {
  file="$out/$1"
  if [ -f "$file" ]; then
    pass "$1 exists"
  else
    fail "$1 is missing"
  fi
}

require_file "01-RUN-PLAN.md"
require_file "07-LLM-VISIBILITY-RESULTS.md"
require_file "08-BACKLOG.md"
require_file "09-FINAL-REPORT.md"
require_file "11-RUN-TRACE.md"

run_plan="$out/01-RUN-PLAN.md"
results="$out/07-LLM-VISIBILITY-RESULTS.md"
backlog="$out/08-BACKLOG.md"
final="$out/09-FINAL-REPORT.md"
trace="$out/11-RUN-TRACE.md"

if [ -f "$run_plan" ] && grep -Eiq 'no LLM provider|LLM provider.*Missing|Live LLM visibility measurement: Not available' "$run_plan"; then
  if [ -f "$results" ] && grep -Fq 'Status: Not run — no LLM provider configured' "$results"; then
    pass "No-provider run plan agrees with 07 results"
  else
    fail "Run plan indicates no LLM provider, but 07 does not say Not run"
  fi
fi

if [ -f "$results" ] && grep -Fq 'Status: Not run — no LLM provider configured' "$results"; then
  if grep -Eiq '\bMeasured\b|Live LLM results collected|Brand mentioned.*Yes|Verdict.*Win' "$results"; then
    fail "07 is Not run but appears to contain measured-result language"
  else
    pass "07 Not run file does not contain measured-result language"
  fi
fi

if [ -f "$results" ] && grep -Eiq 'OpenAI API|OpenAI model' "$results"; then
  if grep -Eiq 'ChatGPT UI|measured in ChatGPT|ChatGPT visibility' "$results"; then
    fail "OpenAI API results appear to be labeled as ChatGPT UI"
  else
    pass "OpenAI API boundary preserved in 07"
  fi
fi

for file in "$run_plan" "$results" "$backlog" "$final" "$trace"; do
  [ -f "$file" ] || continue
  if grep -Eiq 'Serper.*(LLM visibility|Measured|ChatGPT|Claude|Gemini).*measurement' "$file"; then
    fail "Possible Serper-as-LLM claim in $(basename "$file")"
  fi
  if grep -Eiq 'guarantee(s|d)? (AI visibility|LLM visibility|citation|ranking|inclusion)' "$file"; then
    fail "Guarantee claim found in $(basename "$file")"
  fi
  if grep -Eiq 'prompt(s)? (were )?generated.*(visibility|measured|result)' "$file"; then
    warn "Check generated-prompt wording in $(basename "$file")"
  fi
done

if [ -f "$final" ]; then
  for section in 'Readiness' 'Measurement' 'Recommendations'; do
    if grep -Fq "$section" "$final"; then
      pass "Final report includes $section section/reference"
    else
      warn "Final report may be missing $section section/reference"
    fi
  done
fi

if [ -f "$trace" ]; then
  for phrase in 'Provider Capability Check' 'Tier Decision' 'Orchestration Checklist' 'Output Consistency Check'; do
    if grep -Fq "$phrase" "$trace"; then
      pass "Run trace includes $phrase"
    else
      warn "Run trace may be missing $phrase"
    fi
  done
fi

printf '\nSummary: %s failure(s), %s warning(s)\n' "$failures" "$warnings"

if [ "$failures" -gt 0 ]; then
  exit 1
fi
