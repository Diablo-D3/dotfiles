#!/usr/bin/env bash

if [ -v WSL ]; then
    _ln "$MODULE_HOME/config/streamlink/config" "$APPDATA/streamlink/config"
fi
