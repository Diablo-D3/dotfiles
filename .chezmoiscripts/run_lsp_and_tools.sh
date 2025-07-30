#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_check "$0"

if [ "${_run}" -eq 0 ]; then
    # multiuse
    if ! (command -v "vscode-css-language-server" >/dev/null 2>&1); then
        _warn "vscode-langservers-extracted not found, run: npm i -g vscode-langservers-extracted"
    fi

    mkdir -p "${HOME}/.local/bin"
    _gh_dl "mattn" "efm-langserver" "efm-langserver_vVER_linux_amd64.tar.gz" "browser_download_url"

    if [ -s "${_target}" ]; then
        tar zxf "${_target}" -C "${HOME}/.local/bin" --no-anchored --strip=1 "efm-langserver"
        chmod u+x "${HOME}/.local/bin/efm-langserver"
        rm "${_target}"
    fi

    if ! (command -v "prettier" >/dev/null 2>&1); then
        _warn "prettier not found, run: npm i -g prettier"
    fi

    # c/c++
    if ! (command -v "clangd" >/dev/null 2>&1); then
        _warn "clangd not found"
    fi

    # markdown
    if ! (command -v "markdownlint" >/dev/null 2>&1); then
        _warn "markdownlint not found, run: npm i -g markdownlint-cli"
    fi

    # lua
    _gh_dl "LuaLS" "lua-language-server" "lua-language-server-VER-linux-x64.tar.gz" "browser_download_url"

    if [ -s "${_target}" ]; then
        mkdir -p "${HOME}/src/lua-language-server"
        tar zxf "${_target}" -C "${HOME}/src/lua-language-server"
        rm "${_target}"
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

    # toml
    if ! (command -v "taplo" >/dev/null 2>&1); then
        _warn "taplo not found, run: cargo install taplo-cli --locked --features lsp"
    fi
fi
