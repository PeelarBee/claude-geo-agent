#!/usr/bin/env bash
set -euo pipefail

echo "Installing geo-agent for Codex / OpenAI Skills..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${HOME}/.agents/skills"
MAIN_SKILL_DIR="${SKILLS_DIR}/geo-agent"
REF_DIR="${MAIN_SKILL_DIR}/references"

mkdir -p "$SKILLS_DIR"
mkdir -p "$REF_DIR"

if [ ! -f "${ROOT_DIR}/skills/geo-agent/SKILL.md" ]; then
  echo "Missing skills/geo-agent/SKILL.md" >&2
  exit 1
fi

# Install every skill folder so Codex can discover the main skill and internal modules.
for skill_dir in "${ROOT_DIR}"/skills/*; do
  [ -d "$skill_dir" ] || continue
  name="$(basename "$skill_dir")"
  mkdir -p "${SKILLS_DIR}/${name}"
  cp -R "$skill_dir"/* "${SKILLS_DIR}/${name}/"
  echo "Installed skill: ${name}"
done

# Bundle support resources under the main geo-agent skill for portable reference.
copy_dir_contents() {
  src="$1"
  dest="$2"
  if [ -d "$src" ]; then
    mkdir -p "$dest"
    cp -R "$src"/* "$dest"/ 2>/dev/null || true
  fi
}

copy_dir_contents "${ROOT_DIR}/scripts" "${REF_DIR}/scripts"
copy_dir_contents "${ROOT_DIR}/templates" "${REF_DIR}/templates"
copy_dir_contents "${ROOT_DIR}/prompts" "${REF_DIR}/prompts"
copy_dir_contents "${ROOT_DIR}/agents" "${REF_DIR}/agents"

for doc in \
  AGENT.md \
  README.md \
  INSTALLATION.md \
  DOCUMENTATION.md \
  EVIDENCE-RULES.md \
  CLAIM-GUARDRAILS.md \
  RUN-LOG-SPEC.md \
  ORCHESTRATION.md \
  OUTPUT-CONTRACT.md \
  SCORING.md \
  LIMITATIONS.md \
  PROMPTS-INDEX.md \
  EVALS.md \
  NON-TECHNICAL-USER-GUIDE.md; do
  if [ -f "${ROOT_DIR}/${doc}" ]; then
    cp "${ROOT_DIR}/${doc}" "${REF_DIR}/${doc}"
  fi
done

if [ -d "${REF_DIR}/scripts" ]; then
  chmod +x "${REF_DIR}"/scripts/*.sh 2>/dev/null || true
fi

echo ""
echo "Done. Restart Codex to load the geo-agent skill."
echo "Try: Run a GEO audit for https://example.com"
echo ""
echo "Installed to: ${MAIN_SKILL_DIR}"
