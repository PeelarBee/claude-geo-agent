# Manual Prompt Mode

Manual Prompt Mode is the fallback path for real LLM visibility research when no LLM provider API is configured or when the user wants to test chatbot interfaces directly.

It is not readiness-only. It is a structured way to run prompts manually in ChatGPT, Claude, Gemini, Perplexity, Copilot, or another LLM UI, then paste the responses back so the agent can analyze them as documented manual runs.

## When The Agent Must Offer This

Offer Manual Prompt Mode when:

- The objective is `full-audit`, `monitor`, or `llm-prompts`.
- No LLM provider API is configured.
- The user cannot or does not want to configure an API.
- The user wants to understand real chatbot visibility, not only technical readiness.

The agent must not hide this only in `10-API-SETUP-GUIDE.md`. It must explain the option in the chat.

## User-Facing Instruction

Use this language after the capability check when no LLM provider is configured:

```txt
I can generate the GEO prompt plan, but I cannot run real LLM visibility measurement automatically because no LLM provider API is configured.

You have 3 options:

1. Connect an API now
   Best for automatic measurement.
   Supported: OpenAI API, Gemini API, Anthropic API, Perplexity API, Groq.

2. Use Manual Prompt Mode
   I will give you copy/paste prompts for ChatGPT, Claude, Gemini, Perplexity, and Copilot.
   After you run them, paste the answers back here and I will analyze them as documented manual UI runs.

3. Continue readiness-only
   I will finish the technical GEO audit and mark LLM measurement as Not run.

Reply with: API, Manual, or Readiness-only.
```

If the user chooses Manual, say:

```txt
Manual Prompt Mode selected.

I will create a copy/paste prompt pack in 06-LLM-PROMPTS-TO-RUN.md.

For each chatbot, copy the prompt, paste it into a fresh chat, then paste the full answer back here with:

- Chatbot used
- Date
- Model, if visible
- Full response
- Whether the brand was mentioned
- Competitors mentioned
- Sources/citations, if any
```

## Output Behavior

Manual Prompt Mode must create:

- `06-LLM-PROMPTS-TO-RUN.md`: copy/paste prompt pack grouped by purpose.
- `07-LLM-VISIBILITY-RESULTS.md`: `Status: Manual run required -- prompt library generated only` until responses are pasted back.
- `11-RUN-TRACE.md`: records that Manual Prompt Mode was selected or offered.

When the user pastes responses back, the agent may update:

- `07-LLM-VISIBILITY-RESULTS.md`: with `Evidence Source Type: Manual UI`.
- `08-BACKLOG.md`: with measured or manually observed visibility gaps.
- `09-FINAL-REPORT.md`: with manual-run measurement clearly separated from readiness and search evidence.

## Manual Prompt Pack Structure

`06-LLM-PROMPTS-TO-RUN.md` should not be a loose list. It should be grouped so a non-technical user knows what to run first.

Recommended structure:

1. How to run these prompts
2. What to paste back
3. Starter Baseline
4. Brand Visibility
5. Category Visibility
6. Problem / Use-Case Visibility
7. Competitor / Comparison Visibility
8. Local / Market Visibility
9. Alternative Language Visibility
10. Citation and Source Capture
11. Paste-back templates

## Provider Targets

Each prompt group should specify where to run it:

- ChatGPT UI
- Claude UI
- Gemini UI
- Perplexity UI
- Copilot UI

Do not call these API results unless they were actually run through an API. Manual chatbot runs must be labeled `Manual UI`.

## Fresh Chat Rule

Each prompt should be run in a fresh chat unless the test is intentionally warm-context.

Cold baseline rules:

- No brand briefing before the prompt.
- No previous audit context.
- No pasted website summary.
- No explanation that the brand should appear.

If the user runs prompts in a chat that already has context, label the result `Warm-context manual UI` and do not mix it with cold baseline results.

## Group Delivery Format

Each group should use this format:

```md
## Group: [Group Name]

Purpose: [what this group measures]
Recommended providers: ChatGPT UI, Claude UI, Gemini UI, Perplexity UI, Copilot UI
Run priority: Starter / Full baseline / Deep dive
Measurement status: Not run until pasted back

### Prompt [ID] -- [Name]

Copy this prompt into a fresh chat:

```txt
[prompt text]
```

Record:

- Chatbot used:
- Model if visible:
- Date/time:
- Full response:
- Was the brand mentioned? Yes / No / Unclear
- Was the domain cited? Yes / No / Unclear
- Competitors mentioned:
- Sources/citations:
- Notes:
```

## Recommended Groups

### 1. Starter Baseline

Purpose: fastest useful manual visibility check.

Use when the user wants a lightweight first pass.

Recommended prompts:

- Branded visibility
- Category visibility
- Comparison visibility
- Problem-aware visibility
- Citation/source capture

### 2. Brand Visibility

Purpose: check whether the chatbot recognizes the brand directly.

Example prompt:

```txt
What is [Brand], and what does it do?
```

### 3. Category Visibility

Purpose: check whether the brand appears when users ask about a category without naming the brand.

Example prompt:

```txt
What are the best companies for [category] for [ICP]?
```

### 4. Problem / Use-Case Visibility

Purpose: check whether the brand appears when the user describes the problem, not the category.

Example prompt:

```txt
What companies can help [ICP] solve [problem]?
```

### 5. Competitor / Comparison Visibility

Purpose: check whether competitors appear instead of the brand and how the brand is framed.

Example prompt:

```txt
Compare the leading options for [ICP] that need [outcome]. Which companies should be considered?
```

### 6. Local / Market Visibility

Purpose: check geography or market-specific visibility.

Example prompt:

```txt
Which [category] providers serve [geography] or [market]?
```

### 7. Alternative Language Visibility

Purpose: check informal or non-expert phrasing.

Example prompt:

```txt
What tools or companies help with [plain-language version of the problem]?
```

### 8. Citation and Source Capture

Purpose: capture whether the chatbot cites sources and which URLs it trusts.

Example prompt:

```txt
Please include sources or links where possible. Which companies are credible options for [category]?
```

## Paste-Back Template

Ask the user to paste manual results back like this:

```md
## Manual Prompt Result

- Prompt ID:
- Prompt group:
- Chatbot used:
- Interface: Manual UI
- Model if visible:
- Date/time:
- Fresh chat? Yes / No
- Prompt pasted:
- Full response:
- Sources/citations shown:
- Notes:
```

## How The Agent Analyzes Pasted Responses

When responses are pasted back, the agent should extract:

- Brand mentioned: Yes / No / Unclear
- Domain cited: Yes / No / Unclear
- Competitors mentioned
- Citation/source URLs
- Sentiment/framing
- Recommendation status
- Answer type
- Visibility verdict: Win / Gap / Risk / Not enough data
- Evidence Status: Measured
- Evidence Source Type: Manual UI

Manual results are valid evidence only for the chatbot/interface/date/model/context that was actually tested.

## Guardrails

- Do not call generated prompts measurement.
- Do not call manual UI results API results.
- Do not claim ChatGPT visibility from OpenAI API results.
- Do not claim OpenAI API results from ChatGPT UI.
- Do not combine cold baseline and warm-context results without labeling.
- Do not summarize pasted responses without keeping provider/interface/date context.
