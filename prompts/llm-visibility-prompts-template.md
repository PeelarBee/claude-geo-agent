# GEO / AI Search Visibility Prompt Library — Generic Template v2
> Reusable version for any client. Replace CONFIG before use.
> For an instantiated version: see prompts_marketingsprint_v2.md
> Updated: 2026-05-07 | 40 prompts in 8 modules

> **Measurement warning:** This file is a prompt library and monitoring framework, not a measurement result. LLM visibility is only measured when prompts are executed in fresh, isolated model contexts through configured LLM providers. Generated prompts must never be reported as measured visibility.

---

## CONFIG — Complete Per Client

```
brand:        [Brand name]
domain:       [domain.com]
category:     [business category / vertical]
services:     [main services or products]
icp:          [ideal customer profile: industry, size, role]
geography:    [target markets]
competitors:  [Competitor 1, Competitor 2, Competitor 3]
competitor_1: [Primary competitor]
competitor_2: [Second competitor]
competitor_3: [Third competitor]
problem:      [main problem the brand solves]
outcome:      [outcome the customer wants]
alt_bad:      [alternative the customer wants to avoid]
job:          [primary job to be done]
locale:       [en-US | es-AR | pt-BR | etc.]
city:         [primary city if applicable; otherwise use geography]
region:       [primary region if applicable; otherwise use geography]
```

---

## MODULE 1 — DISCOVERY

### `01_Discovery_Universe`
**Objective:** Generate the complete prompt universe to monitor
**Frequency:** Monthly or when starting with a new client

```
You are an AI visibility strategist.

Generate a complete prompt universe to monitor how this brand appears across LLMs when prompts are actually run through configured providers.

Brand: {{brand}}
Domain: {{domain}}
Category: {{category}}
Services: {{services}}
ICP: {{icp}}
Geography: {{geography}}
Competitors: {{competitors}}

Create prompts grouped by:
1. Branded
2. Non-branded category
3. Problem-aware
4. Comparison
5. Transactional/commercial
6. Local/geo
7. Educational/top-of-funnel
8. Alternative/substitute language

Rules:
- At least 15 prompts per group
- Realistic, natural-language prompts a user would type into an AI assistant
- Mix of short, medium, and long-form
- Mix of high-intent and exploratory
- Include synonyms and adjacent problem framing
- No repetition with minor variations
- Return prompt objects with prompt, cluster, intent, and priority wherever a prompt is generated

Return valid JSON only. No explanation, no markdown, no text outside the JSON:
{
  "branded": [
    {
      "prompt": "",
      "cluster": "branded",
      "intent": "",
      "priority": "high | medium | low"
    }
  ],
  "category": [
    {
      "prompt": "",
      "cluster": "category",
      "intent": "",
      "priority": "high | medium | low"
    }
  ],
  "problem_aware": [
    {
      "prompt": "",
      "cluster": "problem_aware",
      "intent": "",
      "priority": "high | medium | low"
    }
  ],
  "comparison": [
    {
      "prompt": "",
      "cluster": "comparison",
      "intent": "",
      "priority": "high | medium | low"
    }
  ],
  "transactional": [
    {
      "prompt": "",
      "cluster": "transactional",
      "intent": "",
      "priority": "high | medium | low"
    }
  ],
  "local": [
    {
      "prompt": "",
      "cluster": "local",
      "intent": "",
      "priority": "high | medium | low"
    }
  ],
  "educational": [
    {
      "prompt": "",
      "cluster": "educational",
      "intent": "",
      "priority": "high | medium | low"
    }
  ],
  "alternative_language": [
    {
      "prompt": "",
      "cluster": "alternative_language",
      "intent": "",
      "priority": "high | medium | low"
    }
  ]
}
```

---

### `02_Language_Map`
**Objective:** Detect how the brand speaks vs how users speak
**Frequency:** Monthly

```
You are a market language analyst.

Brand: {{brand}}
Category: {{category}}
Services: {{services}}
ICP: {{icp}}

List:
1. How the brand describes itself
2. How customers likely describe the same problem
3. How competitors describe it
4. Substitute phrases a user might use
5. Plain-language phrases that avoid industry jargon
6. Mislabelled or imperfect phrases real users might still use

Return valid JSON only. No explanation, no markdown:
{
  "brand_language": [],
  "customer_language": [],
  "competitor_language": [],
  "substitute_phrases": [],
  "plain_english_phrases": [],
  "messy_real_user_phrases": []
}
```

---

### `03_Alternative_Phrase_Discovery`
**Objective:** Find alternative, synonymous, and imperfect phrases real users might use
**Frequency:** Monthly

```
You are a linguistics and search behavior analyst.

Brand: {{brand}}
Category: {{category}}
Services: {{services}}
ICP: {{icp}}
Competitors: {{competitors}}

Users rarely describe their problem in the same language as the brand.
Your task: find every variation of how a real user might ask about this brand's solution.

Find:
1. Informal synonyms for the category (not industry terms)
2. How someone would describe the problem before knowing the solution exists
3. Objection-framed queries ("is X worth it", "do I really need X")
4. Comparison queries using informal language
5. Queries with spelling mistakes or imprecise terminology
6. Queries a non-expert user would type
7. Adjacent problem phrases that the brand could answer but might not be targeting

Return valid JSON only. No explanation, no markdown:
{
  "informal_synonyms": [
    {
      "prompt": "",
      "cluster": "alternative_language",
      "intent": "informal synonym",
      "priority": "high | medium | low"
    }
  ],
  "pre_awareness_phrases": [
    {
      "prompt": "",
      "cluster": "problem_aware",
      "intent": "pre-awareness",
      "priority": "high | medium | low"
    }
  ],
  "objection_phrases": [
    {
      "prompt": "",
      "cluster": "objection",
      "intent": "objection",
      "priority": "high | medium | low"
    }
  ],
  "informal_comparison_phrases": [
    {
      "prompt": "",
      "cluster": "comparison",
      "intent": "informal comparison",
      "priority": "high | medium | low"
    }
  ],
  "imprecise_user_phrases": [
    {
      "prompt": "",
      "cluster": "alternative_language",
      "intent": "imprecise real-user phrasing",
      "priority": "high | medium | low"
    }
  ],
  "non_expert_phrases": [
    {
      "prompt": "",
      "cluster": "educational",
      "intent": "non-expert phrasing",
      "priority": "high | medium | low"
    }
  ],
  "adjacent_problem_phrases": [
    {
      "prompt": "",
      "cluster": "adjacent_problem",
      "intent": "adjacent problem",
      "priority": "high | medium | low"
    }
  ]
}
```

