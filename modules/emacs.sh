#!/usr/bin/env bash

if [ ! -d "$HOME/.emacs.d" ]; then
    git clone --depth 1 "https://github.com/hlissner/doom-emacs" "$HOME/.emacs.d"
    doom install -y
    doom sync
else
    doom upgrade
    doom sync
fi
