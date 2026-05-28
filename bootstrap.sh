#!/bin/bash

source ./utils.sh

options=(
    -avh --no-perms
    --exclude ".git"
    --exclude ".gitignore"
    --exclude "AGENTS.md"
    --exclude "README.md"
    --exclude "bootstrap.sh"
    --exclude "brew.sh"
    --exclude "macos.sh"
    --exclude "shell.sh"
    --exclude "utils.sh"
    --exclude "vscode.sh"
    --exclude ".vscode-extensions"
    --exclude "omf.fish"
)

# Retrieve all the gitignore file and directories that
# should be excluded from the rsync command
while read line; do
    options+=(--exclude "$line")
done <.gitignore

# Copy all the files and directories to the user home
# except for the ones included in the options array
fancy_echo "Copying the dotfiles to the home directory!"
rsync "${options[@]}" . ~

# Install brew with packages and applications
bash ./brew.sh
# Apply shell changes installing fish
bash ./shell.sh

# Update OMF plugins and aliases
fish ./omf.fish

# Install VS Code extensions from .vscode-extensions
bash ./vscode.sh

# macOS preferences are NOT applied automatically.
# They rebuild the Dock from scratch, so run them on-demand:
#   bash ./macos.sh
