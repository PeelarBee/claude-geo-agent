# Installation Guide

This repo does not run by itself.

Think of it like a toolkit. First you install the toolkit into the AI tool you want to use. After that, you start the agent with `@geo-agent`.

## The Simple Version

You install one main thing:

`geo-agent`

The user does not call every subagent manually.

The main GEO agent calls the internal modules automatically:

- crawlers
- llms.txt
- schema
- citability
- brand mentions
- prompt library
- LLM measurement

## Option 1: Claude Code

Use this if you want to type:

```txt
@geo-agent
```

Install with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/PeelarBee/claude-geo-agent/main/install.sh | bash
```

Then restart Claude Code.

Use:

```txt
@geo-agent
```

What the installer does:

- copies agents into `~/.claude/agents/`
- copies skills into `~/.claude/skills/`
- copies scripts, prompts, templates, and docs into `~/.claude/geo-agent/`

## Option 2: Codex / OpenAI Skills

Use this if you want Codex to use the GEO workflow as a skill.

Install with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/PeelarBee/claude-geo-agent/main/install-codex.sh | bash
```

Then restart Codex.

Use:

```txt
@geo-agent
```

You can also ask naturally:

```txt
Use geo-agent to run a full GEO audit for https://example.com
```

What the Codex installer does:

- copies `skills/geo-agent/` into `~/.agents/skills/geo-agent/`
- copies the internal GEO skills into `~/.agents/skills/`
- copies scripts, prompts, templates, agents, and docs into `~/.agents/skills/geo-agent/references/`

## Manual Install Alternative

If you already downloaded or cloned the repo, open the repo folder and run:

```bash
bash install.sh
```

For Codex:

```bash
bash install-codex.sh
```

## What Gets Installed

Main entry point:

- `geo-agent`

Internal modules:

- `geo-crawlers`
- `geo-citability`
- `geo-brand-mentions`
- `geo-schema`
- `geo-llms-txt`
- `geo-llm-prompts`
- `geo-monitor`

Support files:

- claim guardrails
- evidence rules
- orchestration rules
- scoring rules
- quality gates
- output contract
- evals
- scripts
- templates
- prompt library

## Do I Need APIs?

No, not for a readiness audit.

Without APIs, the agent can check:

- crawlability
- robots.txt
- sitemap
- llms.txt
- schema
- content readiness
- prompt library
- fix guide
- backlog

For real LLM visibility measurement, connect at least one LLM provider API.

Serper is useful for search evidence, but Serper is not LLM measurement.

## Important

Installing the repo is not the same as connecting APIs.

Installation makes the agent available.

APIs decide what the agent can measure.

If no LLM provider is configured, the agent must say:

`Status: Not run -- no LLM provider configured`

## Quick Explanation For Non-Technical Users

1. Install the main GEO agent.
2. Restart Claude Code or Codex.
3. Type `@geo-agent`.
4. The agent asks for the URL and objective.
5. It checks what it can do.
6. It runs the internal modules automatically.
7. It tells you what was checked, what was measured, what was not run, and what to fix first.
