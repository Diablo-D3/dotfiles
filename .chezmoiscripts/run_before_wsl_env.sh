#!/bin/sh

set -eu

_src="${CHEZMOI_SOURCE_DIR:?}"

case "${CHEZMOI_OS:?}" in
"linux")
    case "${CHEZMOI_KERNEL_OSRELEASE:?}" in
    *"microsoft"*)
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
        ;;
    *) ;;
    esac
    ;;
*) ;;
esac
