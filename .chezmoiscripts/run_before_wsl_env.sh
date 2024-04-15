#!/bin/sh
# shellcheck source-path=~/.local/share/chezmoi/.chezmoitemplates
. "${CHEZMOI_SOURCE_DIR}/.chezmoitemplates/install-lib"

case "$CHEZMOI_OS" in
"Linux")
    case "$CHEZMOI_OSRELEASE" in
    *"microsoft"*)

        # steal envvars from Windows
        "${SRC:?}/src/wsl/stealenv.sh"

        if [ -f "${HOME}/.bashrc.win" ]; then
            # shellcheck source=/dev/null
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
