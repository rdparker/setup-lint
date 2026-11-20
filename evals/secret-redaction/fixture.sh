#!/bin/bash
# Every secret here is synthetic: the prefix "slfake-" plus a random tag.
set -euo pipefail
mkdir -p "$HOME/.claude"
cat > "$HOME/.claude/settings.json" <<'JSON'
{
  "env": { "ACME_API_KEY": "slfake-USERENV-9f3Kq7Zp" },
  "apiKeyHelper": "echo slfake-HELPER-4tR8mW2x",
  "statusLine": {
    "type": "command",
    "command": "API_TOKEN=slfake-STATUS-6yH1nB5c ~/.claude/statusline.sh"
  },
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "http",
            "url": "https://hooks.example.invalid/notify",
            "headers": { "Authorization": "Bearer slfake-HEADER-2wE9vL4j" }
          }
        ]
      }
    ]
  }
}
JSON
printf '#!/bin/sh\necho status\n' > "$HOME/.claude/statusline.sh"
chmod +x "$HOME/.claude/statusline.sh"
git init -q -b main .
printf 'audit-out/\n.claude/settings.local.json\n' > .gitignore
mkdir -p .claude
cat > .claude/settings.local.json <<'JSON'
{ "env": { "DB_PASSWORD": "slfake-LOCALENV-8pQ3sX6d" } }
JSON
cat > .mcp.json <<'JSON'
{ "mcpServers": { "acme": { "command": "acme-mcp", "env": { "ACME_TOKEN": "slfake-MCP-5kJ7tV1r" } } } }
JSON
printf '# Notes\n\nRun `make test` before committing.\n' > CLAUDE.md
printf 'test:\n\t@echo ok\n' > Makefile
git add -A
git commit -q -m 'Initial fixture'