---

### `04_Competitor_Query_Discovery`
**Objective:** Discover prompts that specifically favor competitors
**Frequency:** Monthly

```
You are a competitive AI visibility analyst.

Brand: {{brand}}
Competitors: {{competitors}}
Category: {{category}}
ICP: {{icp}}

Your task: identify the types of prompts where competitors are most likely to appear
and the target brand is likely to be absent.

Consider:
1. Prompts that favor brands with more content volume
2. Prompts tied to features or services the competitors offer that the brand may lack coverage on
3. Prompts where competitor brand names are embedded
4. Prompts in categories where competitors have strong authority
5. Comparison prompts that naturally center on a dominant competitor
6. Local or niche prompts where competitors have a presence

Return valid JSON only. No explanation, no markdown:
{
  "competitor_dominant_prompt_types": [],
  "competitor_branded_prompt_examples": [
    {
      "prompt": "",
      "cluster": "comparison",
      "intent": "competitor-branded",
      "priority": "high | medium | low"
    }
  ],
  "feature_gap_prompts": [
    {
      "prompt": "",
      "cluster": "feature_gap",
      "intent": "feature comparison",
      "priority": "high | medium | low"
    }
  ],
  "authority_gap_prompts": [
    {
      "prompt": "",
      "cluster": "authority_gap",
      "intent": "authority comparison",
      "priority": "high | medium | low"
    }
  ],
  "niche_prompts_competitors_own": [
    {
      "prompt": "",
      "cluster": "niche",
      "intent": "competitor-owned niche",
      "priority": "high | medium | low"
    }
  ],
  "recommended_counter_prompts_to_monitor": [
    {
      "prompt": "",
      "cluster": "counter_prompt",
      "intent": "defensive monitoring",
      "priority": "high | medium | low"
    }
  ]
}
```

---

### `05_Local_Intent_Discovery`
**Objective:** Find relevant local or geographic queries
**Frequency:** Monthly or when entering new markets

```
You are a local and geographic search intent analyst.

Brand: {{brand}}
Category: {{category}}
Services: {{services}}
ICP: {{icp}}
Geography: {{geography}}
City: {{city}}
Region: {{region}}

Generate local and geo-intent prompts a user in this area might type into an AI assistant.

Include:
1. City-specific service prompts
2. Region-specific category prompts
3. Language-variant prompts if the geography is multilingual
4. Prompts that assume the user wants a nearby or locally-operated provider
5. Prompts mixing English and local language if relevant

Return valid JSON only. No explanation, no markdown:
{
  "city_specific_prompts": [
    {
      "prompt": "",
      "cluster": "local",
      "intent": "city-specific",
      "priority": "high | medium | low"
    }
  ],
  "region_specific_prompts": [
    {
      "prompt": "",
      "cluster": "local",
      "intent": "region-specific",
      "priority": "high | medium | low"
    }
  ],
  "language_variant_prompts": [
    {
      "prompt": "",
      "cluster": "local",
      "intent": "language variant",
      "priority": "high | medium | low"
    }
  ],
  "local_provider_prompts": [
    {
      "prompt": "",
      "cluster": "local",
      "intent": "local provider",
      "priority": "high | medium | low"
    }
  ],
  "mixed_language_prompts": [
    {
      "prompt": "",
      "cluster": "local",
      "intent": "mixed language",
      "priority": "high | medium | low"
    }
  ]
}
```

---

## MODULE 2 — MEASUREMENT
> Prompts to run in LLMs to measure real visibility.
> Instantiate variables from CONFIG before use.
> Generality rule: do not assume industry, company stage, purchase model, customer type, channel, geography, or specific alternative unless it appears explicitly in CONFIG.
> Cold-context rule: measurement prompts must be run in a fresh model context with no business CONFIG, no prior audit notes, and no previous answers.

Interpretation definitions:
- Branded prompts measure entity recognition.
- Non-branded category prompts measure category visibility.
- Problem-aware prompts measure demand discovery.
- Comparison prompts measure competitive positioning.
- Transactional prompts measure commercial recommendation likelihood.
- Local prompts measure geography-specific discoverability.
- Educational prompts measure top-of-funnel topical authority.
- Alternative language prompts measure messy real-user language visibility.

### `10_Measure_Branded_Visibility`
**Objective:** Measure direct brand presence in branded prompts
**Frequency:** Weekly

```
What is {{brand}}?
Is {{brand}} legit?
What does {{brand}} do?
Who is {{brand}} for?
How does {{brand}} work?
Is {{brand}} worth it?
What are reviews of {{brand}}?
What are the pros and cons of {{brand}}?
What are alternatives to {{brand}}?
How much does {{brand}} cost?
What is {{domain}}?
Who runs {{brand}}?
Is {{brand}} a good option for {{icp}}?
What kind of customers use {{brand}}?
How is {{brand}} different from {{category}} alternatives?
```

---

### `11_Measure_Category_Visibility`
**Objective:** Measure whether the brand appears in category prompts
**Frequency:** Weekly

```
What are the best {{category}} providers for {{icp}}?
Top options offering {{services}} for {{icp}}
Best solution for {{problem}} for {{icp}}
Who helps with {{job}}?
Who are the leading providers in {{category}}?
Best {{category}} for {{icp}}
Which {{category}} options are best for {{icp}}?
Best {{services}} for {{icp}}
Top {{category}} providers for {{icp}}
Who provides specialized {{category}} support for {{icp}}?
Best {{category}} options for customers who need {{outcome}} quickly
Who helps {{icp}} with {{job}}?
Best flexible {{category}} options for {{icp}}
Which {{category}} option should I choose if I need {{outcome}}?
We're a {{icp}} trying to get {{outcome}}. What options should we consider?
What companies are actually good at {{job}} for {{icp}}?
Who would you shortlist for {{services}} if the buyer is {{icp}}?
```

---

### `12_Measure_Problem_Aware_Visibility`
**Objective:** Measure visibility in real user problem-aware prompts
**Frequency:** Weekly

