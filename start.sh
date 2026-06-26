#!/bin/sh
set -e

# 创建数据目录
mkdir -p /app/data

# 如果 Render 提供了外部 URL，用它来配置站点 URL
if [ -n "$RENDER_EXTERNAL_URL" ]; then
  export ARTALK_SITE_URL="$RENDER_EXTERNAL_URL"
  echo "站点 URL 已设置为: $RENDER_EXTERNAL_URL"
fi

echo "启动 Artalk 评论服务器..."
exec /app/artalk server -c /app/artalk.yml
