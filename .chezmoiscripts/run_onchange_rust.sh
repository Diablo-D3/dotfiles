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

if ! (command -v "cargo-install-update" >/dev/null 2>&1); then
    cargo install cargo-update
fi

if (command -v "cargo-install-update" >/dev/null 2>&1); then
    cargo install-update -a
fi
