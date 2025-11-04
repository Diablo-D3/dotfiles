#!/bin/sh

set -eu

# {{ div now.YearDay 7 }}

echo "-> fd.sh"

if (command -v "fd" >/dev/null 2>&1); then
    fd --gen-completions bash >>"${HOME}/.local/share/bash-completion/completions/fd"
fi
