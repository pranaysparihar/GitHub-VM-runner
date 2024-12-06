#!/bin/bash
set -e

# Install dependencies
apt-get update
apt-get install -y \
    curl \
    jq \
    git \
    zip \
    unzip \
    tar \
    build-essential

# Create runner directory
mkdir -p /actions-runner
cd /actions-runner

# Download latest runner
RUNNER_VERSION="2.303.0"
curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L \
    https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Extract runner
tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Set permissions
chmod +x ./run.sh
chmod +x ./config.sh
chmod +x ./bin/*

# Install dependencies
./bin/installdependencies.sh

echo "Base runner installation completed"