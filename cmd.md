构建镜像
cd /home/min/code/debug-docker ; docker build -t my-go-app .


构建镜像-debug
cd /home/min/code/debug-docker ; docker build -t my-go-app . --progress=plain

启动容器
docker run -d -p 5555:5555 my-go-app:latest

查询监听SSH端口

netstat -ntlp


登录容器
CONTAINER_ID=$(docker ps -q | head -n 1) && [ -n "$CONTAINER_ID" ] && echo "即将登录到容器 ID: $CONTAINER_ID" && docker exec -it $CONTAINER_ID /bin/bash || echo "没有正在运行的容器."

清理镜像
docker kill $(docker ps -q); docker rm $(docker ps -aq) && docker images -q | grep -v $(docker images docker.xuanyuan.run/library/ubuntu -q) | xargs docker rmi -f

查询运行容器


docker ps ; docker images
