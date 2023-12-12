#!/usr/bin/env bash

if [ -n "${WSL+set}" ]; then
    _ln "$MODULE_HOME/config/streamlink/config" "$APPDATA/streamlink/config"
fi
