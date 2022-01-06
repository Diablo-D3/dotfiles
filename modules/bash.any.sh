#!/usr/bin/env bash

_ln "$MODULE_DIR/bashrc" "$HOME/.bashrc"
_ln "$MODULE_DIR/bash_profile" "$HOME/.bash_profile"

_mkdir "$HOME/.terminfo/x"
_ln "$MODULE_DIR/xterm-emacs" "$HOME/.terminfo/x/xterm-emacs"

for bin in "$MODULE_DIR/bin/"*; do
    _ln "$bin" "$HOME/bin/$(basename $bin)"
done
