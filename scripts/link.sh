#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

echo "========================================="

# ディレクトリの準備とシンボリックリンクの作成
echo "Creating symbolic links..."
mkdir -p "$HOME/.config"

# 既存のファイル/フォルダがある場合はバックアップを取るか削除して上書き
ln -snf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -snf "$DOTFILES_DIR/mise" "$HOME/.config/mise"
ln -snf "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"

echo "Symbolic links created successfully."
echo "========================================="

