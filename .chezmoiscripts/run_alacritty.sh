#!/bin/sh

set -eu

if [ ! -f "${HOME}/.terminfo/a/alacritty" ]; then
    target="$(mktemp)"

    wget -q "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info" -O "${target}"

    if [ -s "${target}" ]; then
        tic -x -o "${HOME}/.terminfo" "${target}"
    fi

    rm -f "${target}"
fi
