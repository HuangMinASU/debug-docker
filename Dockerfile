# 使用官方的 Go 语言镜像作为基础
# FROM golang:latest
# FROM alibaba-cloud-linux-3-registry.cn-hangzhou.cr.aliyuncs.com/alinux3/golang:1.19.4
FROM docker.xuanyuan.run/library/ubuntu:plucky

# ENV GOROOT=/usr/local/go

# 将当前目录下的 environment 文件复制到镜像内的 /etc 目录
# COPY environment /etc/environment

# 使用 /bin/sh 或 /bin/bash 取决于基础镜像的 shell
# 使文件生效，运行 source
# RUN sh -c "source /etc/environment"

# # 复制 repo 下的所有文件到镜像中的 /etc/yum.repos.d/ 并替换同名文件
# COPY repo/*.repo /etc/yum.repos.d/

# # 清理 yum 缓存并创建新的缓存
# RUN yum clean all && \
#     yum makecache

# 安装 coreutils 和网络工具包，同时安装 openssh-server
# RUN yum install -y coreutils vim curl wget net-tools openssh-server openssl gnutls 
# RUN apt-get update && apt-get install -y vim curl wget net-tools openssh-server openssl gnutls
RUN apt-get update && apt-get install -y vim curl wget net-tools openssh-server openssl 
RUN apt-get install -y golang-go
RUN apt-get install -y iproute2
RUN apt-get install -y git


# # 生成 SSH 主机密钥
# RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && \
#     ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
#     ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

# 设置密钥权限
RUN chmod 600 /etc/ssh/ssh_host_rsa_key && \
    chmod 600 /etc/ssh/ssh_host_ecdsa_key && \
    chmod 600 /etc/ssh/ssh_host_ed25519_key

# 修改 SSH 配置以使用端口 5555
RUN sed -i 's/^#Port 22/Port 5555/' /etc/ssh/sshd_config

# 启动 SSH 服务
RUN systemctl enable sshd


# 创造一个普通用户 `min` 并给予高风险权限（添加 sudo 能力）
RUN useradd -m min && echo "min:123456" | chpasswd && echo "min ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 暴露端口 5555
EXPOSE 5555

# Ensure the .ssh directory exists in the image
RUN mkdir -p /root/.ssh

# Copy all files from the local .ssh directory to the /root/.ssh directory in the image
COPY .ssh/* /root/.ssh/

# Set permissions on the copied SSH keys inside the image
RUN chmod 600 /root/.ssh/*

# Change default route via startup script
COPY set_route.sh /usr/local/bin/set_route.sh
RUN chmod +x /usr/local/bin/set_route.sh

# 设置工作目录
WORKDIR /app

# 复制你的 Go 应用程序代码到容器中
COPY . .

# 将 Go proxy 设置为 Aliyun 镜像
# RUN go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/
# # 可选：验证代理是否设置成功
# RUN go env

# # 安装 Delve 调试工具
# RUN go install github.com/go-delve/delve/cmd/dlv@v1.20.1

# 构建应用程序，确保编译为可调试的模式
# RUN go build -gcflags "all=-N -l" -o myapp

# 启动 SSH 服务和 Delve 进行调试
# CMD ["/bin/bash", "-c", "/usr/sbin/sshd -D & dlv debug --headless --listen=:2345 --api-version=2 --log myapp"]
CMD ["/bin/bash", "-c", "/usr/sbin/sshd -D & tail -f /dev/null"]
