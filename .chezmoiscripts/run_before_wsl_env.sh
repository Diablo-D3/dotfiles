#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

if [ "${_wsl}" = 0 ]; then
    # steal envvars from Windows
    "${_src:?}/src/wsl/stealenv.sh"

    # load again
    if [ -f "${HOME}/.bashrc.win" ]; then
        . "${HOME}/.bashrc.win"
    fi

    # standard user directories
    if [ ! -d "${HOME}/Desktop" ]; then
        ln -sT "${USERPROFILE:?}/Desktop" "${HOME}/Desktop"
    fi

    if [ ! -d "${HOME}/Documents" ]; then
        ln -sT "${USERPROFILE:?}/Documents" "${HOME}/Documents"
    fi

    if [ ! -d "${HOME}/Downloads" ]; then
        ln -sT "${USERPROFILE:?}/Downloads" "${HOME}/Downloads"
    fi
fi