```
How do I solve {{problem}}?
What is the best way to handle {{problem}}?
Who can help with {{problem}}?
What should I do if I need {{outcome}}?
What are my options for {{problem}} if I don't want {{alt_bad}}?
How do I get {{outcome}} without {{alt_bad}}?
What's the best way to handle {{job}} without the right internal expertise?
Who can help with {{job}} for a specific project or need?
How do I achieve {{outcome}} without relying on {{alt_bad}}?
I need {{outcome}} but I can't afford {{alt_bad}}. What should I do?
What happens if someone ignores {{category}} early on?
What's the difference between {{category}} and {{alt_bad}}?
How do I start {{job}} with limited internal resources?
What does {{icp}} need for {{job}}?
I need help with {{problem}} but I'm not sure what kind of provider to look for. Who would you recommend?
I don't want to use {{alt_bad}}. What are better alternatives?
```

---

### `13_Measure_Comparison_Visibility`
**Objective:** Measure how the brand appears against competitors
**Frequency:** Weekly

```
{{brand}} vs {{competitor_1}}
{{brand}} vs {{competitor_2}}
{{brand}} vs {{competitor_3}}
Which is better: {{brand}} or {{competitor_1}}?
Which is better: {{brand}} or {{competitor_2}}?
Compare {{brand}} and {{competitor_1}} for {{icp}}
What is the difference between {{brand}} and {{competitor_1}}?
{{brand}} vs {{alt_bad}}
{{brand}} vs doing {{job}} internally
{{brand}} vs {{alt_bad}} for {{icp}}
Is {{brand}} better than {{competitor_3}}?
{{competitor_1}} vs {{competitor_2}} vs {{brand}}: which is best for {{icp}}?
What {{category}} service is best for {{icp}}?
How does {{brand}} compare to other {{category}} options?
What are the top alternatives to {{brand}}?
```

---

### `14_Measure_Transactional_Visibility`
**Objective:** Measure presence in high-commercial-intent prompts
**Frequency:** Weekly

```
Best {{category}} option to choose now
Who should I choose for {{services}}?
Best affordable {{category}} for {{icp}}
What is the best option for {{job}}?
Find a {{category}} provider for {{icp}}
Who can help with {{job}} quickly?
Best {{category}} provider for {{icp}}
How to choose a {{category}} solution for {{icp}}
Who offers the fastest path to {{outcome}}?
Best {{category}} option available now
What's the fastest way to get {{outcome}} in place?
Best {{services}} options this year
Who would you recommend if we need {{services}} but want to avoid {{alt_bad}}?
Which providers should a {{icp}} evaluate before buying {{services}}?
```

---

### `15_Measure_Local_Visibility`
**Objective:** Measure geographic and local visibility
**Frequency:** Weekly

```
Best {{category}} services in {{geography}}
Who offers {{category}} in {{city}}?
Remote {{category}} options for customers in {{geography}}
Best {{services}} for {{icp}} in {{geography}}
Top {{category}} for {{icp}} in {{geography}}
{{category}} for customers in {{geography}}
Who helps customers in {{geography}} with {{job}}?
Best {{category}} for customers expanding from {{geography}} to new markets
{{category}} provider for distributed teams
Who provides {{category}} services globally?
```

---

### `16_Measure_Educational_Visibility`
**Objective:** Measure visibility in informational / top-of-funnel prompts
**Frequency:** Bi-weekly

```
What is {{category}}?
How does {{category}} work?
Why would someone need {{category}}?
What should I know before choosing {{category}}?
What are common mistakes when choosing {{category}}?
What does a {{category}} actually do day to day?
How much does {{category}} cost?
When should someone choose {{category}} instead of {{alt_bad}}?
What is the difference between {{category}} and a {{alt_bad}}?
How long does it take to achieve {{outcome}}?
How do you measure the success of {{category}}?
What should I ask before choosing {{category}}?
```

---

### `17_Measure_Alternative_Language_Visibility`
**Objective:** Measure visibility when users use language different from the brand's wording
**Frequency:** Bi-weekly

```
[Use the phrases generated by 03_Alternative_Phrase_Discovery as individual prompts]

Run each phrase from the "messy_real_user_phrases", "pre_awareness_phrases",
and "informal_synonyms" arrays as standalone prompts in the LLM.
Log each run separately in Prompt_Runs with Cluster = "alternative_language".
```

---

## MODULE 3 — EXTRACTION
> Defensive parsing applied. Never assume clean JSON from the model.
> Always run 90_Validate_Output after these prompts.

### `20_Extract_Mentions_and_Citations`
**Objective:** Extract brand mentions, domains, and cited URLs
**Frequency:** Every run

```
You are a structured data extraction engine. Your only job is to extract data and return valid JSON.

Target brand: {{brand}}
Target domain: {{domain}}
Known competitors: {{competitors}}

CRITICAL RULES:
- Return ONLY valid JSON. No explanation, no markdown, no text before or after.
- Do not wrap in ```json or any code block.
- If a field cannot be determined, use null — not "unknown", not "N/A", not "".
- brand_position and citation_position must be integers (1 = first) or null.
- mention_count must be an integer, minimum 0.
- All array fields must be arrays even if empty: use [] not null.
- evidence_quote must be a short exact excerpt from the model answer, or null when unavailable.
- evidence_source must identify the model answer, citation URL/domain, or null when unavailable.
- source_type must be exactly one of: "model_answer", "citation", "inferred", null.

LLM response to analyze:
{{response}}

Return this exact structure:
{
  "brand_mentioned": false,
  "mention_count": 0,
  "brand_position": null,
  "target_domain_cited": false,
  "cited_domains": [],
  "cited_urls": [],
  "citation_position": null,
  "competitors_mentioned": [],
  "competitor_count": 0,
  "evidence_quote": null,
  "evidence_source": null,
  "source_type": null,
  "notes": ""
}
```

---

### `21_Extract_Brand_Positioning`
**Objective:** Detect where and how prominently the brand appears
**Frequency:** Every run

```
You are a brand positioning analyst. Your only job is to evaluate and return valid JSON.

Target brand: {{brand}}

