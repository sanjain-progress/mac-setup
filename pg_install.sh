#!/bin/zsh

# ==============================================================================
# SUMMARY:
# 🐘  Installs: PostgreSQL via Homebrew
# 🚀  Services: Starts PostgreSQL as a background service
# 🔗  Aliases: Adds 'pg-start', 'pg-stop', and 'pg-status'
# ==============================================================================

echo "🐘 Starting PostgreSQL installation..."

# 1. Install PostgreSQL
if ! command -v psql &> /dev/null; then
    echo "📦 Downloading and installing PostgreSQL..."
    brew install postgresql@14
else
    echo "✅ PostgreSQL is already installed."
fi

# 2. Start the Service
echo "🚀 Starting PostgreSQL background service..."
brew services start postgresql@14

# 3. Add Productivity Aliases to .zshrc
# We check if they exist first to avoid adding them multiple times
if ! grep -q "pg-start" ~/.zshrc; then
    echo "📝 Adding Postgres aliases to ~/.zshrc..."
    cat <<EOT >> ~/.zshrc

# --- PostgreSQL Shortcuts ---
alias pg-start="brew services start postgresql@14"
alias pg-stop="brew services stop postgresql@14"
alias pg-status="brew services list | grep postgres"
alias pg-logs="tail -f /opt/homebrew/var/log/postgresql@14.log"
EOT
fi

# 4. Create default database
echo "🛠  Creating default user database..."
createdb $(whoami) 2>/dev/null || echo "ℹ️  Database for $(whoami) already exists."

echo "-------------------------------------------------------"
echo "✅ SUCCESS: PostgreSQL is installed and running!"
echo "-------------------------------------------------------"
echo "👉 Action Required:"
echo "   Run 'source ~/.zshrc' manually to enable the new aliases."
echo "   Then type 'psql' to start."
