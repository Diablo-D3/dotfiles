#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_check "$0"

if [ "${_run}" -eq 0 ]; then
    # Local
    if (command -v "kanata" >/dev/null 2>&1); then
        if ! (groups | grep -wq 'input') || ! (groups | grep -wq 'uinput'); then
            _sudo usermod -aG input "${USER}"
            _sudo usermod -aG uinput "${USER}"
        fi

        _check "${_src:?}/kanata/kanata.conf"
        if [ "${_run}" -eq 0 ]; then
            _sudo cp -v "${_src:?}/src/kanata/kanata.conf" "/etc/modules-load.d/"
        fi

        _check "${_src:?}/src/kanata/kanata.rules"
        if [ "${_run}" -eq 0 ]; then
            _sudo cp -v "${_src:?}/src/kanata/kanata.rules" "/etc/udev/rules.d/"
        fi
    fi

    # WSL2 host
    if [ "${_wsl:?}" = 0 ]; then
        mkdir -p "${USERPROFILE:?}/kanata"
        cp "${_src:?}/src/kanata/kanata.ps1" "${USERPROFILE:?}/kanata/"
        cp "${_src:?}/src/kanata/"*".kbd" "${USERPROFILE:?}/kanata/"

        _check "${USERPROFILE:?}/kanata.exe.new"
        if [ "${_run}" -eq 0 ]; then
            _gh_dl "jtroo" "kanata" "kanata_winIOv2.exe" "browser_download_url"

            if [ -s "${_target}" ]; then
                cp "${_target}" "${USERPROFILE:?}/kanata/interception.zip"
            fi
        fi

        _check "${USERPROFILE:?}/kanata/interception.zip"
        if [ "${_run}" -eq 0 ]; then
            _gh_dl "oblitum" "Interception" "Interception.zip" "browser_download_url"

            if [ -s "${_target}" ]; then
                cp "${_target}" "${USERPROFILE:?}/kanata/interception.zip"
            fi
        fi
    fi
fi
