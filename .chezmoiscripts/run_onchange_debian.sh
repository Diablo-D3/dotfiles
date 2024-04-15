#!/bin/sh

# shellcheck source-path=~/.local/share/chezmoi/.chezmoitemplates
. "${CHEZMOI_SOURCE_DIR}/.chezmoitemplates/install-lib"

case "$CHEZMOI_OS" in
"linux")
    case "$CHEZMOI_OS_RELEASE_ID" in
    "debian")
        _sudo cp "${SRC:?}/src/debian/pin-stable" "/etc/apt/preferences.d/"
        ;;
    esac
    ;;
esac
