#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

declare -a branches
branches=("unstable" "experimental")

apt_prefs="/etc/apt/preferences.d"

run_apt_update=1

# scan pins placed by other modules for other branches,
# and add/remove sources for those branches
for branch in "${branches[@]}"; do
	branch_list="/etc/apt/sources.list.d/${branch}.list"

	if (grep -q "${branch}" "${apt_prefs}/pin-"*); then
		if [[ ! -f "${branch_list}" ]]; then
			run_apt_update=0
			_sudo _ln "${MODULE_DIR:?}/${branch}.list" "${branch_list}"
		fi
	else
		if [[ -f "${branch_list}" ]]; then
			run_apt_update=0
			_sudo rm "${branch_list}"
		fi
	fi
done

# scan pins to see if any of them explicitly pin glibc,
# and add/remove pin for supporting packages
pin_glibc="${apt_prefs}/pin-glibc"
if (grep -q "glibc" "${apt_prefs}/pin-"*); then
	if [[ ! -f "${pin_glibc}" ]]; then
		run_apt_update=0
	fi

	_sudo _ln "${MODULE_DIR:?}/pin-glibc" "${pin_glibc}"
else
	if [[ -f "${pin_glibc}" ]]; then
		run_apt_update=0
		_sudo rm "${pin_glibc}"
	fi
fi

# update if pins changed
if [[ "${run_apt_update}" -eq 0 ]]; then
	_sudo apt update
fi
