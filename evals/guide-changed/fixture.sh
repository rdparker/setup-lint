#!/bin/bash
# The CLAUDE.md names a missing path (a check that depends on the symbol-check
# override) and has an over-emphatic line (a check that does not).
set -euo pipefail
mkdir -p "$HOME/.claude"
git init -q -b main .
printf 'audit-out/\n.eval/\n' > .gitignore
printf '# Notes\n\nCRITICAL!!! You MUST ALWAYS think step by step before answering.\n\nThe module map is in docs/architecture.md.\n' > CLAUDE.md
printf 'test:\n\t@echo ok\n' > Makefile
git add -A
git commit -q -m 'Initial fixture'
