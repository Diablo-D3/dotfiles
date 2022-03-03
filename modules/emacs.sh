#!/usr/bin/env bash

EMACSD="$HOME/.emacs.d"
DOOMD="$HOME/.doom.d"
DOOM="$EMACSD/bin/doom"

if [ ! -d "$HOME/${EMACSD}" ]; then
    git clone --depth 1 "https://github.com/hlissner/doom-emacs" "${EMACSD}"
    "$DOOM" -y install --no-fonts
    "$DOOM" sync
else
    git -c "$EMACSD" pull --rebase
    "$DOOM" clean
    "$DOOM" sync -u -p
fi

exit 0
