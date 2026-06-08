#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <output-folder>" >&2
  exit 1
fi

out="$1"
report="$out/09-FINAL-REPORT.md"

if [ ! -d "$out" ]; then
  echo "Output folder not found: $out" >&2
  exit 1
fi

cat > "$report" <<EOF
# GEO Final Report

This final report compiles the audit outputs. It must preserve the separation between readiness, search evidence, measured LLM visibility, and recommendations.

EOF

append_section() {
  file="$1"
  title="$2"
  if [ -f "$out/$file" ]; then
    {
      printf '\n---\n\n## %s\n\n' "$title"
      sed -n '1,220p' "$out/$file"
    } >> "$report"
  else
    {
      printf '\n---\n\n## %s\n\n' "$title"
      printf 'Status: Not available - %s was not generated.\n' "$file"
    } >> "$report"
  fi
}

append_section "00-START-HERE.md" "Start Here"
append_section "01-RUN-PLAN.md" "Run Plan"
append_section "02-TECHNICAL-GEO-AUDIT.md" "Readiness Audit"
append_section "07-LLM-VISIBILITY-RESULTS.md" "LLM Visibility Results"
append_section "03-FIX-GUIDE.md" "Fix Guide"
append_section "08-BACKLOG.md" "Backlog"
append_section "10-API-SETUP-GUIDE.md" "API Setup Guide"
append_section "11-RUN-TRACE.md" "Run Trace"

cat >> "$report" <<'EOF'

---

## Final Claim QA

Before using this report, confirm:

| Check | Status |
|---|---|
| Readiness is separate from measured visibility | Review required |
| Search evidence is not labeled LLM visibility | Review required |
| OpenAI API is not labeled ChatGPT UI | Review required |
| Unrun phases are marked Not run | Review required |
| Recommendations are tied to evidence | Review required |

EOF

printf 'Assembled final report: %s\n' "$report"
