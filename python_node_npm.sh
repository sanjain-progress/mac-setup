#!/bin/bash

# 1. Install Homebrew (The foundation for Mac dev)
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to path for the current session
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Install nvm (Node Version Manager)
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Load NVM into current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Latest LTS Node and NPM
echo "Installing Node LTS..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

# 3. Install pyenv (Python Version Manager)
echo "Installing pyenv..."
brew install pyenv

# Add pyenv configuration to .zshrc if not already there
if ! grep -q 'pyenv init' ~/.zshrc; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
fi

# Initialize pyenv for current session
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Install a stable Python version (e.g., 3.12.0)
echo "Installing Python 3.12..."
pyenv install 3.12.0
pyenv global 3.12.0

echo "--------------------------------------"
echo "✅ Installation Complete!"
echo "Node Version: $(node -v)"
echo "NPM Version: $(npm -v)"
echo "Python Version: $(python3 --version)"
echo "--------------------------------------"
echo "IMPORTANT: Restart your terminal or run: source ~/.zshrc"
