#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

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
        _gh_dl "be5invis" "iosevka" "SuperTTC-Iosevka-VER.zip" "browser_download_url" "/tmp/Iosevka.zip"
        _gh_dl "be5invis" "iosevka" "SuperTTC-IosevkaAile-VER.zip" "browser_download_url" "/tmp/IosevkaAile.zip"

        if [ -f "/tmp/Iosevka.zip" ] && [ -f "/tmp/IosevkaAile.zip" ]; then
            mkdir -p "${HOME}/.local/share/fonts"
            unzip -qqjo "/tmp/Iosevka.zip" "*ttc" -d "${HOME}/.local/share/fonts"
            unzip -qqjo "/tmp/IosevkaAile.zip" "*ttc" -d "${HOME}/.local/share/fonts"
            rm -f "/tmp/Iosevka.zip" "/tmp/IosevkaAile.zip"
        fi
    else
        printf "Skipping iosevka\n"
    fi
else
    printf "Skipping iosevka, alacritty or wezterm not found\n"
fi
