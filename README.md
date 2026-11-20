# Setup Lint

A Claude Code plugin that audits the Claude Code setup of the project you're in, plus your user-level config directory, against Anthropic's current documentation and prompting guide. It is read-only: it writes one report with a proposed diff, and you apply the hunks you choose.

Every finding cites the line it's about, quoted, and the source it conflicts with:

- **Product behavior** (what Claude Code or a model does): the official docs page, by URL, with a quote.
- **A local inconsistency** (a stale path, two files that disagree): the other file and line, quoted.
- **A prompt-writing pattern**: the prompt-audit guide bundled with Claude Code's `claude-api` skill, by section, with the Claude Code version it came from.

A claim that a setting, field or command doesn't exist is backed by two independent checks, and the report shows both.

## Install

Setup Lint relies on the `claude-api` skill that ships with Claude Code, and on its prompt-audit guide. It was tested with Claude Code 2.1.329. If a later version moves or rewords that guide, the report says so at the top and marks the checks that depended on it "unverified".

```
/plugin marketplace add rdparker/setup-lint
/plugin install setup-lint@setup-lint
```

Or both in one step (Claude Code v2.1.275 or later):

```
/plugin install setup-lint --marketplace rdparker/setup-lint
```

## Use

```
/setup-lint:audit [target model] [config-dir=<path>] [report-dir=<path>]
```

All arguments are optional.

- **Target model**, such as `fable` or `opus`: the model whose prompting guide the text is checked against. Default: `model` from your settings, else the model running the session.
- **`config-dir=`**: the Claude Code config directory to audit. Default: `$CLAUDE_CONFIG_DIR`, else `~/.claude`.
- **`report-dir=`**: where to write the report. Default: `$SETUP_LINT_DIR`, else `${XDG_STATE_HOME:-~/.local/state}/setup-lint` (`%LOCALAPPDATA%\setup-lint` on Windows).

The skill runs only when you type it: Claude doesn't invoke it on its own, so it adds nothing to your sessions' context until you do.

The report is named `<project-path-slug>-<YYYY-MM-DDTHHMM>Z.md`. It quotes your user-level files, so it is never written inside a git repository, unless that repository ignores the report folder. When the folder is inside a repo that doesn't ignore it, Claude asks you where to write instead.

## What it reads, runs, writes and sends

- **Reads**
  - In the config directory: `CLAUDE.md` and the files it imports; `settings.json`, but only the keys the audit checks; agents, skills, commands, rules and output styles; the hook scripts your settings reference; and this project's auto-memory folder.
  - In the project: `CLAUDE.md`, `CLAUDE.local.md` and `AGENTS.md` at any depth outside dependency folders; the `CLAUDE.md` files in parent directories; and `.claude/` settings, agents, skills, commands and rules.
  - From each enabled plugin, only its skill names and descriptions, to count context load.
  - The `claude-api` skill's `shared/prompt-audit.md` and `shared/live-sources.md`, both bundled with Claude Code.
- **Never reads** `.mcp.json` or credential files. They're listed by path only.
- **Runs** only commands that read: `git rev-parse`, `git --no-optional-locks status`, `git grep -n -F` and `git blame`, `grep`, `wc`, and `claude --help` or a string search of the installed `claude` binary when it checks whether something exists. It also uses `mktemp`, `rm --` and `rmdir`, only on its own temporary files.
- **Never runs** hooks, MCP servers, project scripts, build tools, package managers, or anything it finds in the project. Tools that change state when they run are read through their files instead.
- **Writes** one report file. Temporary files, if any, are deleted before the report is written; if a delete fails, the report lists what's left and why. It never edits your configuration; the diff is a proposal.
- **Sends** nothing about you. Its only network requests fetch public documentation pages from `code.claude.com` and `platform.claude.com`, or use the Claude Platform docs MCP server if you have it.

Secrets, tokens, keys and email addresses appear as `[hidden]` in the report and the chat summary. That keeps them out of the report; it doesn't keep them out of the session. Any file Claude reads is in its context, as in any session.

## How it differs from Setup Audit

[Setup Audit](https://github.com/senzelden/claude-setup-audit) is an unrelated third-party plugin with a broader scope. It reads usage and transcript data, MCP server configuration, deny rules and sandbox posture, checks whether a repo is ready for Claude Code, and applies the fixes you approve, with backups, through bundled Python scripts.

Setup Lint is narrower:

- It has no scripts and applies nothing.
- It focuses on the text that reaches the model and on configuration correctness, with a citation for every finding.
- It checks prompt text against Anthropic's prompt-audit guide and the target model's prompting guide.
- It doesn't read transcripts, usage data or `.mcp.json`.

The two complement each other. When Setup Audit is enabled, the report's "Not checked" section suggests a read-only Setup Audit run for the areas Setup Lint leaves out.

## Evals

`evals/` holds cases for [`claude plugin eval`](https://code.claude.com/docs/en/plugin-evals.md). Each one builds a small fixture project with a scaffold script, runs `/setup-lint:audit config-dir=~/.claude report-dir=./audit-out` against it, and checks the report. A note appended to the system prompt asks Claude to copy the report to `audit-out/latest.md` for the graders. A few cases add a test condition there too, such as a temporary file locked against deletion, or a prompt-audit guide that is missing or reworded. All secrets in the fixtures are synthetic.

Run them from the repository root:

```
claude plugin eval . --scaffold --ablation none --runs 1 \
  --allow-tools Bash Write "WebFetch(domain:code.claude.com)" "WebFetch(domain:platform.claude.com)"
```

- **`--scaffold`** runs the fixture scripts. Read them first; they only write files and make git commits inside the run's workspace.
- **`--ablation none`** is needed because the skill runs only when typed, so a run without the plugin has nothing to compare.
- **Cost.** Each run is a full audit, including the documentation fetches, so a pass over the whole suite costs real usage. Use `--case <name>` to run one case, and `--max-cost-usd` to set a ceiling.

## License

MIT. See [LICENSE](LICENSE).
