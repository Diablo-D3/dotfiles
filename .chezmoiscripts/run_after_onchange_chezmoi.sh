#!/bin/sh

set -eu

# {{ div now.YearDay 7 }}

echo "-> chezmoi.sh"

if (command -v "chezmoi" >/dev/null 2>&1); then
    chezmoi completion bash >>"${HOME}/.local/share/bash-completion/completions/chezmoi"
fi
