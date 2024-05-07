#!/bin/sh

# shellcheck source-path=~/.local/share/chezmoi/.chezmoitemplates
. "${CHEZMOI_SOURCE_DIR}/.chezmoitemplates/install-lib"

if (command -v "alacritty" >/dev/null 2>&1) ||
    (command -v "alacritty.exe" >/dev/null 2>&1) ||
    (command -v "wezterm" >/dev/null 2>&1) ||
    (command -v "wezterm.exe" >/dev/null 2>&1); then

    new=$(date +%s)
    state="${HOME}/.config/chezmoi/run_iosevka.time"

    check=1

    if [ ! -e "${state}" ]; then
        printf "%s" "${new}" >"${state}"
        check=0
    else
        old=$(cat "${state}")

        if [ "${new}" -gt $((old + 86400)) ]; then
            printf "%s" "${new}" >"${state}"
            check=0
        fi
    fi

    if [ "${check}" -eq 0 ]; then
        _gh_dl "be5invis" "iosevka" "SuperTTC-Iosevka-VER.zip" "/tmp/Iosevka.zip"
        _gh_dl "be5invis" "iosevka" "SuperTTC-IosevkaAile-VER.zip" "/tmp/IosevkaAile.zip"

        if [ -f "/tmp/Iosevka.zip" ] && [ -f "/tmp/IosevkaAile.zip" ]; then
            mkdir -p "${HOME}/.local/share/fonts"
            unzip -qqjo "/tmp/Iosevka.zip" "*ttc" -d "${HOME}/.local/share/fonts"
            unzip -qqjo "/tmp/IosevkaAile.zip" "*ttc" -d "${HOME}/.local/share/fonts"
            rm -f "/tmp/Iosevka.zip" "/tmp/IosevkaAile.zip"
        fi
    else
        printf "Skipping iosevka\n"
    fi
fi
