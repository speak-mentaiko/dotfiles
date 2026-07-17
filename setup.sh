#!/bin/bash

# エラー発生時や未定義変数参照時にスクリプトを終了させる
set -euo pipefail

echo "========================================="
echo "システムセットアップを開始します"
echo "管理者権限が必要です。パスワードを入力してください。"
# ここで一度だけパスワードを聞く
sudo -v

# スクリプト実行中、バックグラウンドで60秒ごとにsudoの有効期限を延長し続ける魔法のコマンド
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
echo "========================================="

# システムの事前アップデート (以前のスクリプトから移植)
echo "Updating apt repositories..."
sudo apt update && sudo apt upgrade -y

DOTFILES_DIR="$HOME/dotfiles"

# 分割したスクリプトの呼び出し
bash "$DOTFILES_DIR/scripts/link.sh"
bash "$DOTFILES_DIR/scripts/git.sh"
bash "$DOTFILES_DIR/scripts/mise.sh"
bash "$DOTFILES_DIR/scripts/nvim.sh"
bash "$DOTFILES_DIR/scripts/docker.sh"

echo "========================================="
echo "Setup completed successfully!"
echo "Please run 'source ~/.bashrc' or restart your terminal to apply changes."
echo "========================================="
