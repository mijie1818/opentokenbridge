# One API 部署指南

## 镜像信息
- 镜像: `justsong/one-api:latest`
- 官方仓库: https://github.com/songquanpeng/one-api

## 必需的环境变量

### 数据库配置
1. **SQL_DSN** - 数据库连接字符串
   - MySQL示例: `mysql://username:password@hostname:3306/database_name`
   - PostgreSQL示例: `postgres://username:password@hostname:5432/database_name`
   - SQLite示例: `sqlite:///data/one-api.db` (本地文件)

2. **REDIS_DSN** (可选) - Redis连接字符串，用于缓存和会话
   - 示例: `redis://:password@hostname:6379/0`

### 管理员账户
3. **INITIAL_ADMIN_PASSWORD** - 初始管理员密码
   - 首次启动时自动创建管理员账户
   - 用户名: `root`
   - 密码: 由此变量设置

### 其他重要配置
4. **PORT** - 服务端口 (默认: 3000)
5. **SESSION_SECRET** - 会话密钥 (建议设置)
6. **LOG_DIR** - 日志目录 (默认: `/app/logs`)
7. **SQLITE_PATH** - SQLite数据库路径 (如果使用SQLite)

## Render.com 部署步骤

### 方法1: 通过Web控制台部署
1. 登录 Render.com
2. 点击 "New +" → "Web Service"
3. 选择 "Deploy an existing image from a registry"
4. 输入镜像地址: `justsong/one-api:latest`
5. 配置环境变量 (见上文)
6. 设置服务名称和地区
7. 点击 "Create Web Service"

### 方法2: 通过Blueprint部署 (推荐)
创建 `render.yaml` 文件:

```yaml
services:
  - type: web
    name: one-api
    image: justsong/one-api:latest
    envVars:
      - key: SQL_DSN
        value: postgres://username:password@hostname:5432/oneapi
      - key: INITIAL_ADMIN_PASSWORD
        value: your_secure_password_here
      - key: PORT
        value: 3000
      - key: SESSION_SECRET
        generateValue: true
    healthCheckPath: /api/status
    autoDeploy: true
```

## 数据库设置建议

### 使用Render PostgreSQL (推荐)
1. 在Render.com创建PostgreSQL数据库
2. 获取连接字符串
3. 设置为 `SQL_DSN` 环境变量

### 使用SQLite (简单测试)
- `SQL_DSN: sqlite:///data/one-api.db`
- 需要持久化存储卷挂载 `/data` 目录

## 初始设置
1. 部署完成后访问: `https://your-service.onrender.com`
2. 使用用户名 `root` 和设置的密码登录
3. 立即更改默认密码
4. 配置渠道和令牌

## 注意事项
1. Render.com免费实例有休眠策略，考虑升级到付费计划避免休眠
2. 定期备份数据库
3. 设置合适的会话超时时间
4. 配置域名和SSL证书