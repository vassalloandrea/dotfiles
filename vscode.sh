#!/bin/bash

source ./utils.sh

extensions_file=".vscode-extensions"

function install_vscode_extensions() {
    if ! command -v code >/dev/null 2>&1; then
        fancy_echo "VS Code 'code' command not found in PATH, skipping extensions install."
        return
    fi

    if [ ! -f "$extensions_file" ]; then
        fancy_echo "No $extensions_file file found, skipping."
        return
    fi

    fancy_echo "Installing VS Code extensions from $extensions_file"

    while IFS= read -r extension; do
        [ -z "$extension" ] && continue
        fancy_echo "Installing $extension"
        code --install-extension "$extension" --force
    done <"$extensions_file"
}

install_vscode_extensions
