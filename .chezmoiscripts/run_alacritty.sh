#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_msg "Running alacritty"

if [ ! -f "${HOME}/.terminfo/a/alacritty" ]; then
    _quiet "Adding alacritty to terminfo db"

    wget -q "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info" -O "/tmp/alacritty.info"
    tic -x -o "${HOME}/.terminfo" "/tmp/alacritty.info"

    rm -f "/tmp/alacritty.info"
else
    _quiet "Skipping, already done"
fi
