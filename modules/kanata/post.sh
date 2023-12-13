#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

_sudo usermod -aG input "${USER}"
_sudo usermod -aG uinput "${USER}"

if ! grep -q "uinput" "/etc/modules"; then
	echo "uinput" | _sudo tee -a "/etc/modules"
fi
