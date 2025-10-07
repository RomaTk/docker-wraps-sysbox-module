#!/bin/bash

function main {
    local file_name
    local containers
    local is_sysbox_installed

    is_sysbox_installed=$(checkIfSysboxInstalled)
    [ $? -ne 0 ] && exit 1

    if [ "$is_sysbox_installed" == "true" ]; then
        exit 0
    fi

    (./envs.sh start sysbox-install)
    [ $? -ne 0 ] && exit 1

    source ./dockers/sysbox/get-latest-version/configs/latest-version.cfg
    [ $? -ne 0 ] && exit 1

    if [ -z "$LATEST_VERSION" ]; then
        echo "Latest version is not set" >&2
        exit 1
    fi

    file_name="./dockers/sysbox/install/saved-versions/${LATEST_VERSION}.deb"
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