#!/usr/bin/env bash

if [ -v WSL ]; then
   _ln_descent "$MODULE_HOME/config/mpv" "$APPDATA/mpv/"
fi
