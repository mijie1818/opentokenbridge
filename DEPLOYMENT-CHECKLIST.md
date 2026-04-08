# 部署检查清单

## ✅ 第1阶段：准备工作（30分钟）

### 配置环境变量
- [ ] 复制 `.env.commercial` 为 `.env`
- [ ] 获取 DeepSeek API 密钥并填写
- [ ] 设置强管理员密码
- [ ] （可选）购买域名并填写

### 账户注册
- [ ] DeepSeek 账户：https://platform.deepseek.com
- [ ] （可选）智谱AI 账户：https://open.bigmodel.cn
- [ ] （可选）Stripe 账户：https://stripe.com

## ✅ 第2阶段：Git仓库准备（10分钟）

### 创建Git仓库
```bash
# 初始化Git
git init
git add .
git commit -m "Initial deployment of China AI Proxy"

# 推送到GitHub/GitLab
git remote add origin https://github.com/你的用户名/china-ai-proxy.git
git branch -M main
git push -u origin main
```

## ✅ 第3阶段：Render.com部署（20分钟）

### 步骤：
1. 访问 https://dashboard.render.com
2. 点击 "New +" → "Blueprint"
3. 连接你的Git仓库（GitHub/GitLab）
4. 应用配置
5. 等待部署完成（约10-15分钟）

### 部署后检查：
- [ ] 服务状态显示 "Live"
- [ ] 数据库自动创建
- [ ] 可以访问服务URL

## ✅ 第4阶段：初始配置（30分钟）

### 访问管理面板
1. 打开服务URL：https://你的服务名.onrender.com
2. 使用用户名 `root` 和设置的密码登录
3. **立即修改管理员密码**

### 配置模型渠道
1. 进入 "渠道" → "添加渠道"
2. 配置DeepSeek：
   - 类型：OpenAI
   - 基础URL：https://api.deepseek.com
   - API密钥：你的DeepSeek密钥
   - 模型：deepseek-chat
3. 测试连接

### 基本设置
1. 系统设置 → 基本设置
2. 配置站点名称、Logo等
3. 保存设置

## ✅ 第5阶段：测试验证（15分钟）

### API测试
```bash
# 测试OpenAI兼容性
curl https://你的域名/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer 你的API密钥" \
  -d '{
    "model": "deepseek-chat",
    "messages": [{"role": "user", "content": "Hello"}]
  }'
```

### 功能测试
- [ ] 用户注册
- [ ] API调用
- [ ] Token计数
- [ ] 管理面板功能

## ✅ 第6阶段：上线准备（30分钟）

### 域名配置（如果购买了域名）
1. 在Render.com添加自定义域名
2. 配置DNS记录
3. 等待SSL证书自动签发

### 监控设置
1. 检查服务日志
2. 设置基本告警
3. 测试健康检查

### 备份设置
1. 确认数据库自动备份
2. 测试恢复流程

## ✅ 第7阶段：营销启动（持续）

### 第一天行动
1. 按照 MARKETING.md 发布到Reddit
2. 在技术社区分享
3. 收集早期用户反馈

### 第一周行动
1. 优化产品体验
2. 回答用户问题
3. 开始内容营销

## 故障排除

### 常见问题：
1. **服务无法启动**：检查环境变量和日志
2. **数据库连接失败**：检查SQL_DSN配置
3. **API调用失败**：检查模型API密钥
4. **域名无法访问**：检查DNS配置

### 紧急联系人：
- Render.com支持：https://render.com/docs/support
- DeepSeek支持：https://platform.deepseek.com
- 项目文档：查看 COMMERCIAL-GUIDE.md

## 成功指标

### 技术指标：
- [ ] 服务可用性 > 99.9%
- [ ] API响应时间 < 500ms
- [ ] 错误率 < 0.1%

### 业务指标（第一周目标）：
- [ ] 10个注册用户
- [ ] 5个活跃用户
- [ ] 1个付费用户
- [ ] $50 MRR

---

**预计总时间**：2-3小时
**关键路径**：获取DeepSeek API密钥 → Git推送 → Render部署
**风险点**：API密钥配置错误、域名DNS延迟