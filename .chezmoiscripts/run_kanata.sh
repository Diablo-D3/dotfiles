#!/bin/sh

# shellcheck source-path=~/.local/share/chezmoi/.chezmoitemplates
. "${CHEZMOI_SOURCE_DIR}/.chezmoitemplates/install-lib"

# only run if kanata is installed
if (command -v "kanata" >/dev/null 2>&1); then
    _sudo usermod -aG input "${USER}"
    _sudo usermod -aG uinput "${USER}"

    if ! grep -q "uinput" "/etc/modules"; then
        echo "uinput" | _sudo tee -a "/etc/modules"
    fi

    _sudo cp "${SRC:?}/kanata/kanata.rules" "/etc/udev/rules.d/"
fi
