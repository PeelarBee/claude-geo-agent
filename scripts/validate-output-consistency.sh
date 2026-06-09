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
require_file "06-LLM-PROMPTS-TO-RUN.md"
require_file "07-LLM-VISIBILITY-RESULTS.md"
require_file "08-BACKLOG.md"
require_file "09-FINAL-REPORT.md"
require_file "11-RUN-TRACE.md"

run_plan="$out/01-RUN-PLAN.md"
prompts="$out/06-LLM-PROMPTS-TO-RUN.md"
results="$out/07-LLM-VISIBILITY-RESULTS.md"
backlog="$out/08-BACKLOG.md"
final="$out/09-FINAL-REPORT.md"
trace="$out/11-RUN-TRACE.md"

if [ -f "$run_plan" ] && grep -Eiq 'full-audit|Objective:.*full' "$run_plan"; then
  if [ -f "$prompts" ]; then
    pass "Full audit includes 06 prompt plan"
  else
    fail "Full audit is missing 06 prompt plan"
  fi
fi

if [ -f "$prompts" ]; then
  for phrase in \
    'Starter Baseline' \
    'Brand Visibility' \
    'Category Visibility' \
    'Problem' \
    'Competitor' \
    'Citation' \
    'paste' \
    'fresh chat'; do
    if grep -Eiq "$phrase" "$prompts"; then
      pass "06 includes prompt pack element: $phrase"
    else
      warn "06 may be missing prompt pack element: $phrase"
    fi
  done

  if grep -Eiq 'copy.*prompt|paste.*response|paste.*back|Manual Prompt Mode|Manual UI' "$prompts"; then
    pass "06 includes copy/paste or Manual Prompt Mode instructions"
  else
    fail "06 does not clearly tell the user to copy prompts and paste responses back"
  fi

  if grep -Eiq '\bMeasured\b|Brand mentioned.*Yes|Verdict.*Win|Live LLM results collected' "$prompts"; then
    warn "06 may contain measurement language; verify prompts are not presented as results"
  fi
fi

if [ -f "$run_plan" ] && grep -Eiq 'no LLM provider|LLM provider.*Missing|Live LLM visibility measurement: Not available' "$run_plan"; then
  if [ -f "$results" ] && grep -Eq 'Status: Not run (--|—) no LLM provider configured|Status: Manual run required (--|—) prompt library generated only' "$results"; then
    pass "No-provider run plan agrees with 07 results"
  else
    fail "Run plan indicates no LLM provider, but 07 does not say Not run or Manual run required"
  fi
fi

if [ -f "$results" ] && grep -Eq 'Status: Not run (--|—) no LLM provider configured|Status: Manual run required (--|—) prompt library generated only' "$results"; then
  if grep -Eiq '\bMeasured\b|Live LLM results collected|Brand mentioned.*Yes|Verdict.*Win' "$results"; then
    fail "07 is Not run/manual required but appears to contain measured-result language"
  else
    pass "07 Not run/manual required file does not contain measured-result language"
  fi
fi

if [ -f "$results" ] && grep -Eiq 'OpenAI API|OpenAI model' "$results"; then
  if grep -Eiq 'ChatGPT UI|measured in ChatGPT|ChatGPT visibility' "$results"; then
    fail "OpenAI API results appear to be labeled as ChatGPT UI"
  else
    pass "OpenAI API boundary preserved in 07"
  fi
fi

if [ -f "$results" ] && grep -Eiq 'ChatGPT|Claude UI|Gemini UI|Perplexity UI|Copilot' "$results"; then
  if grep -Eiq 'Manual UI' "$results"; then
    pass "Manual chatbot results are labeled Manual UI"
  else
    warn "Chatbot UI appears in 07 without obvious Manual UI label"
  fi
fi

for file in "$run_plan" "$prompts" "$results" "$backlog" "$final" "$trace"; do
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
  for section in 'Readiness' 'Prompt' 'Measurement' 'Recommendations'; do
    if grep -Fq "$section" "$final"; then
      pass "Final report includes $section section/reference"
    else
      warn "Final report may be missing $section section/reference"
    fi
  done
fi

if [ -f "$trace" ]; then
  for phrase in 'Provider Capability Check' 'Measurement Mode' 'Tier Decision' 'Orchestration Checklist' 'Output Consistency Check'; do
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
