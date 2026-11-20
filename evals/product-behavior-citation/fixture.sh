#!/bin/bash
set -euo pipefail
mkdir -p "$HOME/.claude"
cat > "$HOME/.claude/settings.json" <<'JSON'
{
  "voice": { "enabled": true },
  "voiceEnabled": true,
  "fooBarSetting": true
}
JSON
git init -q -b main .
printf 'audit-out/\n' > .gitignore
printf '# Notes\n\nRun `make test` before committing.\n' > CLAUDE.md
printf 'test:\n\t@echo ok\n' > Makefile
git add -A
git commit -q -m 'Initial fixture'
