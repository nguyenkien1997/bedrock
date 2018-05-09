#!/bin/bash

set -exo pipefail

# pull latest images from docker hub
# needs to go above set_git_env_vars.sh
GIT_COMMIT= docker-compose pull release app assets

# get legal-docs
git submodule sync
git submodule update --init --recursive

if [[ "$1" == "--ci" ]]; then
    # set all of the GIT environment variables
    source docker/bin/set_git_env_vars.sh
    docker-compose build release
    docker-compose build app assets
else
    docker-compose build app assets
fi
