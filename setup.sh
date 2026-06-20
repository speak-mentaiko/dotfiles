#!/bin/bash

# エラー発生時や未定義変数参照時にスクリプトを終了させる
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

echo "========================================="
# 1. ディレクトリの準備とシンボリックリンクの作成
echo "1. Creating symbolic links..."
mkdir -p "$HOME/.config"

# 既存のファイル/フォルダがある場合はバックアップを取るか削除して上書き
ln -snf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -snf "$DOTFILES_DIR/mise" "$HOME/.config/mise"
ln -snf "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"

echo "Symbolic links created successfully."
echo "========================================="

# 2. mise 自体のインストール
echo "2. Checking mise installation..."
if ! command -v mise &> /dev/null; then
    echo "mise is not found. Installing mise..."
    curl https://mise.jdx.dev/install.sh | sh

    # このスクリプト内だけで一時的に mise コマンドを通す
    export PATH="$HOME/.local/share/mise/bin:$PATH"
    eval "$($HOME/.local/share/mise/bin/mise activate bash)"
else
    echo "mise is already installed."
fi
echo "========================================="

# 3. mise/config.toml に基づくツールのインストール（Neovim, Nodeなど）
echo "3. Installing tools via mise (Neovim, etc.)..."
if command -v mise &> /dev/null; then
    # config.toml に記載されたツールをグローバルとして一括インストール
    mise install --global
    echo "Tools installed successfully."
else
    echo "Error: mise activation failed. Skipping tool installation."
    exit 1
fi

echo "========================================="
echo "Setup completed successfully!"
echo "Please run 'source ~/.bashrc' or restart your terminal to apply changes."
echo "========================================="
