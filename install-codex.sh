#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${CLAUDE_GEO_AGENT_REPO:-https://github.com/PeelarBee/claude-geo-agent.git}"
REPO_REF="${CLAUDE_GEO_AGENT_REF:-main}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || pwd)"

if [ ! -f "${ROOT_DIR}/skills/geo-agent/SKILL.md" ]; then
  if [ "${CLAUDE_GEO_AGENT_BOOTSTRAPPED:-}" = "1" ]; then
    echo "Missing skills/geo-agent/SKILL.md after download." >&2
    exit 1
  fi

  if ! command -v git >/dev/null 2>&1; then
    echo "git is required for one-line installation from GitHub." >&2
    echo "Alternative: download the repo ZIP, open the folder, then run: bash install-codex.sh" >&2
    exit 1
  fi

  tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/claude-geo-agent.XXXXXX")"
  echo "Downloading claude-geo-agent from ${REPO_URL} (${REPO_REF})..."
  git clone --depth 1 --branch "${REPO_REF}" "${REPO_URL}" "${tmp_dir}"
  CLAUDE_GEO_AGENT_BOOTSTRAPPED=1 bash "${tmp_dir}/install-codex.sh"
  exit $?
fi

echo "Installing geo-agent for Codex / OpenAI Skills..."

SKILLS_DIR="${HOME}/.agents/skills"
MAIN_SKILL_DIR="${SKILLS_DIR}/geo-agent"
REF_DIR="${MAIN_SKILL_DIR}/references"

mkdir -p "$SKILLS_DIR"
mkdir -p "$REF_DIR"

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
  QUICKSTART.md \
  INSTALLATION.md \
  CODEX.md \
  DOCUMENTATION.md \
  EVIDENCE-RULES.md \
  CLAIM-GUARDRAILS.md \
  RUN-LOG-SPEC.md \
  ORCHESTRATION.md \
  QUALITY-GATES.md \
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
echo "Try: @geo-agent"
echo "Or: Use geo-agent to run a GEO audit for https://example.com"
echo ""
echo "Installed to: ${MAIN_SKILL_DIR}"
