#!/bin/bash

function main {
    local file_name
    local containers
    local is_sysbox_installed
    local version
    local arch

    is_sysbox_installed=$(checkIfSysboxInstalled)
    [ $? -ne 0 ] && exit 1

    if [ "$is_sysbox_installed" == "true" ]; then
        exit 0
    fi

    (./envs.sh start sysbox-install)
    [ $? -ne 0 ] && exit 1

    version=$(source ./env-scripts/not-by-wrap-name/install-some-util/read-version.sh && main "./dockers/sysbox")
    if [ $? -ne 0 ]; then
        echo "Failed to read sysbox version" >&2
        exit 1
    fi
    arch=$(source ./env-scripts/not-by-wrap-name/install-some-util/read-arch.sh && main "./dockers/sysbox")
    if [ $? -ne 0 ]; then
        echo "Failed to read system architecture" >&2
        exit 1
    fi

    file_name="./dockers/sysbox/install/saved-versions/${arch}-${version}.deb"
    if [ ! -f "$file_name" ]; then
        echo "File $file_name not found" >&2
        exit 1
    fi

    containers=$(docker ps -a -q)
    [ $? -ne 0 ] && exit 1
    
    if [ ! -z "$containers" ]; then
        (docker rm $containers -f)
        [ $? -ne 0 ] && exit 1
    fi    

    sudo apt install "$file_name" -y
    [ $? -ne 0 ] && exit 1

    sudo apt autoremove -y
    [ $? -ne 0 ] && exit 1

    exit 0
}

function checkIfSysboxInstalled {
    local last_action
    last_action=$(docker info | grep runc)
    [ $? -ne 0 ] && exit 1

    last_action=$(docker info | grep sysbox-runc)
    if [ $? -eq 0 ]; then
        echo "true"
        exit 0
    fi

    echo "false"
    exit 0
}