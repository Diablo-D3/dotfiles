#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_check "$0"

if [ "${_run}" -eq 0 ]; then
    _msg "Running kanata"

    # Local
    if (command -v "kanata" >/dev/null 2>&1); then
        if ! (groups | grep -wq 'input') || ! (groups | grep -wq 'uinput'); then
            _sudo usermod -aG input "${USER}"
            _sudo usermod -aG uinput "${USER}"
        fi

        _check "/etc/modules-load.d/kanata.conf"
        if [ "${check}" -eq 0 ]; then
            _sudo cp -v "${SRC:?}/src/kanata/kanata.conf" "/etc/modules-load.d/"
        fi

        _check "/etc/udev/rules.d/kanata.rules"
        if [ "${check}" -eq 0 ]; then
            _sudo cp -v "${SRC:?}/src/kanata/kanata.rules" "/etc/udev/rules.d/"
        fi
    fi

    # WSL2 host
    case "${CHEZMOI_OS:?}" in
    "linux")
        case "${CHEZMOI_KERNEL_OSRELEASE:?}" in
        *"microsoft"*)
            mkdir -p "${USERPROFILE:?}/kanata"
            cp "${SRC:?}/src/kanata/kanata.ps1" "${USERPROFILE:?}/kanata/"
            cp "${SRC:?}/src/kanata/"*".kbd" "${USERPROFILE:?}/kanata/"

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
            ;;
        *) ;;
        esac
        ;;
    *) ;;
    esac
fi
