#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

# only run if kanata is installed
if (command -v "kanata" >/dev/null 2>&1); then
    _sudo usermod -aG input "${USER}"
    _sudo usermod -aG uinput "${USER}"

    if ! grep -q "uinput" "/etc/modules"; then
        echo "uinput" | _sudo tee -a "/etc/modules"
    fi

    _sudo cp "${SRC:?}/src/kanata/kanata.rules" "/etc/udev/rules.d/"
else
    _quiet "Skipping kanata, not found"
fi
