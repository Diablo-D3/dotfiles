#!/bin/sh

# {{ $exec := printf "find %s -type f -exec sha256sum -b {} \\; | sort | sha256sum | cut -d' ' -f1" (joinPath .chezmoi.sourceDir "src" "kanata") }}
# {{ output "bash" "-c" $exec }}

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

echo "-> kanata.sh"

# Local
if (command -v "kanata" >/dev/null 2>&1); then
    if ! (groups | grep -wq 'input') || ! (groups | grep -wq 'uinput'); then
        _sudo usermod -aG input "${USER}"
        _sudo usermod -aG uinput "${USER}"
    fi

    kanata_conf="/etc/modules-load.d/kanata.conf"
    _sudo cp -v "${_src:?}/src/kanata/kanata.conf" "${kanata_conf}"

    kanata_rules="/etc/udev/rules.d/kanata.rules"
    _sudo cp -v "${_src:?}/src/kanata/kanata.rules" "${kanata_rules}"
fi

# WSL2 host
if [ "${_wsl:?}" = 0 ]; then
    mkdir -p "${USERPROFILE:?}/kanata"
    cp "${_src:?}/src/kanata/kanata.ps1" "${USERPROFILE:?}/kanata/"
    cp "${_src:?}/src/kanata/"*".kbd" "${USERPROFILE:?}/kanata/"
fi
