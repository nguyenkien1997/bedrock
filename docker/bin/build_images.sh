#!/bin/bash

set -exo pipefail

# pull latest images from docker hub
# needs to go above set_git_env_vars.sh
GIT_COMMIT= docker-compose pull release app assets

# get legal-docs
git submodule sync
git submodule update --init --recursive

# set all of the GIT environment variables
source docker/bin/set_git_env_vars.sh

# build fresh based on local changes
docker-compose build release
docker-compose build app assets
