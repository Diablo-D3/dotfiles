#!/bin/sh
# shellcheck source-path=~/.local/share/chezmoi/.chezmoitemplates
. "${CHEZMOI_SOURCE_DIR}/.chezmoitemplates/install-lib"

_sudo mkdir -p "/etc/ssh/sshd_config.d"
_sudo cp "${SRC:?}/src/sshd/custom.conf" "/etc/ssh/sshd_config.d/custom.conf"
