#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_msg "Running wezterm"

if [ ! -f "${HOME}/.terminfo/w/wezterm" ]; then
    _quiet "Adding wezterm to terminfo db"
    wget -q "https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo" -O "/tmp/wezterm.info"
    tic -x -o "${HOME}/.terminfo" "/tmp/wezterm.info"

    rm -f "/tmp/wezterm.info"
else
    _quiet "Skipping, already done"
fi
