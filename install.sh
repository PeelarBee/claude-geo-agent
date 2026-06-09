#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${CLAUDE_GEO_AGENT_REPO:-https://github.com/PeelarBee/claude-geo-agent.git}"
REPO_REF="${CLAUDE_GEO_AGENT_REF:-main}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || pwd)"

if [ ! -f "${ROOT_DIR}/agents/geo-agent.md" ]; then
  if [ "${CLAUDE_GEO_AGENT_BOOTSTRAPPED:-}" = "1" ]; then
    echo "Missing agents/geo-agent.md after download." >&2
    exit 1
  fi

  if ! command -v git >/dev/null 2>&1; then
    echo "git is required for one-line installation from GitHub." >&2
    echo "Alternative: download the repo ZIP, open the folder, then run: bash install.sh" >&2
    exit 1
  fi

  tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/claude-geo-agent.XXXXXX")"
  echo "Downloading claude-geo-agent from ${REPO_URL} (${REPO_REF})..."
  git clone --depth 1 --branch "${REPO_REF}" "${REPO_URL}" "${tmp_dir}"
  CLAUDE_GEO_AGENT_BOOTSTRAPPED=1 bash "${tmp_dir}/install.sh"
  exit $?
fi

echo "Installing claude-geo-agent..."

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
  MANUAL-PROMPT-MODE.md \
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
