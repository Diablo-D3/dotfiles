#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_msg "Running sshd"

if [ -d "/etc/ssh/sshd_config.d/" ]; then
    new=$(date +%s)
    state="${HOME}/.config/chezmoi/run_sshd.time"

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
        _sudo cp -v "${SRC:?}/src/sshd/custom.conf" "/etc/ssh/sshd_config.d/custom.conf"
    else
        _quiet "Skipping, done recently"
    fi
fi
