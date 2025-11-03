#!/usr/bin/env bash

set -euo pipefail

# Get the tmux pane's working directory (if inside tmux)
if [[ -n "${TMUX:-}" ]]; then
    cd "$(tmux display -p "#{pane_current_path}")"
fi

# Pipe the list of files to fzf, storing the selection in a variable.
selected_file=$(find . \( -path './node_modules' -o -path '*/.git' \) -prune -o -type f -print | fzf)

# Check if a file was actually selected
if [ -n "$selected_file" ]; then
    # Open the selected file in Neovim
    nvim "$selected_file"
fi
