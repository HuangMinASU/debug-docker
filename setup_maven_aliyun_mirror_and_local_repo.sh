#!/bin/bash

# 开启debug模式
set -x

# Maven安装目录，确保指向你的实际Maven安装路径
MAVEN_HOME="$HOME/maven/apache-maven-3.9.11"

# 检查Maven是否安装
if [ ! -d "$MAVEN_HOME" ]; then
  echo "Error: Maven is not installed in $MAVEN_HOME!"
  exit 1
fi

# 定义settings.xml路径
SETTINGS_FILE="$MAVEN_HOME/conf/settings.xml"

# 备份原始settings.xml
cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

# 定义新的本地仓库路径
LOCAL_REPO="$HOME/maven/repo"

# 创建本地仓库目录，如果不存在
mkdir -p "$LOCAL_REPO"

# 更新或添加新的本地仓库路径和阿里云镜像源
if command -v xmlstarlet &> /dev/null; then
  # 将注释的<localRepository>移到外面并更新它的内容
  xmlstarlet ed -L \
    -d "/settings/comment()[contains(.,'<localRepository>')]" \ # 删除注释中的<localRepository>
    -s "/settings" -t elem -n "localRepository" -v "$LOCAL_REPO" \ # 添加<localRepository>到settings节点中
    "$SETTINGS_FILE"

  # 添加或更新<mirrors>中的阿里云镜像
  xmlstarlet ed -L -N x=http://maven.apache.org/SETTINGS/1.2.0 \
    -s "/x:settings/x:mirrors" -t elem -n "mirror" \
    -s "/x:settings/x:mirrors/mirror[last()]" -t elem -n "id" -v "aliyun-public" \
    -s "/x:settings/x:mirrors/mirror[last()]" -t elem -n "mirrorOf" -v "central" \
    -s "/x:settings/x:mirrors/mirror[last()]" -t elem -n "name" -v "Aliyun Public Repository" \
    -s "/x:settings/x:mirrors/mirror[last()]" -t elem -n "url" -v "https://maven.aliyun.com/repository/public" \
    "$SETTINGS_FILE"
else
  echo "xmlstarlet command not found. Install it before running this script."
  exit 1
fi

echo "Alibaba Cloud Maven Mirror and local repository setup complete!"

# 关闭debug模式
set +x
