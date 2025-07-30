#!/bin/bash

# Maven安装目录，确保指向你的实际Maven安装路径
MAVEN_HOME="$HOME/maven/apache-maven-3.9.11"

# 原始settings.xml的路径
SETTINGS_FILE="$MAVEN_HOME/conf/settings.xml"

# 新的settings.xml文件的位置
NEW_SETTINGS_FILE="/path/to/your/new/settings.xml"

# 检查新的settings.xml文件是否存在
if [ ! -f "$NEW_SETTINGS_FILE" ]; then
  echo "Error: New settings.xml not found at $NEW_SETTINGS_FILE!"
  exit 1
fi

# 备份原始settings.xml
cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

# 用新的settings.xml替换旧的
cp "$NEW_SETTINGS_FILE" "$SETTINGS_FILE"

echo "Successfully replaced the old settings.xml with the new one."
