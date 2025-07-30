#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_check "$0"

if [ "${_run}" -eq 0 ]; then
    _gh_dl "neovim" "neovim" "nvim-linux-x86_64.appimage" "browser_download_url"
    if [ -f "${_target}" ]; then
        chmod u+x "${_target}"
        mv "${_target}" "${HOME}/.local/bin/nvim"
    fi

    _git_list "${_src}/src/nvim/git" "${HOME}/.local/share/nvim/site/pack/bundle/start"
fi
