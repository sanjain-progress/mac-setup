#!/bin/zsh

# ==============================================================================
# SUMMARY:
# 📝 Tot: Minimalist note-taking app (via Mac App Store)
# 🖼️ ExifTool: Powerful tool for reading/writing metadata in files
# 📉 Pngquant: Lossy PNG compressor to reduce file sizes
# ==============================================================================

echo "🚀 Starting installation of productivity tools..."

# 1. Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "🍺 Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Install CLI Tools (ExifTool and Pngquant)
echo "📦 Installing ExifTool and Pngquant..."
brew install exiftool pngquant

# 3. Install 'mas' (Mac App Store CLI) to handle Tot
if ! command -v mas &> /dev/null; then
    echo "🍎 Installing 'mas' to manage App Store apps..."
    brew install mas
fi

# 4. Install Tot Note Taking App
# Tot App ID is 1491071483
echo "📝 Installing Tot from the App Store..."
mas install 1491071483 || echo "⚠️  Make sure you are signed into the Mac App Store."

echo "-------------------------------------------------------"
echo "✅ SUCCESS: All tools installed!"
echo "-------------------------------------------------------"
echo "👉 Usage Quick-Start:"
echo "   exiftool -all= photo.jpg  # Strip all metadata"
echo "   pngquant image.png       # Compress PNG file"
echo "   Open 'Tot' from your Applications folder"
