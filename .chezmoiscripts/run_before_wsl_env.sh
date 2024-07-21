#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

case "${CHEZMOI_OS:?}" in
"linux")
    case "${CHEZMOI_KERNEL_OSRELEASE:?}" in
    *"microsoft"*)

        # steal envvars from Windows
        "${SRC:?}/src/wsl/stealenv.sh"

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
    *)
        _quiet "Skipping wsl (before), not found"
        ;;
    esac
    ;;
*)
    _quiet "Skipping wsl (before), not found"
    ;;
esac
