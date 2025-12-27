#!/bin/bash

echo "🚀 Starting GitHub tools installation/update..."

# 1. Ensure Homebrew is installed and on the PATH
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed. Updating..."
    brew update
fi

# 2. Install or Upgrade GitHub CLI (gh)
if brew list gh &>/dev/null; then
    echo "🔄 Updating GitHub CLI..."
    brew upgrade gh
else
    echo "📦 Installing GitHub CLI..."
    brew install gh
fi

# 3. Install or Upgrade GitHub Desktop (App)
if brew list --cask github &>/dev/null; then
    echo "🔄 Updating GitHub Desktop..."
    brew upgrade --cask github
else
    echo "📦 Installing GitHub Desktop..."
    brew install --cask github
fi

echo "--------------------------------------"
echo "✅ Done!"
echo "GitHub CLI version: $(gh --version | head -n 1)"
echo "GitHub Desktop is located in your Applications folder."
echo "--------------------------------------"
echo "Next step: Run 'gh auth login' to connect your account."
