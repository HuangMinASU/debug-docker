#!/bin/bash

# 定义Go安装包路径
PKG_DIR="pkg"
GO_TAR="$PKG_DIR/go1.24.5.linux-amd64.tar.gz"

# 检查Go安装包是否存在
if [ ! -f "$GO_TAR" ]; then
  echo "Error: $GO_TAR file not found!"
  exit 1
fi

# 创建Go安装目录
INSTALL_DIR="$HOME/go"
mkdir -p "$INSTALL_DIR"

# 解压Go到安装目录
echo "Installing Go to $INSTALL_DIR..."
tar -C "$INSTALL_DIR" -xzf "$GO_TAR"

# 更新环境变量
echo "Configuring environment variables..."

SHELL_CONFIG="$HOME/.bashrc"

if [ -n "$ZSH_VERSION" ]; then
  SHELL_CONFIG="$HOME/.zshrc"
fi

# 添加Go的bin目录到PATH
grep -qxF "export PATH=\$PATH:$INSTALL_DIR/go/bin" "$SHELL_CONFIG" || echo "export PATH=\$PATH:$INSTALL_DIR/go/bin" >> "$SHELL_CONFIG"

# 重新加载shell配置
echo "Reloading shell configuration..."
source "$SHELL_CONFIG"

# 验证安装
if command -v go &> /dev/null; then
  echo "Go installed successfully!"
  go version
else
  echo "Failed to install Go."
fi
