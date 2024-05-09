#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

if (command -v "helix" >/dev/null 2>&1); then
    new=$(date +%s)
    state="${HOME}/.config/chezmoi/run_helix.time"

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
        mkdir -p "${HOME}/.local/bin"
        _gh_dl "helix-editor" "helix" "helix-VER-x86_64.AppImage" "/tmp/helix"

        if [ -f "/tmp/helix" ]; then
            mkdir -p "${HOME}/.local/bin"
            chmod u+x "/tmp/helix"
            mv "/tmp/helix" "${HOME}/.local/bin/helix"
        fi
    else
        printf "Skipping helix\n"
    fi
else
    print "Skipping helix, not found\n"
fi
