#!/bin/sh

# shellcheck source-path=~/.local/share/chezmoi/.chezmoitemplates
. "${CHEZMOI_SOURCE_DIR}/.chezmoitemplates/install-lib"

if [ ! -f "${HOME}/.terminfo/a/alacritty" ]; then
    wget -q "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info" -O "/tmp/alacritty.info"
    tic -x -o "${HOME}/.terminfo" "/tmp/alacritty.info"

    rm -f "/tmp/alacritty.info"
fi
