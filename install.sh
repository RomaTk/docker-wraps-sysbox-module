#!/bin/bash

function main() {
    local current_file="${BASH_SOURCE[0]}"
    local current_dir
    local mktemp_file
    
    current_dir="$(dirname "$current_file")"
    [ $? -ne 0 ] && exit 1

    cd "$current_dir" || exit 1
    [ $? -ne 0 ] && exit 1

    ln -sf "../$current_dir/dockers/sysbox" "../../dockers/sysbox"
    [ $? -ne 0 ] && exit 1

    ln -sf "../$current_dir/env-scripts/sysbox" "../../env-scripts/sysbox"
    [ $? -ne 0 ] && exit 1

    mkdir -p "../../env-scripts/not-by-wrap-name/own-machine"
    [ $? -ne 0 ] && exit 1

    ln -sf "../../../$current_dir/env-scripts/not-by-wrap-name/own-machine/sysbox-install.sh" "../../env-scripts/not-by-wrap-name/own-machine/sysbox-install.sh"
    [ $? -ne 0 ] && exit 1
    
    mktemp_file=$(mktemp)
    [ $? -ne 0 ] && exit 1

    jq -s '.[0] * .[1]' "./envs.json" "../../envs.json" > "$mktemp_file"
    [ $? -ne 0 ] && exit 1

    mv "$mktemp_file" "../../envs.json"
    [ $? -ne 0 ] && exit 1
    
    rm -f "$mktemp_file"
    [ $? -ne 0 ] && exit 1

    exit 0
}