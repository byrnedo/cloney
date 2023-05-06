#!/bin/bash

set -euo pipefail

if [ -z "$@" ]; then
  CMD=( bash -c './clone.sh < ./repos.txt && sleep 60')
else
  CMD=("$@")
fi
echo "${CMD[@]}"

ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh-keyscan gitlab.com >> ~/.ssh/known_hosts

# Github token
git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
# Gitlab personal access token
git config --global url."https://gitlab-ci-token:${GITLAB_TOKEN}@gitlab.com/".insteadOf "https://gitlab.com/"


exec "${CMD[@]}"
