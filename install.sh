#!/bin/sh
set -e

REPO_URL="https://github.com/cgjosephlee/dotfiles"
CONFLICT_FILES=( ".zshrc" ".vimrc" ".tmux.conf" )
TMP_DIR=$(mktemp -d)

# Remove temporary directory after the script exits
trap 'rm -rf "$TMP_DIR"' EXIT

# Check for existing config files
for file in "${CONFLICT_FILES[@]}"; do
    target="$HOME/$file"
    if [ -f "$target" ] || [ -L "$target" ]; then
        if [ ! -L "$target" ]; then
            echo "Found existing $file, backing up to ${file}.bak"
            mv "$target" "${target}.bak"
        else
            echo "$file is a symlink, removing it to avoid conflict"
            rm "$target"
        fi
    fi
done

# Download temporary yadm
curl -fsSL https://github.com/yadm-dev/yadm/raw/master/yadm -o "$TMP_DIR/yadm"
chmod +x "$TMP_DIR/yadm"

export PATH="$TMP_DIR:$PATH"

yadm clone "$REPO_URL"
