#!/bin/sh

set -eu

# {{ output "date" "+%V" | trim }}

BASHC_DIR="${HOME}/.local/share/bash-completion/completions"
mkdir -p "${BASHC_DIR}"

if (command -v "chezmoi" >/dev/null 2>&1); then
    chezmoi completion bash >>"${BASHC_DIR}/chezmoi"
fi

if (command -v "fd" >/dev/null 2>&1); then
    fd --gen-completions bash >>"${BASHC_DIR}/fd"
fi

if (command -v "rg" >/dev/null 2>&1); then
    rg --generate=complete-bash >>"${BASHC_DIR}/rg"
fi

if (command -v "nvim" >/dev/null 2>&1); then
    wget -q "https://raw.githubusercontent.com/neovim/neovim/refs/heads/master/contrib/nvim.bash" -O "${BASHC_DIR}/nvim"
fi

if (command -v "rustup" >/dev/null 2>&1); then
    rustup completions bash >>"${BASHC_DIR}/rustup"
    rustup completions bash cargo >>"${BASHC_DIR}/cargo"
fi
