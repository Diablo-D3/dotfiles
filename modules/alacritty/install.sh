#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

if [[ -n "${WSL+set}" ]]; then
	_stow "${MODULE_HOME:?}/config/alacritty" "${APPDATA:?}/alacritty/"
fi

fonts="${HOME}/.fonts"
iosevka="SuperTTC-Iosevka"
aile="SuperTTC-IosevkaAile"

_mkdir "${fonts}"

_gh_dl "be5invis" "iosevka" "${iosevka}" "-VER" ".zip" "${fonts}/Iosevka.ttc"
_gh_dl "be5invis" "iosevka" "${aile}" "-VER" ".zip" "${fonts}/IosevkaAile.ttc"

if [[ -f "/tmp/${iosevka}.zip" ]] || [[ -f "/tmp/${aile}.zip" ]]; then
	unzip -qqjo "/tmp/${iosevka}.zip" "*ttc" -d "${fonts}"
	unzip -qqjo "/tmp/${aile}.zip" "*ttc" -d "${fonts}"
	rm -f "/tmp/${iosevka}.zip" "/tmp/${aile}.zip"

	if [[ -n "${WSL+set}" ]]; then
		oldpwd="${PWD}"
		cd "${fonts}" || exit
		_ln "${MODULES_DIR:?}/os-wsl/fontreg.exe" "${USERPROFILE:?}/bin/fontreg.exe"
		powershell.exe -Command "& \$env:USERPROFILE\bin\fontreg.exe" "/copy"
		cd "${oldpwd}" || exit
	fi
fi

rm -f "/tmp/latest.json"

exit 0
