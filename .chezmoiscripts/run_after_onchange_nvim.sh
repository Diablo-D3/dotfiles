#!/bin/sh

set -eu

# {{ div now.YearDay 7 }}

echo "-> nvim.sh"

if (command -v "nvim" >/dev/null 2>&1); then
    wget -q "https://raw.githubusercontent.com/neovim/neovim/refs/heads/master/contrib/nvim.bash" -O "${HOME}/.local/share/bash-completion/completions/nvim"
fi
