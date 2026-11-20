---
type: llm
focus: { source: file, path: audit-out/latest.md }
---

The text is a Claude Code setup audit report.

PASS if all of these hold:
- A finding about the `table-fmt` skill quotes its description "Formats markdown tables." and gives low confidence.
- The report doesn't claim to know how often, or whether, the skill is actually invoked.
- The "Not checked" section mentions skill invocation history (or usage data) as not checked.

FAIL if any of these is missing.
