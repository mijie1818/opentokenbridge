#!/bin/bash

# One API 一键部署脚本
# 适用于 Render.com

echo "=== One API 部署准备 ==="

# 检查必要工具
if ! command -v git &> /dev/null; then
    echo "错误: 需要安装 git"
    exit 1
fi

echo "1. 克隆或初始化项目..."
if [ ! -f "render.yaml" ]; then
    echo "错误: 找不到 render.yaml 文件"
    exit 1
fi

echo "2. 请设置环境变量:"
echo "   - 复制 .env.example 为 .env"
echo "   - 编辑 .env 文件，填写实际值"
echo ""
echo "3. 部署到 Render.com:"
echo ""
echo "   方法A: 通过Web控制台"
echo "   1. 访问 https://dashboard.render.com"
echo "   2. 点击 'New +' → 'Blueprint'"
echo "   3. 连接Git仓库或上传本文件夹"
echo "   4. 应用Blueprint配置"
echo ""
echo "   方法B: 通过CLI (需要安装Render CLI)"
echo "   render blueprint launch"
echo ""
echo "4. 部署完成后:"
echo "   - 访问你的服务URL"
echo "   - 使用用户名 'root' 和设置的密码登录"
echo "   - 立即更改默认密码"
echo "   - 配置API渠道和令牌"

echo ""
echo "=== 部署文件清单 ==="
ls -la render.yaml .env.example one-api-deploy.md deploy.sh