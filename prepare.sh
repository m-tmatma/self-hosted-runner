#!/bin/bash -e

cd actions-runner

# Extract the installer
tar xzf ./actions-runner-linux-x64.tar.gz

# install dependencies
sudo ./bin/installdependencies.sh
