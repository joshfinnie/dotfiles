---
name: blog-post
description: Use when writing, drafting, or editing a blog post for joshfinnie.com. Covers voice (I vs we), formatting rules, banned AI-isms, structure, file format (.md vs .mdx), and the pre-done Vale lint check. Triggers on "write a blog post", "draft a post", "new post about X", or editing an existing post in src/content/.
user-invocable: true
argument-hint: "[topic or outline]"
---

Writing a post for this blog follows a fixed style. Do not skip steps or ask about preferences already fixed by this skill; only the voice question below needs the user's input.

## Before writing

Ask whether the post should be first person ("I") or first-person plural ("we"). "We" creates shared discovery with the reader; "I" is more personal. Even in a "we" post, anything that is actually about Josh personally (his life, his opinion as an individual, where he lives) must still be "I" — never a royal/editorial "we". "We" is only for genuine shared-discovery or a real collective Josh belongs to.

## File format

Default to `.md`. Only use `.mdx` if the post needs JSX components or imports. `.md` supports the HTML comments Vale suppression directives need (`<!-- vale off -->`); `.mdx` breaks on them.

## Frontmatter

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

Write a short, detailed, SEO-friendly description.

## Voice and tone

Be direct and opinionated: share what Josh actually uses and recommends, not a neutral survey. Short sentences, conversational but technically precise. Do not talk down to the reader. Acknowledge tradeoffs honestly. If Josh has a stated preference on the topic, state it clearly and explain why, without hedging.

## Structure

Cover each topic as its own H2 or H3 section. Prose paragraphs only, no bullet lists (a markdown table is fine for comparisons). Include code examples where they make a concept concrete.

1. Short intro (2-3 sentences) establishing why the topic matters
2. Body sections covering the outline
3. A closing section that summarizes the key takeaways in prose form
4. Final line: `find me on [**Bluesky**](https://bsky.app/profile/joshfinnie.dev)`

## Formatting rules

- No em dashes anywhere, ever. Rewrite sentences to avoid them.
- No bold on inline code or technical terms. Bold only for link text.
- No bullet lists. Convert any list to flowing prose.
- Target a high Flesch reading ease score: short sentences, common words, active voice.

## Avoid AI-isms

Never use: "dive into" / "delve into", "in today's world" / "in the modern era", "it's worth noting", "it's important to understand", "seamlessly", "robust", "leverage" (as a verb), "cutting-edge" / "game-changer", "navigate" (metaphorical), "landscape" / "ecosystem" (metaphorical), "furthermore" / "additionally" / "moreover" as sentence openers, "in conclusion" / "in summary", rhetorical questions to open sections.

Also avoid: starting multiple sentences in a row with "This", passive voice where active works fine, filler transition sentences that restate what was just said.

## Before calling it done

Run `pnpm run lint:prose` (Vale) and get it to zero errors and zero warnings. Fix findings by rewriting (active voice, drop lazy words, avoid cliché metaphors) rather than suppressing rules with vale toggle comments, unless a rewrite genuinely hurts the sentence. A pre-commit hook runs Vale and will block the commit otherwise.

See [reference/prompt-template.md](reference/prompt-template.md) for the full one-shot generation prompt if starting from scratch with a topic outline.
