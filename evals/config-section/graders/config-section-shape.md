---
type: llm
focus: { source: file, path: audit-out/latest.md }
---

The text is a Claude Code setup audit report.

PASS if all of these hold:
- There is a "Configuration findings" section separate from, and after, the prompt-text findings.
- It reports that `Bash(git status:*)` in .claude/settings.json is shadowed by, or redundant with, `Bash(git:*)`, with a file:line location.
- Its findings are ordered by confidence, highest first.
- The configuration items that had no finding are listed at the end of that section, each marked "clean" (a short reason after the word is fine).

FAIL if any of these is missing.
