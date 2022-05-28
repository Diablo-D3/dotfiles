#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
    _ln "$module_home/config/streamlink/config" "$APPDATA/streamlink/config"
fi
