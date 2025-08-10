#!/bin/sh

set -eu

# {{ div now.YearDay 7 }}

echo "-> rust.sh"

if ! (command -v "rustup" >/dev/null 2>&1); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

if (command -v "rustup" >/dev/null 2>&1); then
    rustup update
fi

if (command -v "cargo" >/dev/null 2>&1); then
    cargo install --list | cut -f 1 -d' ' | grep -v '^$' | while read -r crate; do
        cargo install "${crate}"
    done
fi
