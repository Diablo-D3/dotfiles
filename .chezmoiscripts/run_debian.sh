#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

case "${CHEZMOI_OS:?}" in
"linux")
    case "${CHEZMOI_OS_RELEASE_ID:?}" in
    "debian")
        _msg "Running debian"

        psrc="${SRC:?}/src/debian/preferences.d"
        pdst="/etc/apt/preferences.d/"

        ssrc="${SRC:?}/src/debian/sources.list.d"
        sdst="/etc/apt/sources.list.d"

        if [ ! -e "${pdst}/pin-stable" ] || ! cmp "${psrc}/pin-stable" "${pdst}/pin-stable"; then
            _sudo cp -v "${psrc}/pin-stable" "${pdst}/pin-stable"
        fi

        for pref in "${pdst}"/*; do
            if grep -q "testing" "${pref}"; then
                testing=1
            elif grep -q "unstable" "${pref}"; then
                unstable=1
            elif grep -q "experimental" "${pref}"; then
                experimental=1
            fi
        done

        if [ -n "${testing+x}" ]; then
            if [ ! -e "${sdst}/testing.list" ] || ! cmp "${ssrc}/testing.list" "${sdst}/testing.list"; then
                _sudo cp -v "${ssrc}/testing.list" "${sdst}/testing.list"
            fi
        else
            if [ -e "${sdst}/testing.list" ]; then
                _sudo rm "${sdst}/testing.list"
            fi
        fi

        if [ -n "${unstable+x}" ]; then
            if [ ! -e "${sdst}/unstable.list" ] || ! cmp "${ssrc}/unstable.list" "${sdst}/unstable.list"; then
                _sudo cp -v "${ssrc}/unstable.list" "${sdst}/unstable.list"
            fi
        else
            if [ -e "${sdst}/unstable.list" ]; then
                _sudo rm "${sdst}/unstable.list"
            fi
        fi

        if [ -n "${experimental+x}" ]; then
            if [ ! -e "${sdst}/experimental.list" ] || ! cmp "${ssrc}/experimental.list" "${sdst}/experimental.list"; then
                _sudo cp -v "${ssrc}/experimental.list" "${sdst}/experimental.list"
            fi
        else
            if [ -e "${sdst}/experimental.list" ]; then
                _sudo rm "${sdst}/experimental.list"
            fi
        fi
        ;;
    *)
        _quiet "Skipping debian"
        ;;
    esac
    ;;
*)
    _quiet "Skipping debian"
    ;;
esac
