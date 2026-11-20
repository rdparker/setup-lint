---
type: llm
focus: { source: file, path: audit-out/latest.md }
---

The text is a Claude Code setup audit report.

PASS if a finding about the `voiceEnabled` setting cites a code.claude.com docs URL and quotes the docs, for example that it is deprecated and that `voice.enabled` applies when both are set.

FAIL if `voiceEnabled` isn't mentioned, or the finding gives no docs URL or no quote.
