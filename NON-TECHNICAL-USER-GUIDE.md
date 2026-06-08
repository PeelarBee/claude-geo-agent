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

The agent checks two different things:

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

## 2. Real LLM Measurement

Measurement means:

Did we actually run prompts in an LLM provider and record what happened?

Examples:

- Gemini API answered the prompt and mentioned the brand.
- OpenAI API answered the prompt and did not mention the brand.
- Perplexity API cited a competitor.

This requires an LLM provider API or a documented manual UI run.

If no LLM provider is connected, the agent must say:

`Status: Not run -- no LLM provider configured`

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
- [ ] Readiness audit - crawlability, llms.txt, schema, content readiness
- [ ] Search evidence - only if Serper/search provider is configured
- [ ] LLM measurement - only if an LLM provider is configured
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
- `06-LLM-PROMPTS-TO-RUN.md`: prompts to test visibility
- `07-LLM-VISIBILITY-RESULTS.md`: real results only if prompts ran
- `08-BACKLOG.md`: prioritized tasks
- `09-FINAL-REPORT.md`: final synthesis
- `10-API-SETUP-GUIDE.md`: how to connect APIs
- `11-RUN-TRACE.md`: receipt of what happened

## The Most Important Thing To Understand

A readiness audit can say:

`Your site is or is not prepared for AI systems to understand it.`

A measurement run can say:

`We ran prompts in this provider and observed this result.`

The agent should never pretend the second happened if only the first happened.
