#!/bin/sh
set -e

REPO_URL="https://github.com/cgjosephlee/dotfiles"

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fsSL https://github.com/yadm-dev/yadm/raw/master/yadm -o "$TMP_DIR/yadm"
chmod +x "$TMP_DIR/yadm"

export PATH="$TMP_DIR:$PATH"

yadm clone "$REPO_URL"
