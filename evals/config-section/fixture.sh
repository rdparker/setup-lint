#!/bin/bash
# Project settings allow Bash(git:*), which makes Bash(git status:*) redundant.
set -euo pipefail
mkdir -p "$HOME/.claude"
git init -q -b main .
printf 'audit-out/\n.eval/\n' > .gitignore
mkdir -p .claude
cat > .claude/settings.json <<'JSON'
{
  "permissions": {
    "allow": ["Bash(git:*)", "Bash(git status:*)"]
  }
}
JSON
printf '# Notes\n\nRun `make test` before committing.\n' > CLAUDE.md
printf 'test:\n\t@echo ok\n' > Makefile
git add -A
git commit -q -m 'Initial fixture'
