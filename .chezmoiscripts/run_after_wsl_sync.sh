#!/bin/sh

set -eu

_src="${CHEZMOI_SOURCE_DIR:?}"

case "${CHEZMOI_OS:?}" in
"linux")
    case "${CHEZMOI_KERNEL_OSRELEASE:?}" in
    *"microsoft"*)
        # synchronize ssh keys
        mkdir -p "${USERPROFILE:?}/.ssh"
        cp "${HOME}/.ssh/"* "${USERPROFILE:?}/.ssh/"

        # synchronize fonts
        if [ -d "${HOME}/.local/share/fonts" ]; then
            oldpwd="${PWD}"
            cd "${HOME}/.local/share/fonts" || exit
            mkdir -p "${USERPROFILE:?}/bin"
            cp "${_src:?}/src/wsl/fontreg.exe" "${USERPROFILE:?}/bin/fontreg.exe"
            powershell.exe -Command "& \$env:USERPROFILE\bin\fontreg.exe" "/copy"
            cd "${oldpwd}" || exit
        fi

        # alacritty
        mkdir -p "${APPDATA:?}/alacritty"
        cp "${_src:?}/private_dot_config/alacritty/"* "${APPDATA:?}/alacritty/"

        # kanata
        mkdir -p "${USERPROFILE:?}/kanata"
        cp "${_src:?}/src/kanata/kanata.ps1" "${USERPROFILE:?}/kanata/"
        cp "${_src:?}/src/kanata/"*".kbd" "${USERPROFILE:?}/kanata/"

        # mpv
        mkdir -p "${APPDATA:?}/mpv"
        cp "${_src:?}/private_dot_config/mpv/"* "${APPDATA:?}/mpv/"

        # microsoft terminal
        mkdir -p "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
        cp "${_src:?}/src/wsl/windowsterminal.settings.json" "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
        mkdir -p "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
        cp "${_src:?}/src/wsl/windowsterminal.settings.json" "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

        # wezterm
        mkdir -p "${USERPROFILE:?}/.config/wezterm"
        cp "${_src:?}/private_dot_config/wezterm/"* "${USERPROFILE:?}/.config/wezterm/"
        ;;
    *) ;;
    esac
    ;;
*) ;;
esac
