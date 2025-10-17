#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

if [ -d "/etc/ssh/sshd_config.d/" ]; then
    _check "${_scripts}/run_sshd.sh"

    if [ "${_run}" -eq 0 ]; then
        _sudo cp -v "${_src:?}/src/sshd/custom.conf" "/etc/ssh/sshd_config.d/custom.conf"

        _checksum "${_scripts}/run_sshd.sh"
    fi
fi
