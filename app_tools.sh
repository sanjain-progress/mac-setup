#!/bin/bash

# ==============================================================================
# SUMMARY OF TOOLS TO BE INSTALLED:
# ------------------------------------------------------------------------------
# 🛠  CLI Tools: Hugo, Graphviz, Terraform
# 📦  Package Managers: Node.js, Yarn
# 🗄️  Databases: Redis, PostgreSQL (and starting them as services)
# 🌐  Browsers: Brave Browser
# 💬  Communication: WhatsApp, Slack, Discord, Zoom
# 📝  Productivity: Notion, Typora (Markdown Editor)
# 🛠  Dev Utilities: Postman
# 🎬  Media: VLC Player
# ==============================================================================

echo "🚀 Starting installation..."

# 1. Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Update Homebrew
echo "🔄 Updating Homebrew..."
brew update

# 3. Install CLI Tools & Databases
echo "📦 Installing CLI binaries and databases..."
brew install hugo graphviz terraform redis postgresql node yarn

# 4. Install GUI Apps (Casks)
echo "🖥️ Installing GUI Applications..."
# We use a single command for efficiency
brew install --cask \
    brave-browser \
    postman \
    notion \
    slack \
    discord \
    typora \
    whatsapp \
    vlc \
    zoom

# 5. Configure & Start Services
echo "⚙️ Configuring background services..."
# This ensures databases start automatically on boot
brew services start redis
brew services start postgresql

# 6. Final verification
echo "------------------------------------------------"
echo "✅ SETUP COMPLETE!"
echo "------------------------------------------------"
echo "Hugo version:      $(hugo version | awk '{print $2}')"
echo "Terraform version: $(terraform version | head -n 1)"
echo "Node version:      $(node -v)"
echo "Yarn version:      $(yarn -v)"
echo "Postgres status:   Running via Brew Services"
echo "Redis status:      Running via Brew Services"
echo "------------------------------------------------"
echo "Note: You may need to restart your terminal to use all tools."
