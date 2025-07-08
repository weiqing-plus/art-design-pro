#!/bin/bash
set -e

UPSTREAM_REPO="https://github.com/Daymychen/art-design-pro.git"
UPSTREAM_REMOTE="upstream"
FORK_REMOTE="origin"
MAIN_BRANCH="main"

echo "🔧 检查是否存在 upstream remote..."

if ! git remote get-url "$UPSTREAM_REMOTE" > /dev/null 2>&1; then
    echo "📡 添加 upstream 远程仓库: $UPSTREAM_REPO"
    git remote add "$UPSTREAM_REMOTE" "$UPSTREAM_REPO"
else
    echo "✅ upstream 已存在: $(git remote get-url $UPSTREAM_REMOTE)"
fi

echo "🚀 获取 upstream 最新变更..."
git fetch "$UPSTREAM_REMOTE"

echo "📦 切换到 $MAIN_BRANCH 分支"
git checkout "$MAIN_BRANCH"

echo "🧬 合并 upstream/$MAIN_BRANCH 到本地"
git merge "$UPSTREAM_REMOTE/$MAIN_BRANCH"

echo "📤 推送合并结果到 $FORK_REMOTE/$MAIN_BRANCH"
git push "$FORK_REMOTE" "$MAIN_BRANCH"

echo "✅ 同步完成！"

echo
read -p "📂 是否创建简化版本分支？(y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    SIMPLIFIED_BRANCH="base"
    git checkout -b "$SIMPLIFIED_BRANCH"
    echo "✅ 创建并切换到简化版本分支: $SIMPLIFIED_BRANCH"
    echo "👉 请在该分支进行代码裁剪与改造工作。"
fi
