#!/bin/bash

function main {
    local version="$1"
    local os="$2"
    local path_to_docker="$3"
    local file_version_in_download_docker_context="$path_to_docker/download/with-configs/configs/versions.cfg"
    local empty_file_name="null.deb"

    if [ -z "$version" ]; then
        source ./env-scripts/not-by-wrap-name/install-some-util/get-latest-version.sh
        [ $? -ne 0 ] && exit 1

        version="$(getLatestVersion "$path_to_docker" "sysbox")"
        [ $? -ne 0 ] && exit 1
    fi

    source "./env-scripts/not-by-wrap-name/install-some-util/prepare-before-build/main.sh"
    [ $? -ne 0 ] && exit 1

    main "$version" "$os" "sysbox" "$path_to_docker" "$empty_file_name"
    [ $? -ne 0 ] && exit 1

    exit 0
}

function formatArch {
    local arch="$1"

    case "$arch" in
        "x86_64" | "amd64")
            echo "amd64"
            ;;
        "aarch64" | "arm64")
            echo "arm64"
            ;;
        *)
            echo "unsupported"
            exit 1
            ;;
    esac

    exit 0
}