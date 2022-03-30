#!/usr/bin/env bash

if [ -x "/usr/bin/apt" ]; then
   _sudo _ln_descent "$MODULE/etc/apt" "/etc/apt/"
fi
