#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_check "${_scripts}/run_lsp_and_tools.sh"

if [ "${_run}" -eq 0 ]; then
    # c/c++
    if ! (command -v "clangd" >/dev/null 2>&1); then
        _warn "clangd not found"
    fi

    # sh
    if ! (command -v "bash-language-server" >/dev/null 2>&1); then
        _warn "bash-language-server not found, run: npm i -g bash-language-server"
    fi

    if ! (command -v "shellcheck" >/dev/null 2>&1); then
        _warn "shellcheck not found"
    fi

    if ! (command -v "shfmt" >/dev/null 2>&1); then
        _warn "shfmt not found"
    fi

    _checksum "${_scripts}/run_lsp_and_tools.sh"
fi
