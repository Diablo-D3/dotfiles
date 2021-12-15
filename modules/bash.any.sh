#!/usr/bin/env bash

_ln "$MODULE_DIR/bashrc" "$HOME/.bashrc"
_ln "$MODULE_DIR/bash_profile" "$HOME/.bash_profile"

_mkdir "$HOME/.terminfo/x"
_ln "$MODULE_DIR/xterm-24bits" "$HOME/.terminfo/x/xterm-24bits"
