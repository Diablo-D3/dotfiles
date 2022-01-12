#!/usr/bin/env bash

if [ -v WSL ]; then
    _ln "$MODULE_HOME/config/streamlink" "$APPDATA/streamlink/"
fi
