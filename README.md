# Artalk Deploy — Hugging Face Spaces 🚀

为 [aaayuzu.cc.cd](https://aaayuzu.cc.cd) 部署 Artalk 评论系统。

## 一键部署到 Hugging Face Spaces

### 方式一：连接 GitHub 仓库（推荐）

1. 打开 https://huggingface.co/new-space
2. 填写以下信息：
   - **Space Name**: `artalk-deploy`
   - **License**: 选 `MIT`
   - **Space SDK**: 选 **Docker**
   - **Space Hardware**: 选 **CPU basic**（免费）
   - **Repository**: 点 "Connect Git Repository" → 连接 `Eon-02/artalk-deploy`
3. 点 **Create Space**
4. 等待自动构建完成（约 3-5 分钟）

### 方式二：手动推送

```bash
git clone https://huggingface.co/spaces/你的用户名/artalk-deploy
cd artalk-deploy
# 把本仓库的文件复制进去
cp -r ../artalk-deploy/* .
git add .
git commit -m "初始化 Artalk 部署"
git push
```

## 部署完成后

### 第一步：创建管理员账号

在 Space 页面点右上角的 **三个点 → Connect → Shell**，运行：

```bash
/app/artalk admin add -u admin -e admin@example.com -p <你的密码>
```

### 第二步：集成到网站

拿到 Space 的域名（如 `https://你的用户名-artalk-deploy.hf.space`），在网页中添加：

```html
<link href="https://你的用户名-artalk-deploy.hf.space/dist/Artalk.css" rel="stylesheet">
<script src="https://你的用户名-artalk-deploy.hf.space/dist/Artalk.js"></script>
<div id="Comments"></div>
<script>
Artalk.init({
  el: '#Comments',
  pageKey: '/guestbook',
  server: 'https://你的用户名-artalk-deploy.hf.space',
  site: 'aaayuzu 留言板',
})
</script>
```

## 文件说明

| 文件 | 用途 |
|------|------|
| `Dockerfile` | HF Spaces 构建镜像的配方（暴露端口 7860） |
| `artalk.yml` | Artalk 配置（SQLite + /data 持久化） |
| `start.sh` | 启动脚本（适配 HF Spaces 的 \$PORT 环境变量） |
