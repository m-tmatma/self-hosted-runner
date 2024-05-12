#!/bin/bash -e

mkdir -p actions-runner

# https://github.com/actions/runner/releases/
gh release -R actions/runner download --skip-existing -p "actions-runner-linux-x64-*.tar.gz" \
   $(gh release -R actions/runner list --json tagName --jq ".[].tagName" -L 1) \
   -O actions-runner/actions-runner-linux-x64.tar.gz
