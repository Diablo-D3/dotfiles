#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

declare -a branches
branches=("unstable" "experimental")

apt_prefs="/etc/apt/preferences.d"

run_apt_update=1

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

pin_glibc="${apt_prefs}/pin-glibc"
if (grep -q "glibc" "${apt_prefs}/pin-"*); then
	if [[ ! -f "${pin_glibc}" ]]; then
		run_apt_update=0
	fi

	_sudo _ln "${MODULE_DIR:?}/pin-glibc" "${pin_glibc}"
else
	if [[ -f "${pin_glibc}" ]]; then
		run_apt_update=1
		_sudo rm "${pin_glibc}"
	fi
fi

if "${run_apt_update}"; then
	_sudo apt update
fi
