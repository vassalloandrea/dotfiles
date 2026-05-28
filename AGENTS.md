# AGENTS.md

Guidance for AI coding agents working in this repository.

## What this repo is

Personal dotfiles and macOS bootstrap scripts for Andrea Vassallo. It is **not** a piece of application software — it is a collection of shell scripts and config files that configure a fresh macOS machine and the user's home directory.

Layout:

- `bootstrap.sh` — top-level orchestrator. Rsyncs the dotfiles into `~`, then chains the install scripts below.
- `brew.sh` — Homebrew packages and casks. Lists are active (uncommented) so a fresh-mac bootstrap actually installs everything.
- `shell.sh` — Sets fish as the login shell, installs Oh My Fish, configures `mise` (`ruby.compile=false`), installs runtimes (ruby/node/python/pnpm/yarn), configures fzf and global gitignore.
- `omf.fish` — Updates OMF packages/themes after `bootstrap.sh` syncs the config.
- `vscode.sh` — Reads `.vscode-extensions` and runs `code --install-extension` for each entry.
- `macos.sh` — `defaults write` invocations for Finder, Dock, hot corners, iTerm2. Disabled in `bootstrap.sh` by design (rebuilds the Dock); run manually when re-configuring a machine.
- `utils.sh` — Single helper: `fancy_echo`. Every script `source`s it.
- `.config/`, `.iterm2/`, `.gitconfig`, `.gitmessage`, `.gitignore_global`, `.editorconfig`, `.vimrc`, `.default-gems` — dotfiles that get rsynced into `~`. `.default-gems` is read by `mise`'s ruby backend (asdf-ruby compatible) to auto-install gems on every new Ruby version.
- `.vscode-extensions` — flat list of extension IDs (one per line), consumed by `vscode.sh`. Not a dotfile (not copied to `~`).
- `README.md` — human-facing setup guide + post-bootstrap manual steps. Not copied to `~`.

## Conventions

- **All shell scripts are bash** (`#!/bin/bash`) and start with `source ./utils.sh` to get `fancy_echo`. Match this when adding a new script.
- **User-facing log lines go through `fancy_echo`**, not raw `echo`/`printf`. Keeps output style consistent.
- **The package arrays in `brew.sh` are mostly commented out by design.** They document what was installed historically. When adding a new package, add it commented-out alongside the others; uncomment only when the user explicitly wants it installed on the next bootstrap.
- **Bootstrap is destructive to `~`.** `rsync -avh --no-perms` runs with `--exclude` for every script file and `.gitignore` entry. When adding a file that should *not* be copied to `~` (a script, a doc file, a manifest like `.vscode-extensions`), add it to the `--exclude` list in `bootstrap.sh`.
- **Fish is the shell.** Aliases, abbreviations, and functions live in `.config/omf/init.fish`. `balias` (from the OMF `balias` package) is preferred over `alias` because it exposes commands as both aliases and abbreviations.
- **`init.fish` is the canonical aliases file.** The `update_aliases` fish function copies it from this repo into `~/.config/omf/init.fish` and runs `omf update`. Edit this repo's copy, not the one in `~`.
- **Runtime version manager is `mise`** (formerly `asdf`). Activation happens in `.config/fish/config.fish`. Global tools are pinned via `mise use --global` in `shell.sh`.
- **`.tool-versions` is gitignored globally** (see `.gitignore_global`). Per-project runtime versions don't get committed.
- **`.gitconfig` sets `init.defaultBranch = main`** but the repo itself is on `master`. Don't "fix" this; both are intentional.

## Things to know before editing

- `macos.sh` is opinionated about the Dock. It wipes `persistent-apps` and rebuilds the bar from `persistent_applications`. Update the array in lockstep with what's actually on the user's Dock — the file is the source of truth for Dock layout on a fresh install.
- `.config/fish/config.fish` and `shell.sh` both reference `mise`. If you change the manager, both files must be updated together.
- `bootstrap.sh` does NOT call `macos.sh` — it's left as a documented on-demand step at the bottom of the script. Don't enable it without asking.
- `.vscode-extensions` is regenerated with `code --list-extensions > .vscode-extensions`. Commit changes when extensions actually change, not on every export.

## Post-bootstrap manual steps (documented in README.md)

These cannot be automated and live in `README.md` as a checklist:

- GitHub auth (`gh auth login`, `ssh-keygen` + add to GitHub)
- App logins (1Password/Bitwarden, Slack, etc.)
- `mise trust` per project for non-global `mise.toml`
- All terminal AI agents are now installed via brew (Claude Code is `claude-code` cask). No external installers needed.
- VS Code Settings Sync (extensions yes, settings/keybindings no)
- iTerm2 prefs only load after `macos.sh` runs (`LoadPrefsFromCustomFolder=true`)

## Testing changes

There is no test suite. To validate a change:

- Shell-syntax check: `bash -n script.sh` (or `fish -n` for fish).
- `shellcheck script.sh` if available.
- For `defaults write` changes in `macos.sh`, read the value back with `defaults read <domain> <key>` rather than running the full script.
- For brew additions, run the single `brew install <pkg>` command, not the whole script.

## Do not

- Do not run `bootstrap.sh` or any sub-script end-to-end without explicit user permission. They install software, change the login shell, and overwrite files in `~`.
- Do not commit `.tool-versions`, `.vscode/`, `.DS_Store`, `.env`, or `.bootstrap.log` (already gitignored — leave them alone).
- Do not introduce a new "framework" or rewrite the scripts into a config-management tool (chezmoi, stow, ansible, etc.) unless asked. The user has chosen plain bash + rsync deliberately.
- Do not add `set -e`/`set -u`/strict-mode boilerplate to existing scripts unprompted. The current "best-effort, keep going on failure" behavior is intentional for a bootstrap script that may be re-run on partial state.
