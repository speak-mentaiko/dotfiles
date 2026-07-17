#!/bin/bash
set -euo pipefail

# neovimに必要なパッケージをインストール

sudo apt update
sudo apt install -y \
  wl-clipboard \
  libclang-dev

if ! command -v cargo &> /dev/null; then
  echo "Cargo is not found. Installing Rust via rustup..."

  # 公式スクリプトを -y (yes) オプション付きで実行し、全自動インストール
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

  # インストール直後にこのスクリプト内で cargo コマンドを使えるようにパスを読み込む
  source "$HOME/.cargo/env"
else
  echo "Rust (Cargo) is already installed."
  # 既にインストールされている場合も、念のためパスを読み込んでおく
  source "$HOME/.cargo/env"
fi

# 2. Cargo経由で tree-sitter-cli をインストール
echo "Installing tree-sitter-cli via Cargo..."
# cargo install は既にインストール済みであれば自動でスキップ・または更新チェックをしてくれます
cargo install \
  tree-sitter-cli \
  ripgrep \
  fd-find
