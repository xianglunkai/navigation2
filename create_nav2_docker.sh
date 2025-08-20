#!/bin/bash

# 设置错误处理：任何命令失败即停止执行
set -e

echo "启动容器 nav2..."

docker run \
    -itd --shm-size=32g \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_CAPABILITIES=all \
    --gpus all \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --name nav2_main \
    --hostname nav2-main-docker \
    -p 1234:1234 \
    -v /home/xlk/usr_ws/navigation:/work \
    -v /usr/local/cuda-12.6:/usr/local/cuda \
    navigation2:rolling bash 


# 检查容器状态
container_id=$(docker ps -q -f name=nav2_main)
if [ -z "$container_id" ]; then
    echo "❌ 错误：容器启动失败！"
    docker ps -a | grep nav2_main
    exit 1
fi
echo "✅ 容器成功启动 ID: $container_id"

