#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_msg "Running nvim"

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
        _gh_dl "neovim" "neovim" "nvim-linux-x86_64.appimage" "browser_download_url" "/tmp/nvim"
        if [ -f "/tmp/nvim" ]; then
            chmod u+x "/tmp/nvim"
            mv "/tmp/nvim" "${HOME}/.local/bin/nvim"
        fi

        _git_list "${SRC}/src/nvim/git" "${HOME}/.local/share/nvim/site/pack/bundle/start"
    else
        _quiet "Skipping, ran recently"
    fi
else
    _quiet "Skipping, nvim not already installed"
fi
