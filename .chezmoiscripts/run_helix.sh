#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_msg "Running helix"

if (command -v "hx" >/dev/null 2>&1) || [ -d "${HOME}/src/helix" ]; then
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
        if [ -d "${HOME}/src/helix" ]; then
            pwd="$(pwd)"
            cd "${HOME}/src/helix" || exit
            git pull
            HELIX_DEFAULT_RUNTIME="${HOME}/src/helix/runtime" cargo build --profile opt --locked
            ln -sfv "${HOME}/src/helix/target/opt/hx" "${HOME}/.local/bin"
            cd "${pwd}" || exit
        else
            _gh_dl "helix-editor" "helix" "helix-VER-x86_64.AppImage" "browser_download_url" "/tmp/helix.AppImage"

            if [ -f "/tmp/helix.AppImage" ]; then
                mkdir -p "${HOME}/.local/bin"
                chmod u+x "/tmp/helix.AppImage"
                mv "/tmp/helix.AppImage" "${HOME}/.local/bin/hx"
            fi
        fi
    else
        _quiet "Skipping, ran recently"
    fi
else
    _quiet "Skipping, helix not already installed"
fi
