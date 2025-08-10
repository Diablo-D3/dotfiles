#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_check "$0"

if [ "${_run}" -eq 0 ]; then
    _git_list "${_src}/src/nvim/git" "${HOME}/.local/share/nvim/site/pack/bundle/start"
fi
