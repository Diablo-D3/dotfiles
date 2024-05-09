#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

if (command -v "cargo-install-update" >/dev/null 2>&1); then
    new=$(date +%s)
    state="${HOME}/.config/chezmoi/run_cargo.time"

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
        cargo install-update -a
    else
        printf "Skipping cargo\n"
    fi
else
    printf "Skipping cargo, cargo-install-update not found\n"
fi
