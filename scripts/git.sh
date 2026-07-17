#!/bin/bash
set -euo pipefail

GIT_LOCAL_CONFIG="$HOME/.config/git/config.local"
SSH_KEY="$HOME/.ssh/id_ed25519"

echo "========================================="
echo "Setting up Git, GPG, and SSH..."

if [ ! -f "$GIT_LOCAL_CONFIG" ]; then
  read -p "Git ユーザー名: " git_name
  read -p "Git メールアドレス: " git_email

  # GPGのインストールと生成
  if ! command -v gpg &>/dev/null; then
    echo "Installing gnupg..."
    sudo apt update && sudo apt install -y gnupg
  fi

  if ! gpg --list-secret-keys --keyid-format=long "$git_email" >/dev/null 2>&1; then
    echo "Generating GPG key..."
    gpg --batch --gen-key <<EOF
%no-protection
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Name-Real: $git_name
Name-Email: $git_email
Expire-Date: 0
%commit
EOF
  fi

  # GPGキーIDの抽出
  KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$git_email" | grep 'sec' | tail -n1 | awk '{print $2}' | cut -d'/' -f2)

  # SSHの生成
  if [ ! -f "$SSH_KEY" ]; then
    echo "Generating SSH key..."
    mkdir -p ~/.ssh
    ssh-keygen -t ed25519 -C "$git_email" -f "$SSH_KEY" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY"
  fi

  # config.local への設定書き出し
  cat << EOF > "$GIT_LOCAL_CONFIG"
[user]
  name = $git_name
  email = $git_email
  signingkey = $KEY_ID

[commit]
  gpgsign = true
EOF
  echo "Gitローカル設定 ($GIT_LOCAL_CONFIG) を作成しました。"

  # GitHub登録用の公開鍵を表示
  echo "=== GitHubに登録する公開鍵 GPG ==="
  gpg --armor --export "$KEY_ID"
  echo "=== GitHubに登録する公開鍵 SSH ==="
  cat "$SSH_KEY.pub"
else
  echo "Gitローカル設定は既に存在するためスキップします。"
fi
