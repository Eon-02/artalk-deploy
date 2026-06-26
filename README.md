# Artalk Deploy — Railway 🚄

为 [aaayuzu.cc.cd](https://aaayuzu.cc.cd) 部署 Artalk 评论系统。

## 一键部署到 Railway

### 前置条件

- 一个 [Railway](https://railway.app) 账号（用 GitHub 登录，不需要绑卡）
- GitHub 仓库 `Eon-02/artalk-deploy`

### 部署步骤

1. 打开 https://railway.app/new
2. 点击 **Deploy from GitHub repo**
3. 选择 **Configure GitHub App** → 授权访问 `Eon-02/artalk-deploy`
4. Railway 会自动检测 `Dockerfile` 并开始构建
5. 等几分钟构建完成

### 设置域名

默认 Railway 会给一个 `xxx.up.railway.app` 的域名，这个就是你的 Artalk API 地址。

你也可以在 Railway Dashboard → 你的项目 → **Settings** → **Domains** 中绑自定义域名（比如 `comment.aaayuzu.cc.cd`）。

### 数据持久化（重要）

Railway 的容器存储是临时的。要防止数据丢失：

**方案 A：添加 Volume（推荐）**
1. 在 Railway Dashboard → 项目页面
2. 点 **Volumes** 标签 → **Add Volume**
3. 挂载点填 `/data`
4. 这样 SQLite 数据库就会持久保存

**方案 B：换成 PostgreSQL**
1. 在 Railway Dashboard → 点 **New** → **Database** → **Add PostgreSQL**
2. 拿到 PostgreSQL 的连接字符串
3. 在项目设置中添加环境变量：
   - `DB_TYPE=postgres`
   - `DB_DSN=postgres://...`（你拿到的连接字符串）

## 部署完成后

### 第一步：创建管理员账号

在 Railway Dashboard → 项目页面 → **Connect** → **Railway CLI** 或直接用 Web Shell：

```bash
/app/artalk admin add -u admin -e admin@example.com -p <你的密码>
```

### 第二步：集成到网站

拿到 Railway 的域名（如 `https://artalk-deploy.up.railway.app`），在网页中添加：

```html
<link href="https://你的域名.up.railway.app/dist/Artalk.css" rel="stylesheet">
<script src="https://你的域名.up.railway.app/dist/Artalk.js"></script>
<div id="Comments"></div>
<script>
Artalk.init({
  el: '#Comments',
  pageKey: '/guestbook',
  server: 'https://你的域名.up.railway.app',
  site: 'aaayuzu 留言板',
})
</script>
```

## 文件说明

| 文件 | 用途 |
|------|------|
| `Dockerfile` | Railway 构建镜像的配方 |
| `artalk.yml` | Artalk 配置（SQLite + /data 持久化） |
| `start.sh` | 启动脚本（适配 Railway 的 \$PORT 环境变量） |
