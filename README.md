# DockerDebug
go install github.com/go-delve/delve/cmd/dlv@latest
min@ubuntu:~/code/debug-docker$ echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
min@ubuntu:~/code/debug-docker$ source ~/.bashrc

min@ubuntu:~/code/debug-docker$ dlv debug main.go 
Type 'help' for list of commands.
(dlv) 



docker 调试

docker run --rm -v /home/min/code:/app -w /app alibaba-cloud-linux-3-registry.cn-hangzhou.cr.aliyuncs.com/alinux3/golang:1.19.4 go build



docker run --rm -it -v /home/min/code/DockerDebug:/app -w /app docker.io/library/myapp /bin/bash

docker.io/library/myapp



  git config --global user.email "gea@live.com"
  git config --global user.name "MinHuang"


fatal: 无法自动探测邮件地址（得到 'root@ubuntu22.(none)'）
root@ubuntu22:/home/min/code/DockerDebug# ^C
root@ubuntu22:/home/min/code/DockerDebug#   git config --global user.email "gea@live.com"
  git config --global user.name "MinHuang"
root@ubuntu22:/home/min/code/DockerDebug# git commit -m "你的提交信息"
位于分支 master
您的分支与上游分支 'origin/master' 一致。

未跟踪的文件:
  （使用 "git add <文件>..." 以包含要提交的内容）
	1.txt
	Dockerfile
	README2.md
	environment
	git.md
	go.mod
	main.go
	myapp
	repo/

提交为空，但是存在尚未跟踪的文件（使用 "git add" 建立跟踪）
root@ubuntu22:/home/min/code/DockerDebug# git add .
root@ubuntu22:/home/min/code/DockerDebug# git commit -m "你的提交信息"
[master 06c5ac9] 你的提交信息
 14 files changed, 259 insertions(+)
 create mode 100644 1.txt
 create mode 100644 Dockerfile
 create mode 100644 README2.md
 create mode 100644 environment
 create mode 100644 git.md
 create mode 100644 go.mod
 create mode 100644 main.go
 create mode 100755 myapp
 create mode 100644 repo/alinux3-module.repo
 create mode 100644 repo/alinux3-os.repo
 create mode 100644 repo/alinux3-plus.repo
 create mode 100644 repo/alinux3-powertools.repo
 create mode 100644 repo/alinux3-updates.repo
 create mode 100644 repo/epel.repo





### 使用说明：

1. 确保脚本`install_go.sh`文件和目录结构如下：
   ```
   ├── install_go.sh
   └── pkg
       └── go1.24.5.linux-amd64.tar.gz
   ```

2. 赋予脚本执行权限：
   ```bash
   chmod +x install_go.sh
   ```

3. 执行脚本：
   ```bash
   ./install_go.sh
   ```

该脚本加载时会检查`pkg`目录下是否存在`go1.24.5.linux-amd64.tar.gz`文件，然后按需解压文件并配置环境变量。如果行已存在，则不会重复添加环境变量设置。




### 使用说明：

1. 确保脚本`install_jdk.sh`文件和目录结构如下：
   ```
   ├── install_jdk.sh
   └── pkg
       └── jdk-17.0.12_linux-x64_bin.tar.gz
   ```

2. 赋予脚本执行权限：
   ```bash
   chmod +x install_jdk.sh
   ```

3. 执行脚本：
   ```bash
   ./install_jdk.sh
   ```

脚本会解压相应的JDK文件到你的主目录中的`jdk`目录，并在你的shell配置文件中设置`PATH`和`JAVA_HOME`环境变量。这样就可以直接从命令行使用`java`命令来检查安装是否成功。




git config --global user.email "gea@live.com"
git config --global user.name "Min Huang"




了解了文件名称之后，你可以根据提供的文件来调整脚本。对于你的情况，我将假设已经有`apache-maven-3.9.11-bin.tar.gz`在和`install_jdk.sh`同样的`pkg`目录中。以下是更新后的 Maven 安装脚本：

```bash
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
```

### 使用说明：

1. 确保脚本`install_maven.sh`文件和目录结构如下：
   ```
   ├── install_maven.sh
   └── pkg
       └── apache-maven-3.9.11-bin.tar.gz
   ```

2. 赋予脚本执行权限：
   ```bash
   chmod +x install_maven.sh
   ```

3. 执行脚本：
   ```bash
   ./install_maven.sh
   ```

这个脚本会解压相应的 Maven 文件到你主目录中的 `maven` 目录，并在你的 shell 配置文件中设置 `PATH` 环境变量，以便从命令行使用 `mvn` 命令来测试 Maven 安装是否成功。



### 使用说明：前提安装 yum install xmlstarlet 或dnf install xmlstarlet xmlstarlet 是一个命令行工具，用来处理 XML 文件。如果想用它来编辑 settings.xml 文件，你需要先安装这个工具。
1. 保存上述脚本为一个文件，例如 `setup_maven_aliyun_mirror_and_local_repo.sh`。

2. 赋予脚本执行权限：
   ```bash
   chmod +x setup_maven_aliyun_mirror_and_local_repo.sh
   ```

3. 执行脚本：
   ```bash
   ./setup_maven_aliyun_mirror_and_local_repo.sh
   ```

此脚本会在更新 `settings.xml` 时同时设置阿里云镜像作为 Maven 的远程仓库，并将本地存储路径设置为 `$HOME/maven/repo`。如果该路径不存在，脚本会自动创建这个目录。




### 使用说明：

1. 将新的 `settings.xml` 文件保存到一个你指定的路径，比如 `/path/to/your/new/settings.xml`。

2. 编辑脚本，将 `NEW_SETTINGS_FILE` 的路径设为你的新 `settings.xml` 文件的实际位置。

3. 保存脚本为一个文件，例如 `replace_maven_settings.sh`。

4. 赋予脚本执行权限：
   ```bash
   chmod +x replace_maven_settings.sh
   ```

5. 执行脚本：
   ```bash
   ./replace_maven_settings.sh
   ```

此脚本会检查新 `settings.xml` 文件是否存在，备份现有的 `settings.xml`，然后用新的文件替换它。确保在执行脚本之前，确保对上述路径和文件名称的设置正确无误，以免意外丢失配置文件。