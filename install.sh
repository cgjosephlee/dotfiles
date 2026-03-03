#!/bin/sh
set -e

# Configuration
REPO_URL="https://github.com/cgjosephlee/dotfiles"
CONFLICTS=".zshrc .vimrc .tmux.conf"

echo "Starting dotfiles installation..."

# 1. Create temporary environment
TMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'yadm')
trap 'rm -rf "$TMP_DIR"' EXIT INT TERM

# 2. Download yadm to temp directory
echo "Downloading temporary yadm..."
curl -fsSL https://github.com/yadm-dev/yadm/raw/master/yadm -o "$TMP_DIR/yadm"
chmod +x "$TMP_DIR/yadm"

# 3. Handle file conflicts
echo "Checking for existing files..."
for f in $CONFLICTS; do
    target="$HOME/$f"
    if [ -h "$target" ]; then
        echo "Removing symlink: $f"
        rm "$target"
    elif [ -f "$target" ]; then
        echo "Backing up $f to $f.bak"
        mv "$target" "$f.bak"
    fi
done

# 4. Clone and bootstrap
# Prepending TMP_DIR to PATH ensures hooks can find 'yadm'
echo "Cloning from $REPO_URL..."
PATH="$TMP_DIR:$PATH" yadm clone --bootstrap "$REPO_URL"

echo "Installation complete. Cleaned up temporary files."
