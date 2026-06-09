# Non-Technical User Guide

This guide explains what the GEO agent does without assuming technical or marketing knowledge.

## What You Install

You install the main GEO agent.

You do not need to install or call the subagents one by one.

The main agent calls the internal modules automatically.

After installation, the clean first run is:

```txt
@geo-agent
```

The agent should then ask for the website URL and objective.

## What The Agent Checks

The agent checks three different things:

## 1. Readiness

Readiness means:

Can AI/search systems find, read, understand, and possibly cite the website?

Examples:

- Is the site crawlable?
- Is robots.txt blocking important pages?
- Is there a sitemap?
- Is there an llms.txt file?
- Is schema markup present?
- Is the business category clear?
- Are services, audience, geography, proof, and FAQs clear?
- Is the content written in a way that can be quoted or summarized?

This does not require LLM APIs.

## 2. Prompt Plan

Prompt plan means:

The agent creates questions to test whether chatbots mention, cite, or understand the brand.

A prompt plan is not measurement yet.

It becomes measurement only after the prompts are actually run in an LLM provider or chatbot UI.

## 3. Real LLM Measurement

Measurement means:

Did we actually run prompts in an LLM provider or chatbot UI and record what happened?

Examples:

- Gemini API answered the prompt and mentioned the brand.
- OpenAI API answered the prompt and did not mention the brand.
- Perplexity API cited a competitor.
- ChatGPT UI was tested manually and the pasted response mentioned the brand.

This requires either:

- an LLM provider API, or
- Manual Prompt Mode, where the user copies prompts into chatbots and pastes the answers back.

If no LLM provider is connected and no manual responses were pasted back, the agent must say:

`Status: Not run -- no LLM provider configured`

or:

`Status: Manual run required -- prompt library generated only`

## Manual Prompt Mode In Plain English

Manual Prompt Mode is for users who do not have APIs.

The agent gives you prompts grouped by purpose. You copy each prompt into a fresh chat in:

- ChatGPT
- Claude
- Gemini
- Perplexity
- Copilot

Then you paste the full answer back into the agent.

The agent analyzes those pasted answers as documented `Manual UI` runs.

A manual result is valid only for the chatbot, date, model if visible, and prompt that you actually ran.

## What The Agent Should Say If APIs Are Missing

A good agent message should look like this:

```txt
I can generate the GEO prompt plan, but I cannot run real LLM visibility measurement automatically because no LLM provider API is configured.

You have 3 options:

1. Connect an API now.
2. Use Manual Prompt Mode: I will give you prompts to copy into ChatGPT, Claude, Gemini, Perplexity, or Copilot. Paste the answers back here and I will analyze them.
3. Continue readiness-only and mark LLM measurement as Not run.

Reply with: API, Manual, or Readiness-only.
```

If the user chooses Manual, the agent should say:

```txt
Manual Prompt Mode selected.

Copy each prompt into a fresh chatbot conversation. After each run, paste the full response back here with the chatbot used, model if visible, date, full answer, and sources/citations if shown.
```

## Serper In Plain English

Serper is a search tool.

It helps the agent look at search evidence, such as:

- whether the brand appears in Google-style results
- which competitors appear
- whether LinkedIn, YouTube, Reddit, Wikipedia, or directories mention the brand

Serper is useful, but Serper is not LLM measurement.

If only Serper is connected, the agent still cannot say the brand appears in ChatGPT, Claude, Gemini, Perplexity, or other LLM answers.

## OpenAI API vs ChatGPT

OpenAI API and ChatGPT are not exactly the same thing.

If the agent uses an OpenAI API key, it should say:

`OpenAI API`

It should not say:

`ChatGPT`

unless ChatGPT itself was manually tested and logged.

## What The Agent Says While Running

A good run should look like this:

```md
I will run this audit in phases:

- [ ] Capability check - confirm tools and APIs
- [ ] API guidance - explain what can be measured now and what needs an LLM provider
- [ ] Measurement mode - API, Manual Prompt Mode, or readiness-only
- [ ] Readiness audit - crawlability, llms.txt, schema, content readiness
- [ ] Search evidence - only if Serper/search provider is configured
- [ ] LLM prompt plan - grouped prompts to run, not measured results until executed
- [ ] LLM measurement - only if an LLM provider or documented manual run exists
- [ ] Synthesis - prioritize fixes and create the report
- [ ] Quality gates - verify claims, evidence labels, scope, and scoring
- [ ] Consistency QA - make sure Run Plan, Results, Backlog, and Final Report agree
```

After each phase, the agent should explain:

- what it did
- what it found
- what it could not run
- what evidence supports the finding
- what to fix first
- which output file changed

## What The Final Audit Gives You

A full audit can create:

- `00-START-HERE.md`: read this first
- `01-RUN-PLAN.md`: what ran and what was blocked
- `02-TECHNICAL-GEO-AUDIT.md`: readiness audit
- `03-FIX-GUIDE.md`: how to fix issues
- `04-LLMS-TXT.md`: llms.txt draft or review
- `05-SCHEMA.md`: schema recommendations
- `06-LLM-PROMPTS-TO-RUN.md`: prompts grouped for API/manual testing
- `07-LLM-VISIBILITY-RESULTS.md`: real results only if prompts ran
- `08-BACKLOG.md`: prioritized tasks
- `09-FINAL-REPORT.md`: final synthesis
- `10-API-SETUP-GUIDE.md`: how to connect APIs or use Manual Prompt Mode
- `11-RUN-TRACE.md`: receipt of what happened

## The Most Important Thing To Understand

A readiness audit can say:

`Your site is or is not prepared for AI systems to understand it.`

A prompt plan can say:

`Here are the prompts to test visibility.`

A measurement run can say:

`We ran prompts in this provider or chatbot and observed this result.`

The agent should never pretend the third happened if only the first or second happened.
