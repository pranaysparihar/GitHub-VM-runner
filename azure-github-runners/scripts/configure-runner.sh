#!/bin/bash
set -e

RUNNER_VERSION="${RUNNER_VERSION}"
GITHUB_TOKEN="${GITHUB_TOKEN}"
GITHUB_REPO_URL="${GITHUB_REPO_URL}" 

# Install dependencies
sudo apt-get update
sudo apt-get install -y curl jq git

# Download and configure runner
mkdir -p /actions-runner
cd /actions-runner

curl -o runner.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
tar xzf runner.tar.gz
rm runner.tar.gz

# Configure runner
./config.sh \
    --url "${GITHUB_REPO_URL}" \
    --token "${GITHUB_TOKEN}" \
    --name "${HOSTNAME}" \
    --work "_work" \
    --unattended \
    --replace

# Install as service
sudo ./svc.sh install
sudo ./svc.sh start