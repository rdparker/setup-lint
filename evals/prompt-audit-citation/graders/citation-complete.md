---
type: llm
focus: { source: file, path: audit-out/latest.md }
---

The text is a Claude Code setup audit report.

PASS if a finding quotes the CLAUDE.md line "CRITICAL!!! You MUST ALWAYS think step by step before answering." (or a recognizable part of it), gives its file:line location, and cites as its source the `claude-api` skill's `shared/prompt-audit.md`, naming a section, group or row of that guide and a Claude Code version number.

FAIL if no finding covers that line, or the finding's citation lacks the guide's file name, a section/group/row, or a Claude Code version.