CRITICAL RULES:
- Return ONLY valid JSON. No explanation, no markdown, no text before or after.
- Use only the allowed values specified per field.
- If brand is not mentioned, return "not_present" for all applicable fields.
- evidence_quote must be a short exact excerpt from the model answer, or null when unavailable.
- evidence_source must identify the model answer, citation URL/domain, or null when unavailable.
- source_type must be exactly one of: "model_answer", "citation", "inferred", null.

Analyze this LLM response:
{{response}}

Return this exact structure:
{
  "brand_in_response": false,
  "position_in_response": "first | middle | last | not_present",
  "prominence": "central | secondary | brief_mention | not_present",
  "listed_as_option": false,
  "listed_position_if_option": null,
  "recommended_as_top_choice": false,
  "mentioned_with_caveats": false,
  "caveat_description": null,
  "evidence_quote": null,
  "evidence_source": null,
  "source_type": null
}
```

---

### `22_Extract_Sentiment_and_Framing`
**Objective:** Classify sentiment and framing of the brand in the response
**Frequency:** Every run

```
You are a sentiment and framing analyst. Your only job is to evaluate and return valid JSON.

Target brand: {{brand}}

CRITICAL RULES:
- Return ONLY valid JSON. No explanation, no markdown, no text before or after.
- sentiment must be exactly one of: "positive", "neutral", "negative", "mixed", null
- framing must be exactly one of: "recommended", "mentioned_only", "compared", "criticized", "unclear", null
- If brand is not in the response, use null for both.
- evidence_quote must be a short exact excerpt from the model answer, or null when unavailable.
- evidence_source must identify the model answer, citation URL/domain, or null when unavailable.
- source_type must be exactly one of: "model_answer", "citation", "inferred", null.

Analyze this LLM response:
{{response}}

Return this exact structure:
{
  "sentiment_toward_brand": null,
  "framing_of_brand": null,
  "tone_evidence": "",
  "framing_evidence": "",
  "evidence_quote": null,
  "evidence_source": null,
  "source_type": null
}
```

---

### `23_Extract_Competitive_Presence`
**Objective:** Detect which competitors appear and how much they dominate the response
**Frequency:** Every run

```
You are a competitive intelligence analyst. Your only job is to extract data and return valid JSON.

Target brand: {{brand}}
Known competitors: {{competitors}}

CRITICAL RULES:
- Return ONLY valid JSON. No explanation, no markdown, no text before or after.
- All arrays must be arrays even if empty: [].
- dominant_competitor must be a string (competitor name) or null.
- evidence_quote must be a short exact excerpt from the model answer, or null when unavailable.
- evidence_source must identify the model answer, citation URL/domain, or null when unavailable.
- source_type must be exactly one of: "model_answer", "citation", "inferred", null.

Analyze this LLM response:
{{response}}

Return this exact structure:
{
  "competitors_mentioned": [],
  "competitor_count": 0,
  "dominant_competitor": null,
  "dominant_competitor_position": null,
  "brand_vs_dominant_competitor": "brand_wins | tied | competitor_wins | brand_absent",
  "unknown_competitors_mentioned": [],
  "evidence_quote": null,
  "evidence_source": null,
  "source_type": null
}
```

---

### `24_Extract_Answer_Type`
**Objective:** Classify the type of answer the LLM gave
**Frequency:** Every run

```
You are a response classifier. Your only job is to classify and return valid JSON.

CRITICAL RULES:
- Return ONLY valid JSON. No explanation, no markdown, no text before or after.
- answer_type must be exactly one of the allowed values.
- cites_sources must be true or false (boolean, not string).
- evidence_quote must be a short exact excerpt from the model answer, or null when unavailable.
- evidence_source must identify the model answer, citation URL/domain, or null when unavailable.
- source_type must be exactly one of: "model_answer", "citation", "inferred", null.

Analyze this LLM response:
{{response}}

Return this exact structure:
{
  "answer_type": "direct_answer | list | comparison | educational | opinion | mixed",
  "response_length": "short | medium | long",
  "cites_sources": false,
  "source_count": 0,
  "includes_recommendation": false,
  "includes_caveat": false,
  "format": "prose | bullet_list | numbered_list | table | mixed",
  "evidence_quote": null,
  "evidence_source": null,
  "source_type": null
}
```

---

### `25_Extract_Share_of_Voice`
**Objective:** Evaluate qualitative competitive weight of the brand in the response
**Frequency:** Every run

```
You are a competitive visibility analyst. Your only job is to evaluate and return valid JSON.

Target brand: {{brand}}
Known competitors: {{competitors}}

CRITICAL RULES:
- Return ONLY valid JSON. No explanation, no markdown, no text before or after.
- All string fields must use only the allowed values specified.
- summary must be a single plain-text sentence, no quotes inside.
- evidence_quote must be a short exact excerpt from the model answer, or null when unavailable.
- evidence_source must identify the model answer, citation URL/domain, or null when unavailable.
- source_type must be exactly one of: "model_answer", "citation", "inferred", null.

Analyze this LLM response:
{{response}}

Return this exact structure:
{
  "visibility_level": "central | secondary | absent",
  "dominant_competitors": [],
  "brand_framing": "favorable | neutral | poor | not_present",
  "click_likelihood": "high | medium | low | none",
  "trust_likelihood": "high | medium | low | none",
  "summary": "",
  "evidence_quote": null,
  "evidence_source": null,
  "source_type": null
}
```

---

## MODULE 4 — INTERPRETATION
> Mandatory rule for prompts 30-34: If the provided data is incomplete, explicitly state what cannot be concluded. Do not infer competitor advantages, citation patterns, or entity gaps without observed evidence.

### `30_Interpret_Visibility_Gaps`
**Objective:** Explain why the brand does not appear in certain clusters
**Frequency:** Weekly

```
You are an AI discoverability analyst.

Brand: {{brand}}
Domain: {{domain}}
Cluster results: {{cluster_results}}
Competitors mentioned: {{competitor_patterns}}
Site page inventory: {{site_inventory}}
Existing content topics: {{content_topics}}

Explain why the brand is underperforming in these prompt clusters.

Look for:
- Missing content types
- Weak entity clarity
- Lack of comparison content
- Lack of local or service-specific pages
- Weak proof or evidence
- Unclear category positioning
- Competitor semantic advantage
- Mismatch between customer language and site language

