# Blog Post Prompt Template

Use this prompt to generate a new blog post in one shot.

---

Write a blog post for my personal developer blog in MDX format.

## Post Details
- Title: [TITLE]
- Date: [YYYY-MM-DD]
- Tags: [tag1, tag2, ...]
- Description: [one sentence summary]
- heroImage: [blog/image-id]
- unsplash: [Photographer Name]
- unsplashURL: [photographerusername]
- Topic outline: [paste lesson titles or bullet points here]
- Personal preferences: [any strong opinions, tools you use, things you recommend — e.g. "I prefer Google-style docstrings over NumPy or Sphinx"]

## Frontmatter format
```md
---
title: ""
date: ""
tags:
  - ""
description: ""
heroImage: ""
unsplash: ""
unsplashURL: ""
---
```

## Voice and tone
Write in first person. Or write in first-person plural ("we", "our", "us") to create a sense of shared discovery with the reader. Avoid "I" except when expressing a direct personal preference or recommendation. Ask which one.

Be direct and opinionated — share what I actually use and recommend, not just a neutral survey. Short sentences. Conversational but technically precise. Do not talk down to the reader. Acknowledge tradeoffs honestly. End with a one-sentence invitation to continue the conversation on Bluesky: [**Bluesky**](https://bsky.app/profile/joshfinnie.dev)

## Structure
Cover each topic in the outline as its own H2 or H3 section. Use prose paragraphs only — no bullet point lists. Where a section compares multiple options, a markdown table is fine. Include code examples where they make the concept concrete.

If I have a stated personal preference on the topic, express it clearly and explain why I prefer it. Do not hedge or bury the opinion.

Write a short but detailed description that works well with SEO.

## Formatting rules
- No em dashes anywhere. Rewrite sentences to avoid them.
- No bold on inline code or technical terms. Bold is only for link text where needed.
- No bullet lists. Convert any lists to flowing prose.
- Target a high Flesch reading ease score: short sentences, common words, active voice.
- Closing line links to Bluesky as described above.

## Avoid AI-isms
Do not use the following words or phrases:
- "dive into" / "delve into"
- "in today's world" / "in the modern era"
- "it's worth noting"
- "it's important to understand"
- "seamlessly"
- "robust"
- "leverage" (as a verb)
- "cutting-edge" / "game-changer"
- "navigate" (used metaphorically)
- "landscape" / "ecosystem" (used metaphorically)
- "furthermore" / "additionally" / "moreover" as sentence openers
- "in conclusion" / "in summary"
- rhetorical questions to open sections

Also avoid:
- Starting multiple sentences in a row with "This"
- Passive voice where active works fine
- Filler transition sentences that restate what was just said before moving on

## Sections to always include
1. A short intro (2-3 sentences) that establishes why the topic matters
2. Body sections covering the outline topics
3. A "Putting It Together" closing section that summarizes the key takeaways in prose form
