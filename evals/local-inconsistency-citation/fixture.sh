#!/bin/bash
# AGENTS.md (older) says there is no formatter; CLAUDE.md (newer) says to run
# `make fmt`, which the Makefile defines. CLAUDE.md also names a missing doc.
set -euo pipefail
mkdir -p "$HOME/.claude"
git init -q -b main .
printf 'audit-out/\n' > .gitignore
cat > AGENTS.md <<'MD'
# Agent notes

This project has no formatter. Don't run one.
MD
git add -A
GIT_AUTHOR_DATE='2026-01-10T12:00:00Z' GIT_COMMITTER_DATE='2026-01-10T12:00:00Z' \
  git commit -q -m 'Add agent notes'
cat > CLAUDE.md <<'MD'
# Project notes

Run `make fmt` before committing.

The module map is in docs/architecture.md.
MD
printf 'fmt:\n\t@echo formatting\n' > Makefile
git add -A
GIT_AUTHOR_DATE='2026-03-05T12:00:00Z' GIT_COMMITTER_DATE='2026-03-05T12:00:00Z' \
  git commit -q -m 'Add formatter target'
