---
type: llm
focus: { source: file, path: audit-out/latest.md }
---

The text is a Claude Code setup audit report.

PASS if a finding reports that `docs/architecture.md`, named at CLAUDE.md:5, does not exist, citing the CLAUDE.md location and quoting the line.

FAIL if the missing path isn't reported, or the finding has no CLAUDE.md file:line location.
