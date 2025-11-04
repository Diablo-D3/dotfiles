#!/bin/sh

set -eu

# {{ div now.YearDay 7 }}

echo "-> rg.sh"

if (command -v "rg" >/dev/null 2>&1); then
    rg --generate=complete-bash >>"${HOME}/.local/share/bash-completion/completions/rg"
fi
