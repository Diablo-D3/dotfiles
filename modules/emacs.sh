#!/usr/bin/env bash

DOOM="$HOME/.emacs.d/bin/doom"

declare -a DOOMDIRS
DOOMDIRS=("$HOME/.doom.d/")

if [ -n "$WSL" ]; then
    DOOMDIRS+=("$APPDATA/.doom.d/")
fi

for DOOMDIR in "${DOOMDIRS[@]}"; do
    if [ ! -d "$DOOMDIR" ]; then
        git clone --depth 1 "https://github.com/hlissner/doom-emacs" "$DOOMDIR"

        "$DOOM" -y install
    else
        "$DOOM" upgrade
    fi
done
