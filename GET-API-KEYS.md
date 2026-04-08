# 获取国产模型API密钥指南

## 1. DeepSeek API（必需）
### 步骤：
1. 访问 https://platform.deepseek.com
2. 注册/登录账户
3. 进入 "API Keys" 页面
4. 点击 "Create new secret key"
5. 复制生成的API密钥
6. 填写到 `.env` 文件的 `DEEPSEEK_API_KEY`

### 价格参考：
- DeepSeek Chat: $0.14/百万token
- DeepSeek Coder: $0.28/百万token
- 有免费额度：$1免费试用

## 2. 智谱AI API（推荐）
### 步骤：
1. 访问 https://open.bigmodel.cn
2. 注册/登录
3. 进入 "个人中心" → "API密钥"
4. 创建新密钥
5. 填写到 `.env` 文件的 `ZHIPU_API_KEY`

### 价格参考：
- GLM-4: 约 $0.70/百万token
- 有免费额度

## 3. 百度文心API（可选）
### 步骤：
1. 访问 https://console.bce.baidu.com/ai/
2. 注册百度智能云账户
3. 创建应用获取API Key和Secret Key
4. 填写到 `.env` 文件的 `BAIDU_API_KEY` 和 `BAIDU_SECRET_KEY`

## 4. 阿里通义API（可选）
### 步骤：
1. 访问 https://dashscope.console.aliyun.com
2. 注册阿里云账户
3. 获取API密钥

## 部署优先级建议：
1. **先配置DeepSeek** - 性价比最高，启动最快
2. **再添加智谱AI** - 作为备选模型
3. **最后配置其他** - 根据用户需求扩展

## 成本控制建议：
1. 开始时只启用DeepSeek
2. 监控API使用量
3. 设置使用量告警
4. 根据用户需求逐步添加其他模型

## 安全提醒：
1. API密钥不要泄露
2. 定期轮换密钥
3. 设置使用限额
4. 监控异常调用