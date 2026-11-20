#!/bin/bash
set -euo pipefail
mkdir -p "$HOME/.claude"
git init -q -b main .
printf 'audit-out/\n.eval/\n' > .gitignore
mkdir -p .claude/skills/table-fmt
cat > .claude/skills/table-fmt/SKILL.md <<'MD'
---
name: table-fmt
description: Formats markdown tables.
---

Align the columns of every Markdown table in the file the user names.
MD
printf '# Notes\n\nRun `make test` before committing.\n' > CLAUDE.md
printf 'test:\n\t@echo ok\n' > Makefile
git add -A
git commit -q -m 'Initial fixture'
