#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

if ! (command -v "rustup" >/dev/null 2>&1); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if (command -v "rustup" >/dev/null 2>&1); then
    _check "$0"

    if [ "${_run}" -eq 0 ]; then
        rustup update
    fi
fi

if (command -v "cargo" >/dev/null 2>&1); then
    _check "$0"

    if [ "${_run}" -eq 0 ]; then
        list=$(cargo install --list | cut -f 1 -d' ' | grep -v '^$')

        while read -r crate; do
            cargo install "${crate}"
        done <"${list}"
    fi
fi
