#!/bin/sh

if [ ! -f "${HOME}/.terminfo/x/xterm-kitty" ]; then
    target="$(mktemp)"

    wget -q "https://raw.githubusercontent.com/kovidgoyal/kitty/refs/heads/master/terminfo/kitty.terminfo" -O "${target}"

    if [ -s "${target}" ]; then
        tic -x -o "${HOME}/.terminfo" "${target}"
    fi

    rm -f "${target}"
fi
