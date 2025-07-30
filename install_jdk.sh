#!/bin/bash

# 定义JDK安装包路径
PKG_DIR="pkg"
JDK_TAR="$PKG_DIR/jdk-17.0.12_linux-x64_bin.tar.gz"

# 检查JDK安装包是否存在
if [ ! -f "$JDK_TAR" ]; then
  echo "Error: $JDK_TAR file not found!"
  exit 1
fi

# 创建JDK安装目录
INSTALL_DIR="$HOME/jdk"
mkdir -p "$INSTALL_DIR"

# 解压JDK到安装目录
echo "Installing JDK to $INSTALL_DIR..."
tar -C "$INSTALL_DIR" -xzf "$JDK_TAR"

# 获取解压后的目录名（通常是jdk-17.0.12的格式）
JDK_DIR=$(tar -tf "$JDK_TAR" | head -1 | cut -f1 -d"/")

# 更新环境变量
echo "Configuring environment variables..."

SHELL_CONFIG="$HOME/.bashrc"

if [ -n "$ZSH_VERSION" ]; then
  SHELL_CONFIG="$HOME/.zshrc"
fi

# 添加JDK的bin目录到PATH
grep -qxF "export PATH=\$PATH:$INSTALL_DIR/$JDK_DIR/bin" "$SHELL_CONFIG" || echo "export PATH=\$PATH:$INSTALL_DIR/$JDK_DIR/bin" >> "$SHELL_CONFIG"

# 设置JAVA_HOME
grep -qxF "export JAVA_HOME=$INSTALL_DIR/$JDK_DIR" "$SHELL_CONFIG" || echo "export JAVA_HOME=$INSTALL_DIR/$JDK_DIR" >> "$SHELL_CONFIG"

# 重新加载shell配置
echo "Reloading shell configuration..."
source "$SHELL_CONFIG"

# 验证安装
if command -v java &> /dev/null; then
  echo "JDK installed successfully!"
  java -version
else
  echo "Failed to install JDK."
fi
