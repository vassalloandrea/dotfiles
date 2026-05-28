if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

mise activate fish | source

# uv
fish_add_path "$HOME/.local/bin"
