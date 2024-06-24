#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

if (command -v "nvim" >/dev/null 2>&1) ||
    (command -v "helix" >/dev/null 2>&1); then
    new=$(date +%s)
    state="${HOME}/.config/chezmoi/run_lsp_and_tools.time"

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
        if ! (command -v "bash-language-server" >/dev/null 2>&1); then
            _warn "bash-language-server not found, run: npm i -g bash-language-server"
        fi

        if ! (command -v "clangd" >/dev/null 2>&1); then
            _warn "clangd not found"
        fi

        mkdir -p "${HOME}/.local/bin"
        _gh_dl "mattn" "efm-langserver" "efm-langserver_vVER_linux_amd64.tar.gz" "browser_download_url" "/tmp/efm-langserver.tar.gz"

        if [ -f "/tmp/efm-langserver.tar.gz" ]; then
            tar zxf "/tmp/efm-langserver.tar.gz" -C "${HOME}/.local/bin" --no-anchored --strip=1 "efm-langserver"
            chmod u+x "${HOME}/.local/bin/efm-langserver"
            rm "/tmp/efm-langserver.tar.gz"
        fi

        if ! (command -v "markdownlint" >/dev/null 2>&1); then
            _warn "markdownlint not found, run: npm i -g markdownlint-cli"
        fi
        _gh_dl "LuaLS" "lua-language-server" "lua-language-server-VER-linux-x64.tar.gz" "browser_download_url" "/tmp/lua-language-server.tar.gz"

        if [ -f "/tmp/lua-language-server.tar.gz" ]; then
            mkdir -p "${HOME}/src/lua-language-server"
            tar zxf "/tmp/lua-language-server.tar.gz" -C "${HOME}/src/lua-language-server"
            rm "/tmp/lua-language-server.tar.gz"
        fi

        if ! (command -v "shellcheck" >/dev/null 2>&1); then
            _warn "shellcheck not found"
        fi

        if ! (command -v "shfmt" >/dev/null 2>&1); then
            _warn "shfmt not found"
        fi

        if ! (command -v "taplo" >/dev/null 2>&1); then
            _warn "taplo not found, run: cargo install taplo-cli --locked --features lsp"
        fi

        if ! (command -v "vscode-css-language-server" >/dev/null 2>&1); then
            _warn "vscode-langservers-extracted not found, run: npm i -g vscode-langservers-extracted"
        fi

    else
        _quiet "Skipping lsp_and_tools"
    fi
else
    _quiet "Skipping lsp_and_tools, (nvim | helix) not found"
fi
