#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

if [ ! -f "${HOME}/.terminfo/w/wezterm" ]; then
    target="$(mktemp)"

    wget -q "https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo" -O "${target}"

    if [ -s "${target}" ]; then
        tic -x -o "${HOME}/.terminfo" "${target}"
    fi

    rm -f "${target}"
fi

if [ "${_wsl:?}" = 0 ]; then
    mkdir -p "${USERPROFILE:?}/.config/wezterm"
    cp "${_src:?}/private_dot_config/wezterm/"* "${USERPROFILE:?}/.config/wezterm/"
fi
