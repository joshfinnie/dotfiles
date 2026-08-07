# Full AI-ism blacklist

Exhaustive reference for the rules in SKILL.md. Use this when auditing — it's more complete than the summary in the main skill file.

## Mechanical transitions

| Cut | Replace with |
|-----|-------------|
| Moreover | Also, and, on top of that |
| Furthermore | What's more, beyond that, plus |
| Consequently | So, which means, as a result |
| In addition | And, also, there's also |
| Therefore | So, that's why, this means |
| Subsequently | After that, then, next |
| Nevertheless | Still, even so |
| It is worth noting that | Note that — or just say the point |
| As previously mentioned | As we covered, earlier |
| It is important to note that | Just say the point directly |
| Additionally | And, also |
| Thus / Hence | So |

Single use in a context that genuinely calls for it is fine. Repeated use across paragraphs is a pattern — flag every instance once it recurs, not just the first.

## Buzzwords

Confidence tiers, most to least damning. A lone Tier 3 word is not evidence of anything — flag it only when it clusters with Tier 1 or 2 hits. Tier 1 words almost never survive in unedited human prose and are worth flagging even alone.

- **Tier 1 (always flag):** delve, leverage (verb), utilize, multifaceted, tapestry (figurative), testament (figurative), underscore (verb), realm, interplay, "it's worth noting," "it's important to note," "in today's ... landscape"
- **Tier 2 (flag at 2+ in a paragraph):** crucial, pivotal, vibrant, robust, seamless, foster, enhance, showcase, notably, moreover, furthermore, garner, bolster, "align with"
- **Tier 3 (context only, never alone):** key, important, significant, various, effective, valuable, powerful, essential — ordinary words that only mean something next to a Tier 1/2 cluster, or when standing in for a fact that should just be stated

| Cut | Replace with |
|-----|-------------|
| Leverage | Use, apply, build on |
| Utilize | Use |
| Facilitate | Help, allow, support |
| Implement | Start, roll out, put in place |
| Optimize | Improve, speed up, cut down on |
| Streamline | Simplify, speed up |
| Harness | Use, tap into, apply |
| Robust | Strong, reliable, solid |
| Seamlessly | Works well, fits easily |
| Scalable | Grows with you, easy to expand |
| Empower | Let, allow, give someone the ability to |
| Transform | Change, rebuild, replace |
| Innovative | New, different, first to do X |
| Dynamic | Name the specific thing that changes |
| Enhance | Improve, add to |
| Drive value | Name the actual outcome |
| Synergy | Name what actually combines and why |

## Formulaic openers — never use these

- In today's fast-paced world
- In today's society
- In an ever-changing landscape
- This [essay/post/document] will discuss
- It is evident that
- There is no doubt that
- At the end of the day
- [Section opens with a dictionary-style definition: "X is the process of..."]

Start with the actual claim instead.

## Hype words — replace with evidence

| Cut | Replace with |
|-----|-------------|
| Revolutionary | What actually changed, and by how much |
| Transformative | Name the specific shift |
| Game-changing | What the actual impact was |
| Groundbreaking | What was new about it |
| Cutting-edge | Name the specific technology |
| Remarkable | Say what was actually notable |
| Comprehensive | Describe what it covers specifically |
| Crucial | Important, necessary, key |
| Significant | Describe the size or nature of the impact |
| Unprecedented | Name what precedent, if any, actually exists |
| Powerful | Say what it does |

## Hedging starters — own the claim

| Cut | Replace with |
|-----|-------------|
| It can be argued that | Just make the argument |
| Some might say | Say who says it, or drop it |
| In many ways | In what ways specifically? |
| To some extent | How much? Be precise |
| It seems that | Either it is or it isn't |
| One could say | You're saying it — own it |
| Generally speaking | Name the exception, or drop the qualifier |
| In a sense | Cut it, or say the literal thing |

## Sentence-structure tics

These aren't banned outright — one instance can genuinely land. The problem is repetition within a single piece.

**"Not X. Y." inversion**

> She wasn't afraid. She was certain.
> Not calculation. Survival.

The negative-positive flip creates artificial weight without doing the work of actual insight. Use at most once per piece, only where the contrast is irreducible. If cutting the "Not X." loses nothing, cut it.

**Explanatory sentence + short kicker**

> The system hadn't failed. It had worked.
> She'd tried six times. Six.

A setup sentence immediately followed by a short one that lands or reframes it. Effective once, mechanical on repeat. The short sentence should reframe, not just restate — if it's a summary of what was already said, fold it back in or cut it.

**Rhetorical questions as section openers.** "So what does this mean for you?" — almost always cuttable. State the point instead of asking permission to make it.

**Runs of uniform sentence length.** Three or more consecutive sentences landing at the same length and clause structure. Flag the run, not each sentence individually.

## Structural tells beyond sentence level

