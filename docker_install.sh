#!/bin/bash

echo "🚀 Starting Docker Desktop Installation..."

# 1. Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Install Docker Desktop via Homebrew Cask
echo "📦 Installing Docker Desktop..."
brew install --cask docker

# 3. Open Docker to start the background daemon
echo "🏗️ Opening Docker to finish configuration..."
open /Applications/Docker.app

echo "⏳ Waiting for Docker to start..."
# Wait until the docker socket is available
while ! docker system info &> /dev/null; do
    echo "Still waiting for Docker daemon..."
    sleep 5
done

echo "✅ Docker is installed and running!"
docker --version
