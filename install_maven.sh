#!/bin/bash

# 定义Maven安装包路径
PKG_DIR="pkg"
MAVEN_TAR="$PKG_DIR/apache-maven-3.9.11-bin.tar.gz"

# 检查Maven安装包是否存在
if [ ! -f "$MAVEN_TAR" ]; then
  echo "Error: $MAVEN_TAR file not found!"
  exit 1
fi

# 创建Maven安装目录
INSTALL_DIR="$HOME/maven"
mkdir -p "$INSTALL_DIR"

# 解压Maven到安装目录
echo "Installing Maven to $INSTALL_DIR..."
tar -C "$INSTALL_DIR" -xzf "$MAVEN_TAR"

# 获取解压后的目录名（通常为apache-maven-3.9.11的格式）
MAVEN_DIR="$INSTALL_DIR/apache-maven-3.9.11"

# 更新环境变量
echo "Configuring environment variables..."

SHELL_CONFIG="$HOME/.bashrc"

if [ -n "$ZSH_VERSION" ]; then
  SHELL_CONFIG="$HOME/.zshrc"
fi

# 添加Maven的bin目录到PATH
grep -qxF "export PATH=\$PATH:$MAVEN_DIR/bin" "$SHELL_CONFIG" || echo "export PATH=\$PATH:$MAVEN_DIR/bin" >> "$SHELL_CONFIG"

# 重新加载shell配置
echo "Reloading shell configuration..."
source "$SHELL_CONFIG"

# 验证安装
if command -v mvn &> /dev/null; then
  echo "Maven installed successfully!"
  mvn -version
else
  echo "Failed to install Maven."
fi
