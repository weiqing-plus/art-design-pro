#!/bin/bash

# set -e 确保出错退出
set -e

# 自动检测当前分支
BRANCH_NAME=$(git branch --show-current)

echo "📦 当前分支为: $BRANCH_NAME"

# 添加所有改动
git add .

# 启动交互式提交
echo "✍️ 进入交互式 commit 模式（git-cz）..."
pnpm run commit

# 推送到远程
echo "🚀 推送到 GitHub 分支: origin/$BRANCH_NAME"
git push origin "$BRANCH_NAME"

echo "✅ 已成功提交并推送到 GitHub！"
