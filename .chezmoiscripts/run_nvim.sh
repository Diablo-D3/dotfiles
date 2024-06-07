#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

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
        _gh_dl "neovim" "neovim" "nvim.appimage" "browser_download_url" "${HOME}/.local/bin/.nvim.new"
        chmod u+x "${HOME}/.local/bin/.nvim.new"
        mv "${HOME}/.local/bin/.nvim.new" "${HOME}/.local/bin/nvim"
    else
        _quiet "Skipping nvim"
    fi
else
    _quiet "Skipping nvim, not found"
fi