Return valid JSON only. No explanation, no markdown:
{
  "cannot_conclude": [],
  "top_reasons_brand_is_missing": [],
  "content_gaps": [],
  "messaging_gaps": [],
  "entity_gaps": [],
  "priority_insights": []
}
```

---

### `31_Interpret_Competitor_Advantage`
**Objective:** Explain why competitors appear when the brand does not
**Frequency:** Weekly

```
You are a competitive AI visibility analyst.

Brand: {{brand}}
Domain: {{domain}}
Dominant competitors in results: {{dominant_competitors}}
Prompts where competitors win: {{competitor_win_prompts}}
Competitor domains: {{competitor_domains}}

Analyze specifically why these competitors outperform the brand in AI responses.

Look for:
- Content volume and depth advantages
- Authority signals (backlinks, citations, reviews)
- Clearer entity definition
- Better keyword/topic coverage
- Stronger comparison or FAQ content
- Better structured data
- Fresher content
- Broader geographic coverage

Return valid JSON only. No explanation, no markdown:
{
  "cannot_conclude": [],
  "competitor_advantages_by_type": {
    "content_volume": [],
    "authority_signals": [],
    "entity_clarity": [],
    "topic_coverage": [],
    "structured_data": [],
    "other": []
  },
  "top_3_competitor_advantages": [],
  "what_brand_can_replicate": [],
  "what_brand_cannot_easily_replicate": []
}
```

---

### `32_Interpret_Citation_Patterns`
**Objective:** Understand why certain URLs are cited and others are not
**Frequency:** Bi-weekly

```
You are analyzing why certain URLs are more citable in AI-generated responses.

Cited URLs: {{cited_urls}}
Non-cited URLs: {{non_cited_urls}}
Page features available: {{page_features}}

Compare cited vs non-cited pages. Identify patterns in:
- Clarity and directness
- Formatting (tables, lists, headers)
- FAQ presence
- Specificity and depth
- Use of evidence or data
- Freshness
- Title and heading quality
- Topical completeness
- Directness of answer

Return valid JSON only. No explanation, no markdown:
{
  "cannot_conclude": [],
  "patterns_in_cited_pages": [],
  "patterns_in_non_cited_pages": [],
  "main_differences": [],
  "what_to_replicate": [],
  "what_to_fix": []
}
```

---

### `33_Interpret_Entity_Clarity_Gaps`
**Objective:** Evaluate whether the brand is poorly defined as an entity in LLM responses
**Frequency:** Monthly

```
You are an entity clarity analyst for AI search visibility.

Brand: {{brand}}
Domain: {{domain}}
Category: {{category}}
Services: {{services}}
ICP: {{icp}}

Based on the LLM responses observed ({{sample_responses}}), evaluate whether
the brand is well-defined as an entity across AI systems.

Check for signs of weak entity definition:
1. Brand described inconsistently across responses
2. Brand confused with similar brands, entities, or organizations
3. Category wrongly attributed
4. ICP described incorrectly or too vaguely
5. Key services missing from AI descriptions
6. Founding story or location wrong
7. Brand described with outdated information

Return valid JSON only. No explanation, no markdown:
{
  "cannot_conclude": [],
  "entity_clarity_score": 0,
  "inconsistency_patterns": [],
  "wrong_attributions": [],
  "missing_entity_facts": [],
  "outdated_info_detected": [],
  "recommended_entity_fixes": []
}
```

---

### `34_Interpret_Messaging_Gaps`
**Objective:** Detect mismatch between website language and user language
**Frequency:** Monthly

```
You are a messaging alignment analyst.

Brand: {{brand}}
Website language (headlines, copy): {{website_language}}
Customer language (from reviews, forums, prompts used): {{customer_language}}
LLM response language for this category: {{llm_response_language}}

Compare how the brand talks about itself vs how customers and LLMs describe the category.

Identify:
1. Terms the brand uses that customers don't
2. Terms customers use that the brand doesn't
3. Concepts LLMs associate with the category that are missing from the site
4. Phrases LLMs use for competitors that the brand should adopt
5. Jargon the brand uses that a non-expert wouldn't search for

Return valid JSON only. No explanation, no markdown:
{
  "cannot_conclude": [],
  "brand_only_terms": [],
  "customer_only_terms": [],
  "llm_category_terms_missing_from_site": [],
  "competitor_phrases_to_adopt": [],
  "jargon_to_simplify": [],
  "top_messaging_fixes": []
}
```

---

## MODULE 5 — AUDIT
> Scoring anchors for prompts 40-48 whenever a 0-10 score is requested:
> - 0-2 = absent or unusable
> - 3-5 = present but weak/vague
> - 6-8 = clear but incomplete
> - 9-10 = strong, specific, evidence-backed

### `40_Audit_Homepage`
**Objective:** Audit the homepage for AI discoverability
**Frequency:** Monthly

```
You are a GEO/AEO/SEO auditor specialized in AI discoverability.

Brand: {{brand}}
Domain: {{domain}}
Homepage text: {{homepage_text}}
Meta title: {{meta_title}}
Meta description: {{meta_description}}

Score each dimension 0 to 10 (integer only):
1. Business category clarity in first 2 paragraphs (entity_clarity_score)
2. ICP clearly identified (icp_clarity_score)
3. Main problem solved clearly stated (problem_clarity_score)
4. Likely to be cited by an LLM (citation_readiness_score)
5. Language aligned with how users ask AI assistants (language_alignment_score)

Return valid JSON only. No explanation, no markdown:
{
  "entity_clarity_score": 0,
  "icp_clarity_score": 0,
  "problem_clarity_score": 0,
  "citation_readiness_score": 0,
  "language_alignment_score": 0,
  "missing_blocks": [],
  "main_issues": [],
  "recommended_changes": []
}
```

---

### `41_Audit_Service_Page`
**Objective:** Audit service or solution pages for citability
**Frequency:** Weekly or after changes

```
You are auditing a service or solution page for LLM citation readiness.

Brand: {{brand}}
URL: {{url}}
Service covered: {{service_name}}
Full visible text: {{page_text}}
Headings: {{headings}}

Score each dimension 0 to 10 (integer only):
1. Is the service clearly defined in the first paragraph? (service_clarity_score)
2. Is the ICP for this service explicit? (icp_clarity_score)
3. Are outcomes and results clearly stated? (outcome_clarity_score)
4. Is there social proof, case studies, or evidence? (evidence_score)
5. Does it include FAQ or common objections? (faq_score)
6. Would an LLM cite this page as a recommendation? (citation_likelihood_score)

