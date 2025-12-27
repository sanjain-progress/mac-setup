#!/bin/zsh

# ==============================================================================
# DESCRIPTION: Enables Touch ID for 'sudo' authentication in Terminal.
# COMPATIBILITY: macOS Sonoma, Sequoia, and older versions.
# ==============================================================================

echo "🖐️  Enabling Touch ID for sudo..."

# Check if we are on macOS Sonoma or newer (which uses sudo_local)
if [ -f /etc/pam.d/sudo_local.template ]; then
    echo "Detected macOS Sonoma or newer."
    
    if [ ! -f /etc/pam.d/sudo_local ]; then
        # Create sudo_local from the template and uncomment the Touch ID line
        # This method survives macOS system updates
        sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local > /dev/null
        echo "✅ Success: Created /etc/pam.d/sudo_local and enabled Touch ID."
    else
        echo "ℹ️  /etc/pam.d/sudo_local already exists."
    fi
else
    # Legacy method for Monterey, Big Sur, etc.
    echo "Detected legacy macOS version."
    if ! grep -q "pam_tid.so" /etc/pam.d/sudo; then
        # Insert the Touch ID module at the top of the sudo configuration
        sudo sed -i .bak '2i\
auth       sufficient     pam_tid.so
' /etc/pam.d/sudo
        echo "✅ Success: Enabled Touch ID in /etc/pam.d/sudo."
    else
        echo "ℹ️  Touch ID is already enabled."
    fi
fi

echo "-------------------------------------------------------"
echo "🚀 Try running: sudo ls"
echo "-------------------------------------------------------"
