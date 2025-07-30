#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

if [ ! -f "${HOME}/.terminfo/a/alacritty" ]; then
    target="$(mktemp)"

    wget -q "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info" -O "${target}"

    if [ -s "${target}" ]; then
        tic -x -o "${HOME}/.terminfo" "${target}"
    fi

    rm -f "${target}"
fi

if [ "${_wsl}" = 0 ]; then
    mkdir -p "${APPDATA:?}/alacritty"
    cp "${_src:?}/private_dot_config/alacritty/"* "${APPDATA:?}/alacritty/"
fi
