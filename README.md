# docker-wraps-sysbox-module
Implements module sysbox for docker wraps environment.

## Usage
Add `docker-wraps-sysbox-module` to as submodule to your project:
```bash
git submodule add https://github.com/RomaTk/docker-wraps-sysbox-module.git modules/<name-you-like>
```

## Wraps:
After that you will have the following wraps available:
- `sysbox-get-latest-version`
- `sysbox-download`
- `sysbox-download-with-configs`
- `sysbox-install`
    - This wrap will install sysbox in the docker wraps environment.
    - As sysbox works with docker, it is based on `docker-install` wrap. So to implement it you need to have `docker-install` wrap available in your project. You can use https://github.com/RomaTk/docker-wraps-docker-module.git to have it.
- `use-sysbox`
    - This wrap will allow to use sysbox as runtime for docker.

Also this module provides script to install sysbox on your own machine using wrap `sysbox-install`. You can find it in `env-scripts/not-by-wrap-name/own-machine/sysbox-install.sh`.

You can specify which version of sysbox you want to use by modifying `build.run.before` in `sysbox-install` wrap. Within:
```bash
source ./env-scripts/sysbox/install/prepare-before-build.sh && main "<VERSION>" "linux" "./dockers/sysbox"
```
if no version is specified, latest version will be used.

For 

## Requirements

To use you need to have modules:
- https://github.com/RomaTk/docker-wraps-backups-module.git
    - This module will allow to avoid rebuilding images if they are already built.
- https://github.com/RomaTk/docker-wraps-ubuntu-module.git
    - This module will allow to have ubuntu image as base for sysbox images.
- https://github.com/RomaTk/docker-wraps-install-some-util-module.git
    - This module will provide env-scripts for common way to install some utils in the docker wraps environment.

