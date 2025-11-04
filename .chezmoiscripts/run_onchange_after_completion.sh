#!/bin/sh

set -eu

# {{ div now.YearDay 7 }}

echo "-> completion.sh"
if (command -v "chezmoi" >/dev/null 2>&1); then
    chezmoi completion bash >>"${HOME}/.local/share/bash-completion/completions/chezmoi"
fi

if (command -v "fd" >/dev/null 2>&1); then
    fd --gen-completions bash >>"${HOME}/.local/share/bash-completion/completions/fd"
fi

if (command -v "rg" >/dev/null 2>&1); then
    rg --generate=complete-bash >>"${HOME}/.local/share/bash-completion/completions/rg"
fi

if (command -v "nvim" >/dev/null 2>&1); then
    wget -q "https://raw.githubusercontent.com/neovim/neovim/refs/heads/master/contrib/nvim.bash" -O "${HOME}/.local/share/bash-completion/completions/nvim"
fi

if (command -v "rustup" >/dev/null 2>&1); then
    rustup update

    rustup completions bash >>"${HOME}/.local/share/bash-completion/completions/rustup"
    rustup completions bash cargo >>"${HOME}/.local/share/bash-completion/completions/cargo"
fi
