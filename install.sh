#!/bin/bash

echo "Installing claude-geo-agent..."

# Create directories if they don't exist
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/skills/content-refresher

# Copy agent
cp agents/geo-agent.md ~/.claude/agents/
echo "✅ geo-agent installed"

# Copy skills
cp skills/content-refresher/SKILL.md ~/.claude/skills/content-refresher/
echo "✅ content-refresher skill installed"

echo ""
echo "Done. Restart Claude Code to activate the agent."
echo "Invoke with: @geo-agent"
echo ""
echo "Don't forget to set your API keys:"
echo "  export SERPER_API_KEY=your_key   (recommended)"
echo "  export GEMINI_API_KEY=your_key   (optional)"
echo "  export GROQ_API_KEY=your_key     (optional)"
