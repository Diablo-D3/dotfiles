#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

_sudo mkdir -p "/etc/ssh/sshd_config.d"
_sudo cp "${SRC:?}/src/sshd/custom.conf" "/etc/ssh/sshd_config.d/custom.conf"
