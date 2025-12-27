#!/bin/bash

# 1. Setup Homebrew Path (Crucial for Apple Silicon Macs)
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed."
fi

# 3. Install rbenv and ruby-build
echo "Updating/Installing rbenv..."
brew install rbenv ruby-build

# 4. Clean up .zshrc and add correct rbenv hooks
# We use a block to ensure we don't duplicate lines every time the script runs
if ! grep -q 'rbenv init' ~/.zshrc; then
    echo 'Appending rbenv config to ~/.zshrc...'
    echo '' >> ~/.zshrc
    echo '# rbenv setup' >> ~/.zshrc
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
fi

# 5. Initialize rbenv for the CURRENT script process
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# 6. Install Ruby 3.4.1
TARGET_VERSION="3.4.1"
if ! rbenv versions | grep -q "$TARGET_VERSION"; then
    echo "Installing Ruby $TARGET_VERSION (this may take a few minutes)..."
    rbenv install $TARGET_VERSION
else
    echo "Ruby $TARGET_VERSION is already installed."
fi

# 7. Set Global and Rehash
rbenv global $TARGET_VERSION
rbenv rehash

echo "------------------------------------------------"
echo "✅ Installation complete!"
echo "IMPORTANT: Run the command below to update your current terminal:"
echo "source ~/.zshrc"
echo "------------------------------------------------"