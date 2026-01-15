#!/bin/sh

set -eu

if [ ! -f "${HOME}/.terminfo/w/wezterm" ]; then
    target="$(mktemp)"

    wget -q "https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo" -O "${target}"

    if [ -s "${target}" ]; then
        tic -x -o "${HOME}/.terminfo" "${target}"
    fi

    rm -f "${target}"
fi
