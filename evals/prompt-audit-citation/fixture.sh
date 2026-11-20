#!/bin/bash
# Project: one CLAUDE.md with an over-emphatic instruction. User layer: empty.
set -euo pipefail
mkdir -p "$HOME/.claude"
git init -q -b main .
printf 'audit-out/\n' > .gitignore
cat > CLAUDE.md <<'MD'
# Project notes

CRITICAL!!! You MUST ALWAYS think step by step before answering.

Run `make test` before committing.
MD
printf 'test:\n\t@echo ok\n' > Makefile
git add -A
git commit -q -m 'Initial fixture'
