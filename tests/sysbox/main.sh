#!/bin/bash

# Install
./envs.sh start sysbox-install || exit 1

./envs.sh start sysbox-use-test || exit 1