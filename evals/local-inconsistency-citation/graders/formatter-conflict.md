---
type: llm
focus: { source: file, path: audit-out/latest.md }
---

The text is a Claude Code setup audit report.

PASS if a finding reports the conflict between AGENTS.md ("This project has no formatter") and CLAUDE.md ("Run `make fmt`"), cites both as file:line with quotes, and uses the git history (blame or commit dates) to say which is newer, identifying CLAUDE.md, the line backed by the Makefile `fmt:` target, as the more recent one.

FAIL if the conflict isn't reported, either side lacks a file:line citation, or the report gives no git-based ordering.
