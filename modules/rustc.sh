#!/usr/bin/env bash

_mkdir ~/.cargo/bin
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.cargo/bin/rust-analyzer
chmod +x ~/.cargo/bin/rust-analyzer

if [ -x "/usr/bin/apt" ]; then
   _sudo _ln_descent "$MODULE_DIR/etc/apt" "/etc/apt/"
fi
