#!/usr/bin/env bash
set -euo pipefail
# Orca 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://www.onorca.dev/docs
# 更新日期：2026-10-25
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

BASE=https://github.com/stablyai/orca/releases/download/v1.4.240
if [ "$(uname -s)" = "Darwin" ]; then
  if [ "$(uname -m)" = "arm64" ]; then PKG=orca-macos-arm64.dmg; SUM=6020a633e2f3775d77395f5a9703f9a11d31fbf0fe0afeab8dbed39e140fbe90; else PKG=orca-macos-x64.dmg; SUM=24ae4ded325e058edde6819bfe80f80f96fd478316c8eec8ee6307df77d3221f; fi
else
  if [ "$(uname -m)" = "aarch64" ] || [ "$(uname -m)" = "arm64" ]; then PKG=orca-linux-arm64.AppImage; SUM=e93bfe0f0c8c18bfccd8b422f91baa174161e4f21194a035cc3c61a694a16371; else PKG=orca-linux.AppImage; SUM=fa9c96016487020ee51b2f889ae8495fc4934a3666ee9767532ff0457013b4be; fi
fi
curl -fL -o "$PKG" "$BASE/$PKG"
if command -v sha256sum >/dev/null 2>&1; then echo "$SUM  $PKG" | sha256sum -c -; else echo "$SUM  $PKG" | shasum -a 256 -c -; fi
if [ "$(uname -s)" = "Darwin" ]; then open "$PKG"; else chmod +x "$PKG"; echo "运行 ./$PKG 即可启动"; fi

echo ""

echo "安装完成：打开 Orca 后先连接你已有的 CLI Agent（如 Claude Code），再新建工作区开始用"
echo "若结果异常或需要改配置，请参考官方文档：https://www.onorca.dev/docs"
