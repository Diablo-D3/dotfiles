#!/bin/sh

set -eu

_src="${CHEZMOI_SOURCE_DIR:?}"

if [ -d "/etc/ssh/sshd_config.d/" ]; then
    sudo cp "${_src:?}/src/sshd/custom.conf" "/etc/ssh/sshd_config.d/custom.conf"
fi
