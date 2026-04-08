#!/bin/bash

# China AI Proxy 快速部署脚本
# 作者：OpenClaw Assistant
# 日期：2024年

set -e  # 遇到错误退出

echo "🚀 China AI Proxy 快速部署脚本"
echo "======================================"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查必要工具
check_tools() {
    echo "🔧 检查必要工具..."
    
    local missing_tools=()
    
    if ! command -v git &> /dev/null; then
        missing_tools+=("git")
    fi
    
    if ! command -v curl &> /dev/null; then
        missing_tools+=("curl")
    fi
    
    if [ ${#missing_tools[@]} -ne 0 ]; then
        echo -e "${RED}错误：缺少必要工具：${missing_tools[*]}${NC}"
        echo "请安装后再运行此脚本。"
        exit 1
    fi
    
    echo -e "${GREEN}✓ 所有必要工具已安装${NC}"
}

# 检查配置文件
check_config() {
    echo "📋 检查配置文件..."
    
    if [ ! -f ".env" ]; then
        echo -e "${YELLOW}⚠️  警告：未找到 .env 文件${NC}"
        echo "请先执行：cp .env.commercial .env"
        echo "然后编辑 .env 文件，至少填写："
        echo "1. DEEPSEEK_API_KEY"
        echo "2. ADMIN_PASSWORD"
        echo ""
        read -p "是否现在创建 .env 文件？ (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp .env.commercial .env
            echo -e "${GREEN}✓ 已创建 .env 文件${NC}"
            echo "请编辑 .env 文件后重新运行此脚本。"
            exit 0
        else
            exit 1
        fi
    fi
    
    # 检查必要配置
    if grep -q "DEEPSEEK_API_KEY=sk-your-deepseek-api-key-here" .env; then
        echo -e "${RED}错误：未配置 DeepSeek API 密钥${NC}"
        echo "请获取 DeepSeek API 密钥并填写到 .env 文件"
        echo "访问：https://platform.deepseek.com/api_keys"
        exit 1
    fi
    
    if grep -q "ADMIN_PASSWORD=change_this_immediately_after_deployment" .env; then
        echo -e "${YELLOW}⚠️  警告：使用默认管理员密码${NC}"
        echo "建议修改 ADMIN_PASSWORD 为强密码"
    fi
    
    echo -e "${GREEN}✓ 配置文件检查通过${NC}"
}

# 初始化Git仓库
init_git() {
    echo "📦 初始化Git仓库..."
    
    if [ ! -d ".git" ]; then
        git init
        echo -e "${GREEN}✓ Git仓库已初始化${NC}"
    else
        echo -e "${GREEN}✓ Git仓库已存在${NC}"
    fi
    
    # 添加文件
    git add .
    
    # 检查是否有更改
    if git diff --cached --quiet; then
        echo -e "${YELLOW}⚠️  没有需要提交的更改${NC}"
    else
        git commit -m "部署China AI Proxy - $(date '+%Y-%m-%d %H:%M:%S')"
        echo -e "${GREEN}✓ 更改已提交${NC}"
    fi
}

# 显示部署说明
show_deploy_instructions() {
    echo ""
    echo "======================================"
    echo "🎯 部署准备完成！"
    echo "======================================"
    echo ""
    echo "下一步："
    echo ""
    echo "1. ${GREEN}推送代码到Git仓库${NC}"
    echo "   如果你使用GitHub："
    echo "   git remote add origin https://github.com/你的用户名/china-ai-proxy.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
    echo ""
    echo "2. ${GREEN}在Render.com部署${NC}"
    echo "   a. 访问 https://dashboard.render.com"
    echo "   b. 点击 'New +' → 'Blueprint'"
    echo "   c. 连接你的Git仓库"
    echo "   d. 应用配置，等待部署完成"
    echo ""
    echo "3. ${GREEN}初始配置${NC}"
    echo "   a. 访问你的服务URL"
    echo "   b. 使用用户名 'root' 登录"
    echo "   c. 立即修改密码"
    echo "   d. 配置模型渠道"
    echo ""
    echo "4. ${GREEN}测试验证${NC}"
    echo "   运行测试命令验证API功能"
    echo ""
    echo "5. ${GREEN}开始营销${NC}"
    echo "   按照 MARKETING.md 开始推广"
    echo ""
    echo "======================================"
    echo "📚 详细指南："
    echo "   - 部署指南：COMMERCIAL-GUIDE.md"
    echo "   - 营销策略：MARKETING.md"
    echo "   - 检查清单：DEPLOYMENT-CHECKLIST.md"
    echo "======================================"
}

# 测试API功能（可选）
test_api() {
    echo ""
    read -p "是否测试API功能？ (需要服务已部署) (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "请输入你的服务URL（如 https://your-service.onrender.com）："
        read service_url
        
        echo "请输入测试用的API密钥："
        read -s api_key
        
        echo "测试API连接..."
        
        if curl -s -X POST "${service_url}/v1/chat/completions" \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${api_key}" \
          -d '{
            "model": "deepseek-chat",
            "messages": [{"role": "user", "content": "Hello, are you working?"}],
            "max_tokens": 50
          }' > /tmp/api_test.json 2>/dev/null; then
            
            if grep -q "choices" /tmp/api_test.json; then
                echo -e "${GREEN}✓ API测试成功！${NC}"
                echo "响应摘要："
                jq -r '.choices[0].message.content' /tmp/api_test.json 2>/dev/null || \
                cat /tmp/api_test.json | head -c 200
                echo ""
            else
                echo -e "${RED}✗ API响应异常${NC}"
                cat /tmp/api_test.json
            fi
        else
            echo -e "${RED}✗ API连接失败${NC}"
        fi
    fi
}

# 主函数
main() {
    echo "China AI Proxy - 反向代购系统部署"
    echo "版本：1.0.0"
    echo ""
    
    check_tools
    check_config
    init_git
    show_deploy_instructions
    test_api
    
    echo ""
    echo -e "${GREEN}✅ 部署准备完成！${NC}"
    echo "祝你的反向代购业务成功！💰"
}

# 运行主函数
main "$@"