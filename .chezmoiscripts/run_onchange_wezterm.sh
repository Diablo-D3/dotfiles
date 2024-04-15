#!/bin/sh

# shellcheck source-path=~/.local/share/chezmoi/.chezmoitemplates
. "${CHEZMOI_SOURCE_DIR}/.chezmoitemplates/install-lib"

if [ ! -f "${HOME}/.terminfo/w/wezterm" ]; then
    wget -q "https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo" -O "/tmp/wezterm.info"
    tic -x -o "${HOME}/.terminfo" "/tmp/wezterm.info"

    rm -f "/tmp/wezterm.info"
fi
