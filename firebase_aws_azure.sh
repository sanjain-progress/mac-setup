#!/bin/bash

echo "☁️ Starting Cloud CLI Installation for Apple Silicon..."

# 1. Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✅ Homebrew is already installed. Updating..."
    brew update
fi

# 2. Install Firebase CLI
# We use the brew formula 'firebase-cli' for a managed, native install
echo "🔥 Installing/Updating Firebase CLI..."
brew install firebase-cli || brew upgrade firebase-cli

# 3. Install AWS CLI (v2)
echo "📦 Installing/Updating AWS CLI..."
brew install awscli || brew upgrade awscli

# 4. Install Azure CLI
echo "🔷 Installing/Updating Azure CLI..."
brew install azure-cli || brew upgrade azure-cli

# 5. Configure Shell Completion (Optional but highly recommended)
# Adds autocomplete for 'az' commands to your .zshrc
if ! grep -q "bashcompinit" ~/.zshrc; then
    echo "Adding shell completion to ~/.zshrc..."
    echo 'autoload -U +X compinit && compinit' >> ~/.zshrc
    echo 'autoload -U +X bashcompinit && bashcompinit' >> ~/.zshrc
    echo 'source $(brew --prefix)/etc/bash_completion.d/az' >> ~/.zshrc
fi

echo "--------------------------------------"
echo "✅ Installation Complete!"
echo "Firebase: $(firebase --version)"
echo "AWS CLI:  $(aws --version)"
echo "Azure CLI: $(az version | grep 'azure-cli' | awk '{print $2}' | tr -d '",')"
echo "--------------------------------------"
echo "Next Steps: Run 'firebase login', 'aws configure', and 'az login' to authenticate."
echo "Please restart your terminal to enable autocomplete."
