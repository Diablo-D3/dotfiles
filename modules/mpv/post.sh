#!/usr/bin/env bash

if [ -n "${WSL+set}" ]; then
   _stow "$MODULE_HOME/config/mpv" "$APPDATA/mpv/"
fi
