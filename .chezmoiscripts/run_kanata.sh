#!/bin/sh

set -eu

_src="${CHEZMOI_SOURCE_DIR:?}"

if (command -v "kanata" >/dev/null 2>&1); then
    if ! (groups | grep -wq 'input') || ! (groups | grep -wq 'uinput'); then
        sudo usermod -aG input "${USER}"
        sudo usermod -aG uinput "${USER}"
    fi

    kanata_conf="/etc/modules-load.d/kanata.conf"
    sudo cp "${_src:?}/src/kanata/kanata.conf" "${kanata_conf}"

    kanata_rules="/etc/udev/rules.d/kanata.rules"
    sudo cp "${_src:?}/src/kanata/kanata.rules" "${kanata_rules}"
fi
