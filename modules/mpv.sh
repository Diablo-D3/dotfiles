#!/usr/bin/env bash

if [ -v WSL ]; then
   _ln_descent "$MODULE_HOME/config/mpv" "$APPDATA/mpv/"
fi

if [ -x "/usr/bin/apt" ]; then
   _sudo _ln_descent "$MODULE_DIR/etc/apt" "/etc/apt/"
fi

if [ ! -f "/etc/apt/trusted.gpg.d/deb-multimedia-keyring.gpg" ]; then
   _sudo apt update -oAcquire::AllowInsecureRepositories=true
   _sudo apt install deb-multimedia-keyring
fi
