# dotfiles

Personal macOS bootstrap for a fresh machine.

## What gets installed

- **CLI**: fish, mise, gh, lazygit, fzf, ripgrep, the_silver_searcher, coreutils, gawk, neovim, shfmt, imagemagick@6, ffmpeg
- **Apps (brew cask)**: iTerm2, VS Code, Brave, Bitwarden, Slack, Telegram, Spark Desktop, Fantastical, Linear, TickTick, Obsidian, Notion, Raycast, AppCleaner, BetterDisplay, Hidden Bar, ImageOptim, Gifox, Claude, Claude Code, Postman, Docker, Tailscale, Mullvad VPN
- **Font**: JetBrains Mono Nerd
- **Runtimes (via mise)**: ruby 3.1.1, node lts, python 3.13.2, pnpm latest, yarn 1.x
- **Default gems** (re-installed for every new Ruby): bundler, pry, foreman
- **Shell**: fish + Oh My Fish + balias package + sushi theme
- **VS Code extensions**: 34 extensions listed in `.vscode-extensions`

## Setup a fresh Mac

```bash
# 1. Install Xcode Command Line Tools (needed for git + compilers)
xcode-select --install

# 2. Clone this repo
git clone https://github.com/<your-user>/dotfiles.git ~/projects/personal/dotfiles
cd ~/projects/personal/dotfiles

# 3. Run the bootstrap
./bootstrap.sh
```

`bootstrap.sh` runs in this order:

1. `rsync` dotfiles → `~`
2. `brew.sh` — Homebrew + packages + casks + font
3. `shell.sh` — fish login shell, OMF, mise runtimes, fzf, gitignore globale
4. `omf.fish` — OMF plugins/theme reload
5. `vscode.sh` — VS Code extensions from `.vscode-extensions`

**`macos.sh` is NOT run automatically** (it rebuilds the Dock from scratch). Run on-demand:

```bash
bash ./macos.sh
```

## Manual steps after bootstrap

Things that can't (or shouldn't) be automated:

### Authentication

- [ ] `gh auth login` — authenticate GitHub CLI
- [ ] `ssh-keygen -t ed25519 -C "andrea.vassallo.94@gmail.com"` + add to GitHub
- [ ] Sign in to: 1Password/Bitwarden, Slack, Telegram, Spark, Fantastical, Linear, TickTick, Obsidian, Raycast, Tailscale, Mullvad
- [ ] App Store login (if needed for App Store-only apps)

### Per-project mise

- [ ] `cd <project>` then `mise trust` to allow project-level `mise.toml`/`.tool-versions`

### VS Code Settings Sync

VS Code extensions are reinstalled via `vscode.sh`, but **settings, keybindings, and snippets** are not. Enable VS Code Settings Sync (Account icon → Turn on Settings Sync) before reinstalling to back them up.

### iTerm2 preferences

The `~/.iterm2/com.googlecode.iterm2.plist` is in this repo, but **iTerm2 loads it only after `macos.sh` runs** (it sets `LoadPrefsFromCustomFolder=true` and points to `~/.iterm2`).

After `bash ./macos.sh`, restart iTerm2 to pick up the prefs.

## Updating

```fish
update_aliases    # sync this repo's init.fish → ~/.config/omf/init.fish, reload
```

To update the apps list / brew packages / dock apps, edit the relevant `.sh` file and re-run it.

## Formatting

```fish
shfmt -i 4 -ci -w *.sh
fish_indent -w .config/fish/config.fish .config/omf/init.fish omf.fish
```

## More context for AI agents

See [AGENTS.md](AGENTS.md).
