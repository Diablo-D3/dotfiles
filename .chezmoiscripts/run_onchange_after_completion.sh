#!/bin/sh

set -eu

# {{ div now.YearDay 7 }}

echo "-> completion.sh"

BASHC_DIR="${HOME}/.local/share/bash-completion/completions"
mkdir -p "${BASHC_DIR}"

FISHC_DIR="${HOME}/.config/fish/completions"
mkdir -p "${FISHC_DIR}"

if (command -v "chezmoi" >/dev/null 2>&1); then
    chezmoi completion bash >>"${BASHC_DIR}/chezmoi"
    chezmoi completion fish >>"${FISHC_DIR}/chezmoi.fish"
fi

if (command -v "fd" >/dev/null 2>&1); then
    fd --gen-completions bash >>"${BASHC_DIR}/fd"
    fd --gen-completions fish >>"${FISHC_DIR}/fd.fish"
fi

if (command -v "rg" >/dev/null 2>&1); then
    rg --generate=complete-bash >>"${BASHC_DIR}/rg"
    rg --generate=complete-fish >>"${FISHC_DIR}/rg.fish"
fi

if (command -v "nvim" >/dev/null 2>&1); then
    wget -q "https://raw.githubusercontent.com/neovim/neovim/refs/heads/master/contrib/nvim.bash" -O "${BASHC_DIR}/nvim"
    # fish: use built-in
fi

if (command -v "rustup" >/dev/null 2>&1); then
    rustup completions bash >>"${BASHC_DIR}/rustup"
    rustup completions bash cargo >>"${BASHC_DIR}/cargo"
    # fish: use built-in
fi
