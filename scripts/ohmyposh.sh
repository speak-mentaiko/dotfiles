#!/bin/bash
set -euo pipefail

echo "========================================="
echo "Installing Oh My Posh..."

# インストールスクリプトに必要なパッケージ
sudo apt update

INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

if ! command -v oh-my-posh &> /dev/null && [ ! -x "$INSTALL_DIR/oh-my-posh" ]; then
  echo "oh-my-posh is not found. Installing oh-my-posh..."
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$INSTALL_DIR"
else
  echo "oh-my-posh is already installed."
fi

