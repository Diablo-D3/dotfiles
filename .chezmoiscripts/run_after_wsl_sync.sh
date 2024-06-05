#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

case "${CHEZMOI_OS:?}" in
"Linux")
    case "${CHEZMOI_OSRELEASE:?}" in
    *"microsoft"*)
        if [ -f "${HOME}/.bashrc.win" ]; then
            . "${HOME}/.bashrc.win"
        fi

        # synchronize ssh keys
        mkdir -p "${USERPROFILE:?}/.ssh"
        cp "${HOME}/.ssh/*" "${USERPROFILE:?}/.ssh/"

        # synchronize fonts
        if [ -d "${HOME}/.local/share/fonts" ]; then
            oldpwd="${PWD}"
            cd "${HOME}/.local/share/fonts" || exit
            mkdir -p "${USERPROFILE:?}/bin"
            cp "${SRC:?}/src/wsl/fontreg.exe" "${USERPROFILE:?}/bin/fontreg.exe"
            powershell.exe -Command "& \$env:USERPROFILE\bin\fontreg.exe" "/copy"
            cd "${oldpwd}" || exit
        fi

        # microsoft terminal
        mkdir dir -p "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
        cp "${SRC:?}/src/wsl/windowsterminal.settings.json" "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
        mkdir -p "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
        cp "${SRC:?}/src/wsl/windowsterminal.settings.json" "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/"

        # kanata
        mkdir dir -p "${USERPROFILE:?}/kanata"
        cp "${SRC:?}/src/kanata/kanata.ps1" "${USERPROFILE:?}/kanata/"
        cp "${SRC:?}/src/kanta/*.kbd" "${USERPROFILE:?}/kanata/"

        target="${USERPROFILE:?}/kanata/kanata.exe.new"
        _gh_dl "jtroo" "kanata" "kanata_wintercept.exe" "browser_download_url" "${target}"

        # alacritty
        mkdir -p "${APPDATA:?}/alacritty"
        cp "${SRC:?}/private_dot_config/alacritty/*" "${APPDATA:?}/alacritty/"

        # mpv
        mkdir -p "${APPDATA:?}/mpv"
        cp "${SRC:?}/private_dot_config/mpv/*" "${APPDATA:?}/mpv/"

        # streamlink
        mkdir -p "${APPDATA:?}/streamlink"
        cp "${SRC:?}/private_dot_config/streamlink/*" "${APPDATA:?}/streamlink/"

        # wezterm
        mkdir -p "${USERPROFILE:?}/.config/wezterm"
        cp "${SRC:?}/private_dot_config/wezterm/*" "${USERPROFILE:?}/.config/wezterm/"
        ;;
    *)
        printf "Skipping wsl (after), not found\n"
        ;;
    esac
    ;;
*)
    printf "Skipping wsl (after), not found\n"
    ;;
esac
