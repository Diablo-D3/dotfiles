#!/bin/sh

set -eu

# {{ output "date" "+%V" | trim }}

if ! (command -v "rustup" >/dev/null 2>&1); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    rustup component add rust-analyzer
    rustup component add clippy
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
