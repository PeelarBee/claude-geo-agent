# Using claude-geo-agent With Codex

This repo can be used with Codex as an OpenAI-style skill.

For Codex, the main entry point is:

`geo-agent`

You do not call the internal modules manually. The main skill calls them when needed.

## Install For Codex

Install with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/PeelarBee/claude-geo-agent/main/install-codex.sh | bash
```

Restart Codex after installation.

Then type:

```txt
@geo-agent
```

You can also ask naturally:

```txt
Use geo-agent to run a full GEO audit for https://example.com
```

## Manual Install Alternative

If you already downloaded or cloned the repo, open the repo folder and run:

```bash
bash install-codex.sh
```

## What The Installer Copies

`install-codex.sh` copies:

- `skills/geo-agent/` to `~/.agents/skills/geo-agent/`
- internal GEO skills to `~/.agents/skills/`
- scripts, prompts, templates, agents, and docs into `~/.agents/skills/geo-agent/references/`

## How To Use In Codex

The clean first-run flow is:

```txt
@geo-agent
```

The agent should then ask for the website URL and objective.

Codex should use the `geo-agent` skill when the request is about:

- GEO audit
- AI search readiness
- answer-engine discoverability
- llms.txt
- schema for AI readiness
- crawler access
- content citability
- brand mentions
- LLM prompt library
- measured LLM visibility

## What The Codex Skill Does

The main `geo-agent` skill:

1. asks for website URL and objective
2. extracts business CONFIG
3. asks the user to confirm CONFIG
4. checks available APIs/tools
5. selects evidence tier
6. shows a checklist
7. runs the right internal modules
8. separates readiness from real measurement
9. writes outputs
10. applies quality gates
11. checks that outputs do not contradict each other

## Internal Modules

These are installed too, but users do not need to invoke them directly:

- `geo-crawlers`
- `geo-citability`
- `geo-brand-mentions`
- `geo-schema`
- `geo-llms-txt`
- `geo-llm-prompts`
- `geo-monitor`

## Important Codex Boundary

Codex can run the readiness workflow without LLM provider APIs.

But Codex cannot claim measured LLM visibility unless prompts were actually executed through configured LLM providers or documented manual UI runs.

If no LLM provider is configured, results must say:

`Status: Not run -- no LLM provider configured`

## Provider Labels

- Serper = Search Evidence only
- OpenAI API = OpenAI API results, not ChatGPT UI
- Anthropic API = Anthropic API results
- Gemini API = Gemini API results
- Groq = Groq model/API results
- Perplexity API = Perplexity API results

## Recommended First Codex Test

After installing and restarting Codex, run:

```txt
@geo-agent
```

Then verify:

- it asks for URL and objective
- it asks for CONFIG confirmation
- it shows the checklist
- it separates readiness from measurement
- it marks LLM visibility as Not run if no provider is configured
- it applies quality gates before finalizing