Return valid JSON only. No explanation, no markdown:
{
  "service_clarity_score": 0,
  "icp_clarity_score": 0,
  "outcome_clarity_score": 0,
  "evidence_score": 0,
  "faq_score": 0,
  "citation_likelihood_score": 0,
  "missing_elements": [],
  "recommended_improvements": []
}
```

---

### `42_Audit_Pricing_Page`
**Objective:** Audit the pricing page for AI discoverability
**Frequency:** Monthly

```
You are auditing a pricing page for LLM citation readiness.

Brand: {{brand}}
URL: {{url}}
Full visible text: {{page_text}}
Pricing structure observed: {{pricing_structure}}

Evaluate:
1. Are prices or price ranges clearly stated? (price_clarity_score)
2. Is each tier's value proposition clear? (value_clarity_score)
3. Is the ICP for each tier identified? (icp_match_score)
4. Does the page answer "is this worth it"? (roi_clarity_score)
5. Are there FAQs about pricing? (faq_score)
6. Would an LLM cite this page when asked about cost? (citation_likelihood_score)

Score 0 to 10 (integer only).

Return valid JSON only. No explanation, no markdown:
{
  "price_clarity_score": 0,
  "value_clarity_score": 0,
  "icp_match_score": 0,
  "roi_clarity_score": 0,
  "faq_score": 0,
  "citation_likelihood_score": 0,
  "missing_elements": [],
  "recommended_improvements": []
}
```

---

### `43_Audit_FAQ_Coverage`
**Objective:** Audit whether the site has FAQ coverage for key prompt clusters
**Frequency:** Monthly

```
You are auditing FAQ coverage for AI search visibility.

Brand: {{brand}}
Domain: {{domain}}
Active prompt clusters: {{prompt_clusters}}
Existing FAQ content: {{faq_content}}
Existing FAQ pages or sections: {{faq_pages}}

Determine:
1. Which prompt clusters have FAQ coverage
2. Which clusters have weak or no FAQ coverage
3. Which specific questions are missing
4. Which FAQ format is recommended (dedicated page vs in-page section)

Return valid JSON only. No explanation, no markdown:
{
  "clusters_with_faq_coverage": [],
  "clusters_with_weak_coverage": [],
  "clusters_with_no_coverage": [],
  "missing_faq_questions": [],
  "recommended_new_faq_pages": [],
  "recommended_faq_sections_to_add": []
}
```

---

### `44_Audit_Comparison_Content`
**Objective:** Audit whether the site has comparison pages that LLMs could cite
**Frequency:** Monthly

```
You are auditing comparison content for AI citation readiness.

Brand: {{brand}}
Domain: {{domain}}
Competitors: {{competitors}}
Existing comparison pages: {{comparison_pages}}
Comparison prompts being monitored: {{comparison_prompts}}

Evaluate:
1. Which competitor comparisons exist as dedicated pages
2. Which comparisons are missing entirely
3. Which existing comparison pages are too thin or biased to be citable
4. What format each comparison page should have

Return valid JSON only. No explanation, no markdown:
{
  "existing_comparison_pages": [],
  "missing_comparison_pages": [],
  "weak_comparison_pages": [],
  "recommended_new_pages": [
    {
      "title": "",
      "competitors_covered": [],
      "key_differentiators_to_include": []
    }
  ]
}
```

---

### `45_Audit_Schema_Readiness`
**Objective:** Audit schema markup for AI discoverability
**Frequency:** Monthly

```
You are a schema markup analyst for AI search visibility.

Brand: {{brand}}
Domain: {{domain}}
Pages to review: {{pages_to_audit}}
Existing schema types detected: {{existing_schema}}

Evaluate:
1. Which schema types are present and correctly implemented
2. Which schema types are missing but highly recommended for this category
3. Which pages are missing schema entirely
4. Which schema properties are incomplete

Priority schema types for AI discoverability:
- Organization (with sameAs links)
- Service or Product
- FAQPage
- BreadcrumbList
- Person (if founder/team is a key trust signal)
- Review / AggregateRating

Return valid JSON only. No explanation, no markdown:
{
  "schema_present": [],
  "schema_missing": [],
  "schema_incomplete": [],
  "pages_without_schema": [],
  "high_priority_additions": [],
  "specific_property_fixes": []
}
```

---

### `46_Audit_Content_Cluster_Coverage`
**Objective:** Audit content architecture against prompt clusters
**Frequency:** Monthly

```
You are auditing the content architecture of a website for AI search visibility.

Main category: {{category}}
Content inventory: {{content_inventory}}
Competitor themes: {{competitor_themes}}
Prompt clusters to cover: {{prompt_clusters}}

Determine:
1. Which clusters are well covered
2. Which are weakly covered (page exists but thin or misaligned)
3. Which are missing entirely
4. Which content formats are missing

Return valid JSON only. No explanation, no markdown:
{
  "covered_clusters": [],
  "weak_clusters": [],
  "missing_clusters": [],
  "missing_formats": [],
  "highest_priority_new_pages": []
}
```

---

### `47_Audit_Social_Alignment`
**Objective:** Audit whether social media reinforces the same entity and themes as the site
**Frequency:** Bi-weekly

```
You are a brand discoverability analyst.

Website core positioning: {{website_positioning}}
Social media posts (last 30 days): {{social_posts}}
Active prompt clusters: {{prompt_clusters}}

Evaluate alignment between social content and website positioning.
Provide specific examples, not scores. Be factual and concrete.

Return valid JSON only. No explanation, no markdown:
{
  "topics_in_both_social_and_website": [],
  "topics_only_in_social_not_website": [],
  "topics_only_in_website_not_social": [],
  "key_terms_used_consistently": [],
  "key_terms_used_differently": [],
  "prompt_clusters_social_covers": [],
  "prompt_clusters_social_misses": [],
  "posts_to_convert_into_website_content": [],
  "top_3_recommendations": []
}
```

---

### `48_Audit_Evidence_and_Trust`
**Objective:** Audit proof, evidence, and trust signals for LLM citability
**Frequency:** Monthly

```
You are a trust and evidence analyst for AI discoverability.

Brand: {{brand}}
Domain: {{domain}}
Pages to review: {{pages_to_audit}}
Evidence elements found: {{evidence_elements}}

