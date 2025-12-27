#!/bin/bash

# 1. Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed. Updating..."
    brew update
fi

# 2. Install rbenv and ruby-build
echo "Installing rbenv and ruby-build..."
brew install rbenv ruby-build

# 3. Set up rbenv in your shell (zsh is default for macOS)
if ! grep -q 'eval "$(rbenv init -)"' ~/.zshrc; then
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    echo "Added rbenv to ~/.zshrc"
fi
eval "$(rbenv init -)"

# 4. Install Ruby 3.4.1 (Latest stable version)
# Note: Ruby 3.4.8 is not yet released. 
TARGET_VERSION="3.4.1"

echo "Installing Ruby $TARGET_VERSION..."
rbenv install $TARGET_VERSION

# 5. Set as global version
rbenv global $TARGET_VERSION

echo "Installation complete!"
echo "Please restart your terminal or run 'source ~/.zshrc'"
ruby -v
