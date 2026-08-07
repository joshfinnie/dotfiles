---
name: humanize-writing
description: Use whenever drafting or editing prose meant for a human reader — docs, READMEs, PR descriptions, commit messages, emails, essays, code comments, Slack messages, or any general writing task that doesn't have its own dedicated skill (e.g. blog-post owns joshfinnie.com posts specifically). Strips AI writing patterns — mechanical transitions, buzzwords, hedging, hype words, over-structuring, uniform sentence rhythm — either while drafting or as a standalone audit pass on text that already exists. Triggers on "humanize this", "make this sound human", "remove the AI-isms", "this sounds like AI", "does this read as generated", "check this for AI patterns".
user-invocable: true
argument-hint: "[text or file to audit, or leave blank to apply while drafting]"
---

This skill has two modes. Figure out which one applies before doing anything.

**Draft mode** — no existing text, or the user wants something written. Apply every rule below while writing. Don't produce a draft and then clean it up as a second pass; write it clean the first time.

**Audit mode** — the user points at existing text (a file, a pasted block, "this email," "the PR description") and wants it checked or fixed. Read it fully, find every violation using the categories below, then either report findings (if asked to review) or rewrite in place (if asked to fix). See [reference/audit-format.md](reference/audit-format.md) for the report structure when reporting rather than rewriting.

If the text belongs to a project with its own writing skill or style guide (a blog skill, a `CLAUDE.md` voice-law section, a style guide file), defer to that skill's specifics for tone and structure — use this skill for the AI-pattern sweep on top of it, not instead of it.

## Guardrails — restraint before rules

Read this before editing a single word. A ruthless editor who over-edits is worse than no editor: it launders a real person's voice into the same flat prose it claims to fix.

**Flag clusters, not isolated tells.** One em dash, one "crucial," one three-item list is how humans write too. A pattern is worth touching when several co-occur in the same passage, not on its first lone appearance. Perfect grammar and a consistent Oxford comma are signs of a careful writer, not proof of a machine.

**Protect what's hard to fabricate.** When you see these, leave them alone even if a rule above technically applies:
- Specifics that took real work to know: exact dates, dollar amounts, file paths, measured numbers ("dropped from 900ms to 40ms")
- Mixed or unresolved feelings ("I still can't decide if I like it"), admitted uncertainty, a stated bias
- Lived, sensory, first-person detail
- Slang or references tied to a specific time and community
- Deliberate imperfection: a fragment, a tangent, a self-correction, an ending that just stops

If a passage already has a pulse, the right edit is often no edit.

**Never touch quoted material.** Don't rewrite text inside direct quotes, dialogue, code, variable names, titles, or a pasted sample the author is critiquing — changing it changes meaning or breaks a reference.

## The core failure mode

AI-generated prose is recognizable because it optimizes for looking complete and safe rather than saying something specific. It hedges instead of committing, balances instead of arguing, transitions mechanically instead of connecting ideas that actually connect, and structures itself symmetrically (three reasons, five steps) whether or not the content has three or five parts. Every rule below is a specific symptom of that one failure mode. When judging a borderline case, ask: does this sentence exist because it's true and specific, or because it's the safe, complete-sounding thing to say?

## Rules

**1. No forced structure.** Don't default to numbered lists or bullets unless the content is actually a sequence or the user asked for one. Don't manufacture symmetrical groupings ("three key benefits") when the real number is two or five. Don't add a heading just to make a section look organized.

**2. Cut mechanical transitions.** Moreover, furthermore, additionally, consequently, therefore, subsequently, nevertheless, "it is worth noting that," "it is important to note that" — these connect paragraphs without saying how they connect. Replace with a transition specific to the actual content, or cut it and let the sentences sit next to each other.

**3. No artificial balance.** Don't reach for "on the one hand / on the other hand" or present manufactured equal pros and cons when the writer (or the evidence) actually leans one way. State the position. If there's a real tradeoff, name it once, specifically, and move on.

