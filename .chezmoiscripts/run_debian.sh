#!/bin/sh

# shellcheck source=.chezmoitemplates/install-lib
. "${HOME}/.local/share/chezmoi/.chezmoitemplates/install-lib"

case "${CHEZMOI_OS:?}" in
"linux")
    case "${CHEZMOI_OS_RELEASE_ID:?}" in
    "debian")
        psrc="${_src:?}/src/debian/preferences.d"
        pdst="/etc/apt/preferences.d"

        ssrc="${_src:?}/src/debian/sources.list.d"
        sdst="/etc/apt/sources.list.d"

        if [ ! -e "${pdst}/pin-stable" ] || ! cmp -s "${psrc}/pin-stable" "${pdst}/pin-stable"; then
            _sudo cp -v "${psrc}/pin-stable" "${pdst}/pin-stable"
        fi

        for pref in "${pdst}"/pkg*; do
            if [ -e "${pref}" ]; then
                if grep -q "testing" "${pref}"; then
                    testing=1
                fi

                if grep -q "unstable" "${pref}"; then
                    unstable=1
                fi

                if grep -q "experimental" "${pref}"; then
                    experimental=1
                fi
            fi
        done

        if [ -n "${testing+x}" ]; then
            if [ ! -e "${sdst}/testing.list" ] || ! cmp -s "${ssrc}/testing.list" "${sdst}/testing.list"; then
                _sudo cp -v "${ssrc}/testing.list" "${sdst}/testing.list"
            fi
        else
            if [ -e "${sdst}/testing.list" ]; then
                _sudo rm "${sdst}/testing.list"
            fi
        fi

        if [ -n "${unstable+x}" ]; then
            if [ ! -e "${sdst}/unstable.list" ] || ! cmp -s "${ssrc}/unstable.list" "${sdst}/unstable.list"; then
                _sudo cp -v "${ssrc}/unstable.list" "${sdst}/unstable.list"
            fi
        else
            if [ -e "${sdst}/unstable.list" ]; then
                _sudo rm "${sdst}/unstable.list"
            fi
        fi

        if [ -n "${experimental+x}" ]; then
            if [ ! -e "${sdst}/experimental.list" ] || ! cmp -s "${ssrc}/experimental.list" "${sdst}/experimental.list"; then
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
