#!/usr/bin/env bash

declare -a branches
branches=("unstable" "experimental")

apt_prefs="/etc/apt/preferences.d"

for branch in "${branches[@]}"; do
    branch_list="/etc/apt/sources.list.d/$branch.list"

    if (grep -q "$branch" "$apt_prefs/pin-"*); then
        if [ ! -f "$branch_list" ]; then
            run_apt_update=1
            _sudo _ln "$module_dir/$branch.list" "$branch_list"
        fi
    else
        if [ -f "$branch_list" ]; then
            run_apt_update=1
            _sudo rm "$branch_list"
        fi
    fi
done

pin_glibc="$apt_prefs/pin-glibc"
if (grep -q "glibc" "$apt_prefs/pin-"*); then
    if [ ! -f "$pin_glibc" ]; then
        run_apt_update=1
        _sudo _ln "$module_dir/pin-glibc" "$pin_glibc"
    fi
else
    if [ -f "$pin_glibc" ]; then
        run_apt_update=1
        _sudo rm "$pin_glibc"
    fi
fi

if [ -n "${run_apt_update+set}" ]; then
    _sudo apt update
fi
