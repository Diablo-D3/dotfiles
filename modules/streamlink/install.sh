#!/usr/bin/env bash

# shellcheck enable=all
# shellcheck source=install-lib
source "${BASE_DIR:?}/install-lib"

if [[ -n "${WSL+set}" ]]; then
	_ln "${MODULE_HOME:?}/config/streamlink/config" "${APPDATA:?}/streamlink/config"
fi
