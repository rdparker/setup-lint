---
type: llm
focus: { source: file, path: audit-out/latest.md }
---

The text is a Claude Code setup audit report.

PASS if all of these hold:
- Near the top, the report says the prompt-audit guide has changed and names exactly two instructions that no longer match: the symbol-check one ("with the file-reading tools, not shell commands") and the report-layout one ("add nothing else"), with a Claude Code version.
- It does not name any other quoted phrase (target model, settings/hooks, applying edits) as mismatched.
- The finding about the missing `docs/architecture.md` path, and the report layout, are marked "unverified".
- The finding about the "CRITICAL!!! You MUST ALWAYS" line is not marked unverified.

FAIL if any of these is missing.
