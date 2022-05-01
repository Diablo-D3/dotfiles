#!/usr/bin/env bash

declare -a BRANCHES
BRANCHES=("unstable" "experimental")

for BRANCH in "${BRANCHES[@]}"; do
    BRANCH_LIST="/etc/apt/sources.list.d/$BRANCH.list"

    if (grep -q "$BRANCH" "/etc/apt/preferences.d/pin-"*); then
        if [ ! -f "$BRANCH_LIST" ]; then
            RUN_APT_UPDATE=1
            _sudo _ln "$MODULE_DIR/$BRANCH.list" "$BRANCH_LIST"
        fi
    else
        if [ -f "$BRANCH_LIST" ]; then
            RUN_APT_UPDATE=1
            _sudo rm "$BRANCH_LIST"
        fi
    fi
done

if [ -n "${RUN_APT_UPDATE+set}" ]; then
    _sudo apt update
fi
