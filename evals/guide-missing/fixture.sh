#!/bin/bash
# .eval/prompt-audit.md is deliberately not created.
set -euo pipefail
mkdir -p "$HOME/.claude"
git init -q -b main .
printf 'audit-out/\n.eval/\n' > .gitignore
printf '# Notes\n\nCRITICAL!!! You MUST ALWAYS think step by step before answering.\n\nRun `make test` before committing.\n' > CLAUDE.md
printf 'test:\n\t@echo ok\n' > Makefile
git add -A
git commit -q -m 'Initial fixture'
