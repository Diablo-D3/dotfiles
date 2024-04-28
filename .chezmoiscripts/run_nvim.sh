#!/bin/sh

# shellcheck source-path=~/.local/share/chezmoi/.chezmoitemplates
. "${CHEZMOI_SOURCE_DIR}/.chezmoitemplates/install-lib"

if (command -v "nvim" >/dev/null 2>&1); then
    new=$(date +%s)
    state="${HOME}/.config/chezmoi/run_nvim.time"

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
        printf "Downloading neovim nightly\n"
        wget -q -O "${HOME}/.local/bin/.nvim.new" "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
        chmod u+x "${HOME}/.local/bin/.nvim.new"
        mv "${HOME}/.local/bin/.nvim.new" "${HOME}/.local/bin/nvim"
    fi
fi
