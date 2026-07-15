#!/bin/bash
set -euo pipefail

echo "========================================="
echo "Installing Docker Engine..."

if command -v docker &> /dev/null; then
  echo "Docker is already installed."
else
  echo "Adding Docker official GPG key and repository..."

  # 依存パッケージのインストール
  sudo apt install -y ca-certificates curl gnupg

  # Dockerの公式GPGキーを登録
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  # リポジトリの追加 (Ubuntuを想定 / Debian系なら適宜読み替えて自動判定も可能)
  source /etc/os-release
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${ID} \
    ${VERSION_CODENAME} stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Docker本体のインストール
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # sudoなしでdockerコマンドを使えるように、現在のユーザーをdockerグループに追加
  echo "Adding current user to docker group..."
  sudo usermod -aG docker "$USER"

  echo "Docker installed successfully."
  echo "※ ユーザーグループの変更を反映させるため、PC(WSL)の再起動、または 'su - $USER' が必要になる場合があります。"
fi
