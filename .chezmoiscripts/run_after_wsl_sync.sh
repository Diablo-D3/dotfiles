#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

if [ "${_wsl}" = 0 ]; then
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

    # microsoft terminal
    mkdir -p "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
    cp "${_src:?}/src/wsl/windowsterminal.settings.json" "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    mkdir -p "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
    cp "${_src:?}/src/wsl/windowsterminal.settings.json" "${LOCALAPPDATA:?}/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"

    # mpv
    mkdir -p "${APPDATA:?}/mpv"
    cp "${_src:?}/private_dot_config/mpv/"* "${APPDATA:?}/mpv/"
fi
