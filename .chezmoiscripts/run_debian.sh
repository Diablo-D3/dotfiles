#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_msg "Running debian"

case "${CHEZMOI_OS:?}" in
"linux")
    case "${CHEZMOI_OS_RELEASE_ID:?}" in
    "debian")
        new=$(date +%s)
        state="${HOME}/.config/chezmoi/run_debian.time"

        check=1

        if [ ! -e "${state}" ]; then
            printf "%s" "${new}" >"${state}"
            check=0
        else
            old=$(cat "${state}")

            if [ "${new}" -gt $((old + 86400)) ]; then
                printf "%s" "${new}" >"${state}"
                check=0
            fi
        fi

        if [ "${check}" -eq 0 ]; then
            _sudo cp -v "${SRC:?}/src/debian/preferences.d/pin-stable" "/etc/apt/preferences.d/"
        else
            _quiet "Skipping, ran recently"
        fi
        ;;
    *)
        _quiet "Skipping, not Debian"
    ;;
    esac
    ;;
*)
    _quiet "Skipping, not Debian"
;;
esac
