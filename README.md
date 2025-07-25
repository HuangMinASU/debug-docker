# DockerDebug
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

