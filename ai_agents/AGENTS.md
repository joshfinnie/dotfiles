# global agent instructions

## Package Managers

- Always use **pnpm** for Node.js/JavaScript projects.
  Never use `npm` or `yarn` unless the project explicitly requires it (e.g., a `package-lock.json` with no `pnpm-lock.yaml`).

## Overall Recommendations

- Never use the em dash "—".
- When writing commit messages, NEVER auto-add your agent name as co-author
- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated
- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability.
- When doing bug fixes, always start with reproducing the bug in an E2E setting as closely aligned with how an end user would experience it as possible.
  This makes sure you find the real problem so your fix will actually solve it.
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.
  If something clearly looks off, even if it is not directly related to what you are doing, try to get it fixed along the way.
- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness.
  If you see one, even if it is not caused by what you are working on right now, still get it fixed.
- Do NOT add arbitrary or redundant comments to code.

## Context and Tool Use

- Narrow reads with deterministic CLI tools.
- Use `rg -n <pattern> <path>` for exact matches.
- Read only relevant symbols or line ranges.
- Review edits with `git diff -- <path>`.
- Prefer syntax-aware tools for bulk edits.
- Use `ast-grep` for structural rewrites.
- Use `fastmod` for safe string replacements.
- Use `repomap.md` if available.
