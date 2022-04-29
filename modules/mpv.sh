#!/usr/bin/env bash

if [ -n "${WSL+set}" ]; then
   _ln_descent "$MODULE_HOME/config/mpv" "$APPDATA/mpv/"
fi

if [ ! -f "/etc/apt/trusted.gpg.d/deb-multimedia-keyring.gpg" ]; then
   _sudo apt update -oAcquire::AllowInsecureRepositories=true
   _sudo apt install deb-multimedia-keyring
fi
