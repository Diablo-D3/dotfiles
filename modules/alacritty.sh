#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
    _ln "$module_home/alacritty.yml" "$APPDATA/alacritty/alacritty.yml"
fi
