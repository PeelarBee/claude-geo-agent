# Quickstart

Install once. Restart your AI tool. Type `@geo-agent`.

You do not install or call every subagent manually. The main GEO agent calls the internal modules by itself.

## Claude Code

Use this if you want Claude Code to start the agent with:

```txt
@geo-agent
```

Install with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/PeelarBee/claude-geo-agent/main/install.sh | bash
```

Restart Claude Code.

Then type:

```txt
@geo-agent
```

## Codex / OpenAI Skills

Use this if you want Codex to use the GEO workflow as a skill.

Install with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/PeelarBee/claude-geo-agent/main/install-codex.sh | bash
```

Restart Codex.

Then type:

```txt
@geo-agent
```

You can also ask:

```txt
Use geo-agent to run a GEO audit for https://example.com
```

## Manual Install Alternative

If you already downloaded or cloned the repo, open the repo folder and run:

```bash
bash install.sh
```

For Codex:

```bash
bash install-codex.sh
```

## What Happens After Install

The main agent asks for:

1. Website URL
2. Objective

Then it:

1. extracts the business context
2. asks you to confirm it
3. checks which APIs are connected
4. shows a checklist
5. runs the right internal modules
6. tells you what was found
7. tells you what was not run
8. applies quality gates
9. creates the report files

## APIs Are Optional

Without APIs, the agent can still run a readiness audit.

With Serper, it can add search evidence.

With an LLM provider, it can run real LLM visibility measurement.

Serper is not LLM measurement.

OpenAI API is not the same as ChatGPT UI.

If no LLM provider is configured, the result file must say:

`Status: Not run -- no LLM provider configured`
