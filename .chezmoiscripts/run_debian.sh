#!/bin/sh

set -eu

_src="${CHEZMOI_SOURCE_DIR:?}"

case "${CHEZMOI_OS:?}" in
"linux")
    case "${CHEZMOI_OS_RELEASE_ID:?}" in
    "debian")
        psrc="${_src:?}/src/debian/preferences.d"
        pdst="/etc/apt/preferences.d"

        ssrc="${_src:?}/src/debian/sources.list.d"
        sdst="/etc/apt/sources.list.d"

        if [ ! -e "${pdst}/pin-stable" ] || ! cmp -s "${psrc}/pin-stable" "${pdst}/pin-stable"; then
            sudo cp "${psrc}/pin-stable" "${pdst}/pin-stable"
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
                sudo cp "${ssrc}/testing.list" "${sdst}/testing.list"
            fi
        else
            if [ -e "${sdst}/testing.list" ]; then
                sudo rm "${sdst}/testing.list"
            fi
        fi

        if [ -n "${unstable+x}" ]; then
            if [ ! -e "${sdst}/unstable.list" ] || ! cmp -s "${ssrc}/unstable.list" "${sdst}/unstable.list"; then
                sudo cp "${ssrc}/unstable.list" "${sdst}/unstable.list"
            fi
        else
            if [ -e "${sdst}/unstable.list" ]; then
                sudo rm "${sdst}/unstable.list"
            fi
        fi

        if [ -n "${experimental+x}" ]; then
            if [ ! -e "${sdst}/experimental.list" ] || ! cmp -s "${ssrc}/experimental.list" "${sdst}/experimental.list"; then
                sudo cp -v "${ssrc}/experimental.list" "${sdst}/experimental.list"
            fi
        else
            if [ -e "${sdst}/experimental.list" ]; then
                sudo rm "${sdst}/experimental.list"
            fi
        fi
        ;;
    *) ;;
    esac
    ;;
*) ;;
esac
