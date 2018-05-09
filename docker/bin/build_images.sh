#!/bin/bash

set -exo pipefail

source docker/bin/set_git_env_vars.sh

# get legal-docs
git submodule sync
git submodule update --init --recursive

# pull latest images
docker-compose pull app assets release

# build fresh based on local changes
docker-compose build release
docker-compose build app assets
