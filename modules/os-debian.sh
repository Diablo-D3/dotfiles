#!/usr/bin/env bash

declare -a branches
branches=("unstable" "experimental")

for branch in "${branches[@]}"; do
    branch_list="/etc/apt/sources.list.d/$branch.list"

    if (grep -q "$branch" "/etc/apt/preferences.d/pin-"*); then
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

if [ -n "${run_apt_update+set}" ]; then
    _sudo apt update
fi
