# Artalk Render 部署

一键部署 Artalk 评论系统到 Render。

## 部署步骤

### 方式一：一键部署（推荐）

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

> 点击上面的按钮，登录 Render 后会自动识别 `render.yaml` 配置。

### 方式二：手动配置

1. 登录 [Render Dashboard](https://dashboard.render.com)
2. 点击 **New +** → **Blueprint**
3. 连接此 GitHub 仓库
4. Render 自动识别 `render.yaml`，创建 Web Service + PostgreSQL
5. 部署完成后，服务会自动启动

## 部署后

1. Render 会给你的服务分配一个 `.onrender.com` 域名
2. 在 Render Dashboard 中设置自定义域名（可选）：`comment.aaayuzu.cc.cd`
3. 配置 DNS：将 `comment.aaayuzu.cc.cd` 的 CNAME 指向 Render 分配的服务域名

## 初始化管理员

部署完成后，通过终端连接 Render 服务：

```bash
# 通过 Render Shell 连接
# 在 Render Dashboard → Artalk Service → Shell
./artalk admin add -u admin -e admin@example.com -p 你的密码
```

或者在 GitHub Pages 前端集成：

```html
<link href="https://你的-render-域名/dist/Artalk.css" rel="stylesheet">
<script src="https://你的-render-域名/dist/Artalk.js"></script>
<div id="Comments"></div>
<script>
Artalk.init({
  el: '#Comments',
  pageKey: '/guestbook',
  server: 'https://comment.aaayuzu.cc.cd',
  site: 'aaayuzu 留言板',
})
</script>
```
