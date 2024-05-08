#!/bin/sh

# shellcheck source-path=~/.local/share/chezmoi/.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

case "$CHEZMOI_OS" in
"Linux")
    case "$CHEZMOI_OSRELEASE" in
    *"microsoft"*)

        # steal envvars from Windows
        "${SRC:?}/src/wsl/stealenv.sh"

        if [ -f "${HOME}/.bashrc.win" ]; then
            . "${HOME}/.bashrc.win"
        fi

        # standard user directories
        ln -sT "${USERPROFILE:?}/Desktop" "${HOME}/Desktop"
        ln -sT "${USERPROFILE:?}/Documents" "${HOME}/Documents"
        ln -sT "${USERPROFILE:?}/Downloads" "${HOME}/Downloads"

        ;;
    esac
    ;;
esac
