#!/bin/bash

version="$1"
arch="$2"

if [ -z "$version" ]; then
    echo "Version not provided"
    exit 1
fi

apt install ./saved-versions/${arch}-${version}.deb -y
[ $? -ne 0 ] && exit 1

apt autoremove -y
[ $? -ne 0 ] && exit 1

exit 0