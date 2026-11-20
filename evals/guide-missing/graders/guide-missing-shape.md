---
type: llm
focus: { source: file, path: audit-out/latest.md }
---

The text is a Claude Code setup audit report.

PASS if all of these hold:
- Near the top, the report says the prompt-audit guide (`prompt-audit.md`) is missing, naming the path and a Claude Code version.
- It shows two independent checks that the file is absent (for example a failed read and a directory listing or glob).
- Prompt-text (step 4) findings are marked "unverified" against prompt-audit patterns, and this is also reflected under "Not checked".
- The report does not describe the audit as following, or compatible with, the prompt-audit guide.

FAIL if any of these is missing.
