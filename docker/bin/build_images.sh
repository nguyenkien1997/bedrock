#!/bin/bash

set -exo pipefail

# set all of the GIT environment variables
source docker/bin/set_git_env_vars.sh

# pull latest images
docker pull mozorg/bedrock:latest
docker pull mozorg/bedrock_test:latest
docker pull mozorg/bedrock_assets:latest

# get legal-docs
git submodule sync
git submodule update --init --recursive

# build fresh based on local changes
docker-compose build release
docker-compose build app assets
