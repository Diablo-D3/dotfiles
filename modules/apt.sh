#!/usr/bin/env bash

if [ -x "/usr/bin/apt" ]; then
   _sudo _ln_descent "$MODULE_DIR/etc/apt" "/etc/apt/"
fi
