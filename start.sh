#!/bin/sh
set -e

# 创建数据目录
mkdir -p /data/artalk

# Railway 通过 PORT 环境变量指定端口（默认 8080）
PORT=${PORT:-8080}

echo "=========================================="
echo "  Artalk 评论服务器启动中..."
echo "  端口: $PORT"
echo "  数据目录: /data/artalk"
echo "=========================================="

# 如果 Railway 提供了公共域名，配置站点 URL
if [ -n "$RAILWAY_STATIC_URL" ]; then
  export ARTALK_SITE_URL="https://$RAILWAY_STATIC_URL"
  echo "Artalk API 地址: https://$RAILWAY_STATIC_URL"
elif [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
  export ARTALK_SITE_URL="https://$RAILWAY_PUBLIC_DOMAIN"
  echo "Artalk API 地址: https://$RAILWAY_PUBLIC_DOMAIN"
fi

# 启用管理员认证
export ARTALK_AUTH_ENABLED=true

exec /app/artalk server -c /app/artalk.yml --port $PORT