- Bulleted prose that could be continuous sentences — bullets used to avoid writing transitions, not because the content is a real list
- Numbered lists imposed on content that isn't actually sequential or countable
- A paragraph that ends by restating what it opened with
- Symmetrical "three reasons" / "five steps" framing applied to content that doesn't naturally split that way
- **Fragmented headers**: a heading immediately followed by one line that just restates it ("This section covers X")
- **Question-format headings**: "What makes X unique?" — state the answer as the heading instead
- **Paragraph-closing "whether" summaries**: "Whether you're a beginner or an expert..." SEO-recap habit; cut it, end on the strongest specific point instead
- **Paragraph-reshuffling immunity**: if you can swap two body paragraphs without the piece breaking, they aren't actually building an argument — merge or cut the interchangeable one

## Word- and sentence-level tells not covered above

- **Superficial -ing phrases**: clauses tacked on to fake depth — "the update, ensuring reliability and fostering trust." Delete the clause or promote its real content to its own sourced sentence.
- **Copula avoidance**: elaborate verbs replacing plain "is/are/has" — "serves as," "stands as," "represents," "boasts." Simple copulas are clear, not boring; use them.
- **Vague attributions**: "experts argue," "research suggests," "it is widely believed" — phantom authorities. Name the specific person or source, or cut the claim.
- **Notability name-dropping**: proving importance by listing where something was mentioned instead of what was said — "featured in X, Y, and other outlets." Pick one and say what it actually reported.
- **Elegant variation / synonym cycling**: swapping "the protagonist" for "the central figure" for "our hero" across consecutive sentences to avoid repetition. Pick one term and repeat it — jargon and proper nouns are supposed to repeat.
- **False ranges**: "from X to Y" where X and Y aren't actually on a spectrum. Name the real items instead.
- **False agency**: inanimate or abstract things performing human actions — "the data tells us," "the market rewards." Name the human actor, or address the reader directly.
- **Narrator-from-a-distance**: detached, floating third person — "people tend to," "one might say," "there is a sense that." Put the reader in the room; "you" beats "people."
- **Diff-anchored writing**: docs or explanations that narrate a change instead of describing the current state — "was added to," "now uses," "previously." Describe the thing as it is now.
- **Passive/subjectless constructions that hide the actor**: "no configuration is needed," "it is recommended that," "changes were made." Name who does what, in active voice.
- **Hedged-enumeration openers**: "There are several ways to..." / "It is generally a good idea to..." — announces a vague list instead of committing. Give the specific answer first.
- **Aphorism formulas**: fake-profound templates standing in for a real claim — "X is the new Y," "not a X but a Y," "the currency of trust." Cut the template, state the actual point.
- **Treadmill effect (low information density)**: a long passage that restates one idea in different words, often flagged by mid-paragraph "In other words," "Put simply," "Essentially." Apply a "what's actually new in this sentence?" test and cut restatements.
- **Generic positive conclusions**: "the future looks bright," "poised for growth," "a step in the right direction." End on a specific fact or an open question instead.
- **Typographic tells**: curly/smart quotes where the rest of the document uses straight quotes, or a rigidly perfect Oxford comma applied with no exceptions — match whatever typography the author already established rather than imposing one.
- **Title case headings** in a document that otherwise uses sentence case, or vice versa — match the existing convention.

---

# Audit report format

Use this structure when the task is to *report* findings rather than rewrite in place (e.g. "check this for AI-isms" as opposed to "fix this").

**Summary**: total instances found, breakdown by category.

**Findings**, one entry per instance, in the order they appear in the text:
- **Location**: line number, paragraph number, or a short locating quote
- **Category**: transition / buzzword / opener / hype / hedge / rhythm / structure
- **Quoted text**: the exact phrase or sentence
- **Fix**: a specific replacement, or an instruction ("cut," "rewrite as a direct statement," "vary sentence length here")

**Patterns**: after the per-instance list, name anything systemic — if a transition word recurs a dozen times, or every section opens with a definition, say so once rather than burying it in twelve separate findings. Patterns are more actionable than instance counts.

Don't flag: quoted or attributed speech (someone else's actual words), proper nouns, or a construction the piece's own style guide explicitly endorses. Don't flag isolated Tier 3 words, a single em dash, or one instance of anything that only becomes a problem as a cluster (see Guardrails in SKILL.md).

## Optional: a rough severity score

If the user wants a quick read on how AI-flavored a piece is (not a formal metric — a gut-check label), use:

| Findings density | Label |
|:--|:--|
| 0-1 per 500 words | Clean |
| 2-4 per 500 words | Minor tells, easy cleanup |
| 5-9 per 500 words | Mixed, reads like partial AI editing |
| 10+ per 500 words, or 3+ structural tells | Heavy AI smell |

Treat this as a signal for prioritizing fixes, not a verdict — a model scoring its own rewrite in the same pass tends to grade generously.
