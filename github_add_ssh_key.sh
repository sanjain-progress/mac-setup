#!/bin/bash

# ==============================================================================
# SUMMARY:
# 🛠  Generates: ~/.ssh/[YOUR_CUSTOM_NAME]
# 🔐  Security: Ed25519 (Modern standard)
# 🔑  Keychain: Configures macOS to remember this specific key name
# 📋  Clipboard: Copies the public key automatically
# ==============================================================================

echo "🔑 Starting Custom SSH Key setup..."

# 1. Get user inputs
read -p "Enter your GitHub email: " github_email
read -p "Enter your custom key name (e.g., office_mb_14): " key_name

# Validate key name
if [ -z "$key_name" ]; then
    key_name="id_ed25519"
    echo "No name provided, defaulting to: $key_name"
fi

KEY_PATH="$HOME/.ssh/$key_name"

# 2. Check if key already exists
if [ -f "$KEY_PATH" ]; then
    echo "⚠️  A key named '$key_name' already exists at $KEY_PATH."
    read -p "Do you want to overwrite it? (y/n): " overwrite
    if [[ $overwrite != "y" ]]; then
        echo "Exiting without changes."
        exit 1
    fi
fi

# 3. Generate the key
echo "Generating key: $KEY_PATH"
ssh-keygen -t ed25519 -C "$github_email" -f "$KEY_PATH" -N ""

# 4. Configure SSH to use this specific key
# We use '>>' to append so we don't delete your existing configs
echo "📝 Updating SSH Config..."
touch ~/.ssh/config
cat <<EOT >> ~/.ssh/config

# Custom key for GitHub: $key_name
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $KEY_PATH
EOT

# 5. Load the key into the macOS agent
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain "$KEY_PATH"

# 6. Copy to clipboard
if [ -f "$KEY_PATH.pub" ]; then
    pbcopy < "$KEY_PATH.pub"
    echo "-------------------------------------------------------"
    echo "✅ SUCCESS: Public key for '$key_name' copied to clipboard!"
    echo "-------------------------------------------------------"
else
    echo "❌ Error: Public key file not found."
    exit 1
fi

# 7. Instructions
echo "👉 NEXT STEPS:"
echo "1. Open: https://github.com/settings/keys"
echo "2. Click 'New SSH key'"
echo "3. Paste (Cmd+V) the key"
echo "4. Use '$key_name' as the Title on GitHub so you recognize it later."
echo ""
read -p "Press [Enter] once you have saved the key on GitHub..."

# 8. Verification
echo "🔍 Verifying connection to GitHub using $key_name..."
ssh -T git@github.com
