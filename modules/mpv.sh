#!/usr/bin/env bash

if [ -n "${wsl+set}" ]; then
   _ln_descent "$module_home/config/mpv" "$APPDATA/mpv/"
fi

if [ ! -f "/etc/apt/trusted.gpg.d/deb-multimedia-keyring.gpg" ]; then
   _sudo apt update -oAcquire::AllowInsecureRepositories=true
   _sudo apt install deb-multimedia-keyring
fi