Content with verifiable evidence, specific claims, and trust signals is generally easier for answer engines and human reviewers to evaluate.

Evaluate:
1. Presence of specific data points or statistics
2. Named case studies or client results
3. Third-party reviews or ratings
4. Named team members with credentials
5. Media mentions or press coverage
6. Certifications or partnerships
7. Specific outcome claims with numbers

Score 0 to 10 (integer only) per category.

Return valid JSON only. No explanation, no markdown:
{
  "data_and_statistics_score": 0,
  "case_study_score": 0,
  "review_and_rating_score": 0,
  "team_credibility_score": 0,
  "media_mention_score": 0,
  "certification_score": 0,
  "outcome_specificity_score": 0,
  "overall_trust_score": 0,
  "missing_trust_elements": [],
  "quick_trust_wins": []
}
```

---

## MODULE 6 — ACTION

### `50_Generate_Action_Plan_Content`
**Objective:** Decide what content to create to close visibility gaps
**Frequency:** Weekly

```
You are a content strategist specialized in AI and search discoverability.

Brand: {{brand}}
Prompt visibility results: {{visibility_results}}
Content gap analysis: {{gap_results}}
Competitor content patterns: {{competitor_patterns}}

Recommend what content to create to close visibility gaps.

Rules:
- Be specific: exact page titles and topics, not vague directions
- Prioritize by expected LLM citation impact
- Separate quick wins (1-3 days) from medium-term (1-2 weeks)
- Specify format: FAQ, comparison, how-to, glossary, use-case, local, alternatives
- Every recommendation must include evidence_source and acceptance_criteria

Return valid JSON only. No explanation, no markdown:
{
  "quick_win_content": [
    {
      "page_title": "",
      "format": "",
      "target_prompt_cluster": "",
      "rationale": "",
      "evidence_source": "",
      "acceptance_criteria": "",
      "effort": "low | medium | high"
    }
  ],
  "medium_term_content": [
    {
      "page_title": "",
      "format": "",
      "target_prompt_cluster": "",
      "rationale": "",
      "evidence_source": "",
      "acceptance_criteria": "",
      "effort": "low | medium | high"
    }
  ],
  "strategic_content": [
    {
      "page_title": "",
      "format": "",
      "target_prompt_cluster": "",
      "rationale": "",
      "evidence_source": "",
      "acceptance_criteria": "",
      "effort": "low | medium | high"
    }
  ]
}
```

---

### `51_Build_Optimization_Backlog`
**Objective:** Create an executable task table ordered by impact
**Frequency:** Weekly

```
You are building an execution backlog for AI visibility improvement.

Brand: {{brand}}
Missing prompt clusters: {{missing_prompt_clusters}}
Underperforming URLs: {{underperforming_urls}}
Competitor wins: {{competitor_wins}}
Existing assets available: {{existing_assets}}

Each item must be a concrete, actionable task.
Each item must include evidence_source and acceptance_criteria.

Return valid JSON array only. No explanation, no markdown:
[
  {
    "task": "",
    "type": "content | technical | messaging | schema | structural",
    "target_url": "",
    "rationale": "",
    "evidence_source": "",
    "acceptance_criteria": "",
    "expected_impact": "high | medium | low",
    "effort": "high | medium | low",
    "priority": "P1 | P2 | P3",
    "status": "open"
  }
]
```

---

### `52_Recommend_Page_Fixes`
**Objective:** Specific recommendations to improve a single URL
**Frequency:** On demand

```
You are optimizing a specific URL for AI citation and discoverability.

URL: {{url}}
Page audit results: {{page_audit}}
Relevant prompt cluster: {{prompt_cluster}}
Competing pages being cited instead: {{competing_pages}}

Recommend specific changes. Avoid vague advice.
Every recommendation must include evidence_source and acceptance_criteria.

Return valid JSON only. No explanation, no markdown:
{
  "add": [
    {
      "change": "",
      "evidence_source": "",
      "acceptance_criteria": ""
    }
  ],
  "remove": [
    {
      "change": "",
      "evidence_source": "",
      "acceptance_criteria": ""
    }
  ],
  "rewrite": [
    {
      "change": "",
      "evidence_source": "",
      "acceptance_criteria": ""
    }
  ],
  "new_blocks_to_add": [
    {
      "block": "",
      "evidence_source": "",
      "acceptance_criteria": ""
    }
  ],
  "entity_clarity_changes": [
    {
      "change": "",
      "evidence_source": "",
      "acceptance_criteria": ""
    }
  ],
  "citation_improvements": [
    {
      "change": "",
      "evidence_source": "",
      "acceptance_criteria": ""
    }
  ]
}
```

---

### `53_Generate_Action_Plan_Technical`
**Objective:** Technical and messaging fixes for existing pages
**Frequency:** Weekly

```
You are a technical SEO and GEO specialist.

Brand: {{brand}}
Domain: {{domain}}
Site audit results: {{site_audit_results}}
Competitor patterns: {{competitor_patterns}}