**4. Replace vague abstractions with specifics.** Leverage, utilize, empower, optimize, streamline, harness, robust, seamlessly, scalable, transform, innovative solution, dynamic landscape, drive value — these describe nothing. Say what actually happened, what changed, or what the reader should do, in concrete terms.

**5. Vary sentence rhythm (burstiness).** AI prose clusters around one sentence length; human prose swings between extremes in the same paragraph. Never let three-plus sentences in a row land at the same length and shape. Mix short (3-8 word) punches with medium sentences and the occasional long one that runs 25+ words, winding through a qualification before it lands. Use a fragment. Let a one-word sentence stand alone occasionally. Read it back — if it scans like it was generated one uniform clause at a time, it probably was.

**5a. Prefer the less obvious word (perplexity).** AI text reaches for the single most statistically likely word every time, which is exactly why it reads as bland. When a sentence's first word choice is the flattest, safest option, take the second or third one that comes to mind instead — as long as it's still the true, precise word, not a thesaurus swap for its own sake.

**6. Let some texture through.** Neutral, hedge-free, conflict-averse prose reads as corporate even when the content is fine. Mild opinion, a specific detail that isn't strictly necessary, a sentence that isn't perfectly balanced — these are what make writing sound like it came from a person who was actually thinking while they wrote it.

**7. Don't overuse rhetorical parallelism.** "It's not just X, it's Y." "This matters because... this matters because..." One instance can land. Two in the same piece is a pattern a reader will notice and distrust.

**8. Don't overexplain what the reader already knows.** Assume competence appropriate to the audience. Skip textbook definitions of things the reader almost certainly already understands, unless the piece is explicitly introductory.

**9. Avoid cliché metaphors.** Game-changer, double-edged sword, tip of the iceberg, building blocks, cornerstone, silver bullet, north star. If you reach for a metaphor, make it specific to the actual subject, not a stock phrase that fits any topic.

**10. No generic openers or closers.** Never open with "In today's fast-paced world," "In an ever-changing landscape," or a restatement of the obvious. Never close with "In conclusion," "To sum up," or "Overall, X is a powerful tool." Start with the actual claim. End on an insight, a concrete image, or a clean stop — not a summary of what was just said.

**11. Own the claim — cut hedges.** "It can be argued that," "some might say," "in many ways," "to some extent," "it seems that," "generally speaking" — these qualify a statement to avoid responsibility for it. Either make the claim directly or drop it. If there's a real exception, name the exception instead of hedging the whole sentence.

**12. Depth over coverage.** It's better to make one point well than to gesture at five superficially. Don't pad toward comprehensiveness the piece doesn't need.

**13. No em dashes.** Rewrite around them — a comma, a period, a parenthetical, or a colon will do the job.

The full blacklist with cut/replace tables lives in [reference/blacklist.md](reference/blacklist.md) — check it for anything not covered above, and for the two sentence-structure tics ("Not X. Y." inversion, and explanatory-sentence-plus-short-kicker) that read as generated when repeated.

## Before calling it done

Reread the piece and run two checks:

1. **The specific-person test.** Could a reader picture an actual person behind this sentence, with a stake in the claim, or could it have been written by anyone (or anything) about any topic? Text that emerges from nowhere, addressed to no one, is the fundamental tell. Anything that fails gets rewritten or cut, not polished.
2. **A short self-audit.** Ask "what in this still reads as AI?" and answer honestly in two or three bullets, then fix exactly those. This catches what the checklist above misses, and it's cheaper than a second full pass.

If auditing text that was visibly pasted from a chatbot (not just AI-flavored, but literally copy-pasted), also strip: assistant chatter ("I hope this helps," "Let me know if"), knowledge-cutoff disclaimers, sycophantic openers ("Great question!"), unfilled placeholders (`[Your Name]`, `[INSERT X]`), leaked citation markup (`citeturn0search0`, `oai_citation`), and `utm_source=chatgpt.com`-style tracking params on any URLs.
