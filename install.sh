#!/usr/bin/env bash
set -euo pipefail

echo "Installing claude-geo-agent..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
SUPPORT_DIR="${CLAUDE_DIR}/geo-agent"

mkdir -p "${CLAUDE_DIR}/agents"
mkdir -p "${CLAUDE_DIR}/skills"
mkdir -p "${SUPPORT_DIR}/scripts"
mkdir -p "${SUPPORT_DIR}/templates"
mkdir -p "${SUPPORT_DIR}/prompts"

if [ -d "${ROOT_DIR}/agents" ]; then
  for agent in "${ROOT_DIR}"/agents/*.md; do
    [ -e "$agent" ] || continue
    cp "$agent" "${CLAUDE_DIR}/agents/"
    echo "Installed agent: $(basename "$agent")"
  done
fi

if [ -d "${ROOT_DIR}/skills" ]; then
  for skill_dir in "${ROOT_DIR}"/skills/*; do
    [ -d "$skill_dir" ] || continue
    name="$(basename "$skill_dir")"
    mkdir -p "${CLAUDE_DIR}/skills/${name}"
    cp -R "$skill_dir"/* "${CLAUDE_DIR}/skills/${name}/"
    echo "Installed skill: ${name}"
  done
fi

copy_dir_contents() {
  src="$1"
  dest="$2"
  if [ -d "$src" ]; then
    mkdir -p "$dest"
    cp -R "$src"/* "$dest"/ 2>/dev/null || true
  fi
}

copy_dir_contents "${ROOT_DIR}/scripts" "${SUPPORT_DIR}/scripts"
copy_dir_contents "${ROOT_DIR}/templates" "${SUPPORT_DIR}/templates"
copy_dir_contents "${ROOT_DIR}/prompts" "${SUPPORT_DIR}/prompts"

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
    cp "${ROOT_DIR}/${doc}" "${SUPPORT_DIR}/${doc}"
  fi
done

if [ -d "${SUPPORT_DIR}/scripts" ]; then
  chmod +x "${SUPPORT_DIR}"/scripts/*.sh 2>/dev/null || true
fi

echo ""
echo "Done. Restart Claude Code to activate the GEO agent."
echo "Invoke with: @geo-agent"
echo ""
echo "Optional API keys:"
echo "  SERPER_API_KEY       Search evidence only"
echo "  GEMINI_API_KEY       Gemini API measurement"
echo "  GOOGLE_API_KEY       Gemini API measurement"
echo "  GROQ_API_KEY         Groq measurement"
echo "  OPENAI_API_KEY       OpenAI API measurement, not ChatGPT UI"
echo "  ANTHROPIC_API_KEY    Anthropic API measurement"
echo "  PERPLEXITY_API_KEY   Perplexity API measurement"
