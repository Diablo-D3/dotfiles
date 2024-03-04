#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

if [[ -n "${wsl+set}" ]]; then
	_ln "${MODULE_DIR:?}/kanata.ps1" "${USERPROFILE:?}/kanata/kanata.ps1"
	_ln "${MODULE_DIR:?}/tkl.kbd" "${USERPROFILE:?}/kanata/tkl.kbd"

	tmp="/tmp/kanata.exe"
	target="${USERPROFILE:?}/kanata/kanata.exe.new"

	rm -f "${tmp}"

	_gh_dl "jtroo" "kanata" "kanata" "" ".exe" "${target}"

	if [[ -f "${tmp}" ]]; then
		_ln "${tmp}" "${target}"
		rm -f "${tmp}"
	fi
fi
