#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_check "$0"

if [ "${_run}" -eq 0 ]; then
    mkdir -p "${HOME}/.local/share/fonts"

    _gh_dl "be5invis" "iosevka" "SuperTTC-Iosevka-VER.zip" "browser_download_url"

    if [ -s "${_target}" ]; then
        unzip -qqjo "${_target}" "*ttc" -d "${HOME}/.local/share/fonts"
        rm -f "${_target}"
    fi

    _gh_dl "be5invis" "iosevka" "SuperTTC-IosevkaAile-VER.zip" "browser_download_url"

    if [ -s "${_target}" ]; then
        unzip -qqjo "${_target}" "*ttc" -d "${HOME}/.local/share/fonts"
        rm -f "${_target}"
    fi
fi
