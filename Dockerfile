FROM docker.xuanyuan.run/library/ubuntu:plucky

RUN apt-get update && apt-get install -y vim curl wget net-tools openssh-server openssl git

# 安装 Go 语言
RUN apt-get install -y golang-go

# 设置 Go 环境变量，以确保 Go 的 bin 目录在 PATH 中
ENV GOPATH=/root/go
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# 由于 Ubuntu 下可能 GOPATH 默认没有设置，这里确保它被设置
RUN mkdir -p $GOPATH

# 安装 Delve 调试工具
RUN go install github.com/go-delve/delve/cmd/dlv@latest

# 确保 dlv 安装在正确的路径并可被访问
RUN echo "PATH is $PATH" && which dlv && dlv version

# # 创建 SSH 主机密钥并设置 SSH
# RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && \
#     ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
#     ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

RUN chmod 600 /etc/ssh/ssh_host_*_key

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

RUN go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct
# 构建应用程序，确保编译为可调试的模式
RUN go build -gcflags "all=-N -l" -o myapp
# CMD ["/bin/bash", "-c", "/usr/sbin/sshd -D & tail -f /dev/null"]
CMD ["/bin/bash", "-c", "/usr/sbin/sshd -D & dlv debug --headless --listen=:2345 --api-version=2 --log myapp & tail -f /dev/null"]
