#!/bin/bash
set -euo pipefail

echo "========================================="
echo "Installing and configuring mise..."

if ! command -v mise &> /dev/null; then
  echo "mise is not found. Installing mise..."
  curl https://mise.jdx.dev/install.sh | sh
  export PATH="$HOME/.local/share/mise/bin:$PATH"
  eval "$($HOME/.local/share/mise/bin/mise activate bash)"
else
  echo "mise is already installed."
fi

if command -v mise &> /dev/null; then
  mise install --global
  echo "Tools installed successfully."
else
  echo "Error: mise activation failed."
  exit 1
fi
