# One API 一键部署

基于 Docker 镜像 `justsong/one-api:latest` 在 Render.com 上的快速部署方案。

## 快速开始

### 选项1: 使用SQLite (最简单)
1. 在Render.com创建Web Service
2. 选择镜像: `justsong/one-api:latest`
3. 设置环境变量:
   - `SQL_DSN`: `sqlite:///data/one-api.db`
   - `INITIAL_ADMIN_PASSWORD`: `你的安全密码`
   - `PORT`: `3000`
4. 添加持久化磁盘: 挂载路径 `/data`，大小1GB
5. 部署

### 选项2: 使用PostgreSQL (生产推荐)
1. 在Render.com创建PostgreSQL数据库
2. 创建Web Service
3. 设置环境变量:
   - `SQL_DSN`: `postgres://用户名:密码@主机:5432/数据库名`
   - `INITIAL_ADMIN_PASSWORD`: `你的安全密码`
   - `PORT`: `3000`
4. 部署

### 选项3: 使用Blueprint (推荐)
1. 将本文件夹推送到Git仓库
2. 在Render.com选择 "Blueprint"
3. 连接你的Git仓库
4. 应用配置

## 文件说明

- `render.yaml` - Render.com Blueprint配置文件
- `.env.example` - 环境变量示例文件
- `one-api-deploy.md` - 详细部署指南
- `deploy.sh` - 部署辅助脚本
- `README.md` - 本文件

## 环境变量详解

### 必需变量
- `SQL_DSN`: 数据库连接字符串
  - SQLite: `sqlite:///data/one-api.db`
  - PostgreSQL: `postgres://user:pass@host:5432/db`
  - MySQL: `mysql://user:pass@host:3306/db`

- `INITIAL_ADMIN_PASSWORD`: 初始管理员密码
  - 用户名: `root`
  - 首次启动后请立即修改

### 可选变量
- `PORT`: 服务端口 (默认: 3000)
- `SESSION_SECRET`: 会话密钥 (建议设置)
- `LOG_LEVEL`: 日志级别 (默认: info)
- `REDIS_DSN`: Redis连接字符串 (用于缓存)

## 部署后步骤

1. **访问服务**: `https://你的服务名.onrender.com`
2. **登录**: 用户名 `root`，密码为设置的 `INITIAL_ADMIN_PASSWORD`
3. **安全设置**:
   - 立即修改管理员密码
   - 配置会话超时
   - 设置访问限制
4. **配置渠道**:
   - 添加API提供商 (OpenAI, Anthropic等)
   - 设置令牌和配额
5. **创建用户**: 为团队成员创建子账户

## 故障排除

### 服务无法启动
- 检查环境变量是否正确
- 查看Render.com的日志输出
- 确认数据库可连接

### 数据库连接问题
- 检查SQL_DSN格式
- 确认数据库服务已启动
- 验证网络连接和防火墙设置

### 管理员无法登录
- 确认INITIAL_ADMIN_PASSWORD已正确设置
- 检查服务日志中的初始化信息
- 尝试重启服务

## 备份与维护

### 数据库备份
- **SQLite**: 定期备份 `/data/one-api.db` 文件
- **PostgreSQL**: 使用Render.com的备份功能或pg_dump

### 升级版本
1. 停止服务
2. 更新镜像标签 (如: `justsong/one-api:v0.5.0`)
3. 重新部署
4. 检查数据库迁移是否成功

## 支持与资源

- [One API 官方文档](https://github.com/songquanpeng/one-api)
- [Render.com 文档](https://render.com/docs)
- [Docker Hub 镜像](https://hub.docker.com/r/justsong/one-api)

## 许可证

本项目文件遵循 MIT 许可证。One API 软件遵循其原始许可证。