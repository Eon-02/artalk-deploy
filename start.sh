#!/bin/sh
set -e

# 创建数据目录（HF Spaces 的 /data 目录是持久化的）
mkdir -p /data/artalk

# Hugging Face Spaces 通过 PORT 环境变量指定端口（默认 7860）
PORT=${PORT:-7860}

echo "=========================================="
echo "  Artalk 评论服务器启动中..."
echo "  端口: $PORT"
echo "  数据目录: /data/artalk"
echo "=========================================="

# 如果 HF 提供了外部 URL，用它来配置站点 URL
if [ -n "$SPACE_ID" ]; then
  export ARTALK_SITE_URL="https://$SPACE_ID.hf.space"
  echo "站点 URL 已设置为: https://$SPACE_ID.hf.space"
fi

exec /app/artalk server -c /app/artalk.yml -p $PORT
