#!/bin/bash
set -euo pipefail
mkdir -p "$HOME/.claude"
git init -q -b main .
printf 'audit-out/\n.eval/\n' > .gitignore
printf '# Notes\n\nRun `make test` before committing.\n' > CLAUDE.md
printf 'test:\n\t@echo ok\n' > Makefile
git add -A
git commit -q -m 'Initial fixture'
