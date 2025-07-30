#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_check "$0"

if [ "${_run}" -eq 0 ]; then
    if [ -d "${HOME}/src/helix" ]; then
        pwd="$(pwd)"
        cd "${HOME}/src/helix" || exit
        git pull
        HELIX_DEFAULT_RUNTIME="${HOME}/src/helix/runtime" cargo build --profile opt --locked
        ln -sfv "${HOME}/src/helix/target/opt/hx" "${HOME}/.local/bin"
        cd "${pwd}" || exit
    else
        _gh_dl "helix-editor" "helix" "helix-VER-x86_64.AppImage" "browser_download_url"

        if [ -s "${_target}" ]; then
            mkdir -p "${HOME}/.local/bin"
            chmod u+x "${_target}"
            mv "${_target}" "${HOME}/.local/bin/hx"
        fi
    fi
fi
