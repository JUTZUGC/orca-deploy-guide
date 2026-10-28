#!/usr/bin/env bash
set -euo pipefail
# Orca 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://www.onorca.dev/docs
# 更新日期：2026-10-28
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

BASE=https://github.com/stablyai/orca/releases/download/v1.4.243
if [ "$(uname -s)" = "Darwin" ]; then
  if [ "$(uname -m)" = "arm64" ]; then PKG=orca-macos-arm64.dmg; SUM=b0d030a7f3ba0849677e4efad92c0af63ef268332c24b176df9ddd7a1f5a6551; else PKG=orca-macos-x64.dmg; SUM=ac094261cb344392d6a2536c901c312b85013edd986cd9b6eb62554dbd46cfee; fi
else
  if [ "$(uname -m)" = "aarch64" ] || [ "$(uname -m)" = "arm64" ]; then PKG=orca-linux-arm64.AppImage; SUM=3e93420836d4038e1adbbb52bf4968f97098d025022613071b79a72b0c34d672; else PKG=orca-linux.AppImage; SUM=2acc4b2815738e6ade5042961086fd161f0a2f1e11ef10d0d40d5c3bcdb317f8; fi
fi
if [ "$(uname -s)" = "Darwin" ]; then
  if [ "$(uname -m)" = "arm64" ]; then PKG=orca-macos-arm64.dmg; SUM=be5000497b370e9727c2343de50720312b9882d59ec0ba2012c02fbddc8e305e; else PKG=orca-macos-x64.dmg; SUM=cde5cb6793b53b19faeb58bb968160571428d023d62bf4c5639b6ab79bc9c90b; fi
else
  if [ "$(uname -m)" = "aarch64" ] || [ "$(uname -m)" = "arm64" ]; then PKG=orca-linux-arm64.AppImage; SUM=55d6c7a6f74159b2cd36a5052d986c7646b62fb05b72e5744658c1f4766c1536; else PKG=orca-linux.AppImage; SUM=c83b1af8e3fc6f8fad83c0c4d0fd97b9c235e92e3a1d63e90c986b018f609d4a; fi
fi
curl -fL -o "$PKG" "$BASE/$PKG"
if command -v sha256sum >/dev/null 2>&1; then echo "$SUM  $PKG" | sha256sum -c -; else echo "$SUM  $PKG" | shasum -a 256 -c -; fi
if [ "$(uname -s)" = "Darwin" ]; then open "$PKG"; else chmod +x "$PKG"; echo "运行 ./$PKG 即可启动"; fi

echo ""

echo "安装完成：打开 Orca 后先连接你已有的 CLI Agent（如 Claude Code），再新建工作区开始用"
echo "若结果异常或需要改配置，请参考官方文档：https://www.onorca.dev/docs"