Recommend structural, technical, and messaging changes to improve AI citation readiness.
Do NOT recommend new content creation (that's 50_Generate_Action_Plan_Content).
Focus only on: existing pages, site structure, schema, messaging, headings, entity clarity.
Every recommendation must include evidence_source and acceptance_criteria.

Return valid JSON only. No explanation, no markdown:
{
  "quick_technical_fixes": [
    {
      "fix": "",
      "page_or_section": "",
      "rationale": "",
      "evidence_source": "",
      "acceptance_criteria": "",
      "effort": "low | medium | high"
    }
  ],
  "messaging_changes": [
    {
      "change": "",
      "page_or_section": "",
      "rationale": "",
      "evidence_source": "",
      "acceptance_criteria": "",
      "effort": "low | medium | high"
    }
  ],
  "structural_changes": [
    {
      "change": "",
      "page_or_section": "",
      "rationale": "",
      "evidence_source": "",
      "acceptance_criteria": "",
      "effort": "low | medium | high"
    }
  ],
  "schema_additions": [
    {
      "schema_type": "",
      "page_or_section": "",
      "rationale": "",
      "evidence_source": "",
      "acceptance_criteria": "",
      "effort": "low | medium | high"
    }
  ]
}
```

---

## MODULE 7 — OPTIMIZATION / LEARNING

### `60_Generate_New_Prompts_from_Gaps`
**Objective:** Expand the prompt library based on what is not working
**Frequency:** Monthly

```
You are expanding a prompt library based on AI visibility gaps.

Brand: {{brand}}
Prompt clusters where brand is absent: {{absent_clusters}}
Competitors dominating those clusters: {{dominant_competitors}}
Language on the website: {{site_language}}
Language customers actually use: {{customer_language}}

Generate 30 new prompts likely to expose additional visibility gaps.

Rules:
- Do not repeat existing prompts
- Focus on adjacent wording, substitutes, comparisons, objections, real-user phrasing
- Include local and commercial angles when relevant
- Natural-language, as a user would type into an AI assistant

Return valid JSON array only. No explanation, no markdown:
["prompt 1", "prompt 2", ...]
```

---

### `61_Detect_Emerging_Opportunities`
**Objective:** Identify new patterns and emerging opportunities over time
**Frequency:** Monthly

```
You are an AI visibility pattern analyst.

Historical prompt results over time: {{historical_results}}
New cited domains this week: {{new_cited_domains}}
New social themes detected: {{new_social_themes}}
New content published this month: {{new_content}}

Identify:
1. Emerging prompt opportunities (topics gaining LLM traction)
2. New competitor threats
3. Content themes gaining citation traction
4. Actions that likely improved visibility

Return valid JSON only. No explanation, no markdown:
{
  "emerging_opportunities": [],
  "new_threats": [],
  "themes_gaining_traction": [],
  "likely_successful_actions": []
}
```

---

## MODULE 8 — VALIDATION
> Always run before writing results to Sheets.

### `90_Validate_Output`
**Objective:** Verify that parsed JSON is valid before saving it
**Frequency:** Every run, after any extraction or audit prompt

```
You are a data quality validator for an AI visibility monitoring system.

Parsed output to validate: {{parsed_output}}
Provider status: {{provider_status}}

Expected schema type: {{schema_type}}
Options: "mentions_extract" | "positioning_extract" | "sentiment_extract" |
         "competitive_extract" | "answer_type_extract" | "sov_extract" |
         "gap_analysis" | "page_audit" | "backlog_item"

Validate:
1. All required fields are present (not null where not allowed, not empty string)
2. All score fields are integers between 0 and 10 (inclusive)
3. All array fields are actual arrays, not null or string
4. Enum fields use only allowed values
5. No field contains unresolved template variables like "{{brand}}" or "{{variable_name}}"
6. No field contains markdown, markdown headings, or code block syntax (```)
7. Boolean fields are true/false, not "true"/"false" strings
8. No measured visibility result is present if provider status is not configured
9. All enum values are valid for their schema
10. All scores are within the required range for their schema

Return ONLY valid JSON. No explanation, no markdown:
{
  "is_valid": false,
  "errors": [
    {
      "field": "",
      "issue": "",
      "found_value": ""
    }
  ],
  "should_retry": false,
  "fix_instructions": ""
}
```

---

## SUMMARY — Naming and Frequency

| ID | Name | Module | Frequency |
|----|--------|--------|------------|
| 01 | Discovery_Universe | Discovery | Monthly |
| 02 | Language_Map | Discovery | Monthly |
| 03 | Alternative_Phrase_Discovery | Discovery | Monthly |
| 04 | Competitor_Query_Discovery | Discovery | Monthly |
| 05 | Local_Intent_Discovery | Discovery | Monthly |
| 10 | Measure_Branded_Visibility | Measurement | Weekly |
| 11 | Measure_Category_Visibility | Measurement | Weekly |
| 12 | Measure_Problem_Aware_Visibility | Measurement | Weekly |
| 13 | Measure_Comparison_Visibility | Measurement | Weekly |
| 14 | Measure_Transactional_Visibility | Measurement | Weekly |
| 15 | Measure_Local_Visibility | Measurement | Weekly |
| 16 | Measure_Educational_Visibility | Measurement | Bi-weekly |
| 17 | Measure_Alternative_Language_Visibility | Measurement | Bi-weekly |
| 20 | Extract_Mentions_and_Citations | Extraction | Every run |
| 21 | Extract_Brand_Positioning | Extraction | Every run |
| 22 | Extract_Sentiment_and_Framing | Extraction | Every run |
| 23 | Extract_Competitive_Presence | Extraction | Every run |
| 24 | Extract_Answer_Type | Extraction | Every run |
| 25 | Extract_Share_of_Voice | Extraction | Every run |
| 30 | Interpret_Visibility_Gaps | Interpretation | Weekly |
| 31 | Interpret_Competitor_Advantage | Interpretation | Weekly |
| 32 | Interpret_Citation_Patterns | Interpretation | Bi-weekly |
| 33 | Interpret_Entity_Clarity_Gaps | Interpretation | Monthly |
| 34 | Interpret_Messaging_Gaps | Interpretation | Monthly |
| 40 | Audit_Homepage | Audit | Monthly |
| 41 | Audit_Service_Page | Audit | Weekly / after changes |
| 42 | Audit_Pricing_Page | Audit | Monthly |
| 43 | Audit_FAQ_Coverage | Audit | Monthly |
| 44 | Audit_Comparison_Content | Audit | Monthly |
| 45 | Audit_Schema_Readiness | Audit | Monthly |
| 46 | Audit_Content_Cluster_Coverage | Audit | Monthly |
| 47 | Audit_Social_Alignment | Audit | Bi-weekly |
| 48 | Audit_Evidence_and_Trust | Audit | Monthly |
| 50 | Generate_Action_Plan_Content | Action | Weekly |
| 51 | Build_Optimization_Backlog | Action | Weekly |
| 52 | Recommend_Page_Fixes | Action | On demand |
| 53 | Generate_Action_Plan_Technical | Action | Weekly |
| 60 | Generate_New_Prompts_from_Gaps | Learning | Monthly |
| 61 | Detect_Emerging_Opportunities | Learning | Monthly |
| 90 | Validate_Output | Validation | Every run |

---
*Total: 40 prompts | Suggested initial run: 10, 11, 13, 20, 30, 41, 50, 90 (8 prompts)*
*To instantiate: copy this file -> prompts_[client]_v2.md -> complete CONFIG -> replace {{variables}} in Module 2.*
