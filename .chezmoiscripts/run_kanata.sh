#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_check "${_scripts}/run_kanata.sh"
if [ "${_run}" -eq 0 ]; then
    _checksum "${_scripts}/run_kanata.sh"

    # Local
    if (command -v "kanata" >/dev/null 2>&1); then
        if ! (groups | grep -wq 'input') || ! (groups | grep -wq 'uinput'); then
            _sudo usermod -aG input "${USER}"
            _sudo usermod -aG uinput "${USER}"
        fi

        kanata_conf="/etc/modules-load.d/kanata.conf"
        _check "${kanata_conf}"
        if [ "${_run}" -eq 0 ]; then
            _sudo cp -v "${_src:?}/src/kanata/kanata.conf" "${kanata_conf}"
            _checksum "${kanata_conf}"
        fi

        kanata_rules="/etc/udev/rules.d/kanata.rules"
        _check "${kanata_rules}"
        if [ "${_run}" -eq 0 ]; then
            _sudo cp -v "${_src:?}/src/kanata/kanata.rules" "${kanata_rules}"
            _checksum "${kanata_rules}"
        fi
    fi

    # WSL2 host
    if [ "${_wsl:?}" = 0 ]; then
        mkdir -p "${USERPROFILE:?}/kanata"
        cp "${_src:?}/src/kanata/kanata.ps1" "${USERPROFILE:?}/kanata/"
        cp "${_src:?}/src/kanata/"*".kbd" "${USERPROFILE:?}/kanata/"

        kanata_exe="${USERPROFILE:?}/kanata/kanata.exe"
        _check "${kanata_exe}"
        if [ "${_run}" -eq 0 ]; then
            _gh_dl "jtroo" "kanata" "kanata_winIOv2.exe" "browser_download_url"

            if [ -s "${_target}" ]; then
                cp "${_target}" "${kanata_exe}"
                _checksum "${kanata_exe}"
            fi
        fi

        interception_zip="${USERPROFILE:?}/kanata/interception.zip"
        _check "${interception_zip}"
        if [ "${_run}" -eq 0 ]; then
            _gh_dl "oblitum" "Interception" "Interception.zip" "browser_download_url"

            if [ -s "${_target}" ]; then
                cp "${_target}" "${interception_zip}"
                _checksum "${interception_zip}"
            fi
        fi
    fi

    _checksum "${_scripts}/run_kanata.sh"
fi
