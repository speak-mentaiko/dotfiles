#!/bin/bash
set -euo pipefail

echo "========================================="
echo "Installing and configuring mise..."

if ! command -v mise &> /dev/null; then
  echo "mise is not found. Installing mise..."
  curl https://mise.jdx.dev/install.sh | sh
  #export PATH="$HOME/.local/share/mise/bin:$PATH"
  eval "$($HOME/.local/bin/mise activate bash)"
else
  echo "mise is already installed."
fi

# Rubyのインストールに必要なパッケージを取得

sudo apt update
sudo apt install -y \
  build-essential \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  libyaml-dev \
  libffi-dev \
  libxml2-dev \
  libxslt1-dev \
  libicu-dev \
  unzip

if command -v mise &> /dev/null; then
  mise install
  echo "Tools installed successfully."
else
  echo "Error: mise activation failed."
  exit 1
fi
