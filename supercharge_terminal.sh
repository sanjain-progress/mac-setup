#!/bin/bash

# ==============================================================================
# SUMMARY:
# 🛠  iTerm2, Oh My Zsh, & Powerlevel10k Theme
# 📦  Plugins: Autosuggestions, Syntax Highlighting, Autojump, Web-Search
# 🕒  History: 50,000 lines with timestamps
# 🤖  AI Shortcut: 'ai' command to search Gemini
# 📝  Vim: Enables trackpad scrolling and line numbers
# ==============================================================================

echo "🚀 Starting Terminal Supercharge..."

# 1. Install Homebrew (if not installed)
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Install iTerm2
echo "💻 Installing iTerm2..."
brew install --cask iterm2

# 3. Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🐚 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 4. Install Powerlevel10k Theme
echo "🎨 Installing Powerlevel10k..."
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# 5. Install Productivity Plugins
echo "📦 Installing Zsh plugins..."
# Plugin 1: Autosuggestions
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# Plugin 2: Syntax Highlighting
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# Plugin 3: Additional Completions
[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ] && git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
# Plugin 4: Autojump
brew install autojump

# 6. Configure .zshrc (Terminal Settings)
echo "📝 Configuring .zshrc..."

# Set Powerlevel10k Theme
sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Enable Plugins (including web-search)
sed -i '' 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions autojump web-search)/' ~/.zshrc

# Add History Settings
cat <<EOT >> ~/.zshrc

# --- Custom History Settings ---
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# --- Autojump Integration ---
[ -f \$(brew --prefix)/etc/profile.d/autojump.sh ] && . \$(brew --prefix)/etc/profile.d/autojump.sh

# --- AI Gemini Shortcut ---
ai() {
    local question="\$*"
    if [ -z "\$question" ]; then
        echo "❌ Please provide a question. Example: ai how to use git"
        return 1
    fi
    echo "\$question" | pbcopy
    open "https://gemini.google.com/app"
    echo "📋 Copied to clipboard! Paste (Cmd+V) in the browser."
}
EOT

# 7. Configure .vimrc (Vi/Vim Editor Settings)
echo "📜 Configuring Vim for trackpad support..."
cat <<EOT > ~/.vimrc
" Enable mouse and trackpad support in all modes
set mouse=a
" Shows line numbers for easier navigation
set number
" Use system clipboard
set clipboard=unnamed
EOT

echo "✅ DONE!"
echo "1. Restart iTerm2."
echo "2. Follow the Powerlevel10k wizard (it will start automatically)."
echo "3. Try your new command: ai what is the capital of France"
