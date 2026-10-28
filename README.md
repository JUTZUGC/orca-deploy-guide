# Orca 一键安装指南

> 第三方部署指南 · 非 Orca 官方仓库。官方项目：[stablyai/orca](https://github.com/stablyai/orca)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://www.onorca.dev/docs)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己找安装包，让百度搭子按你的系统下载、校验并打开安装向导。

⚠️ 仅支持电脑端（Windows / macOS / Linux），手机端只有配套的监控 App。Orca 本身不提供模型，需要你自己已有 Claude Code / Codex 等 CLI 代理与对应订阅或 API Key。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/orca-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按你的系统下载对应的安装包、核对 SHA256，再打开安装向导；Windows / macOS 需要你在向导里点几下确认，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## Orca 是什么？

Orca 是开源的把多个 AI 编程 Agent 放进一个工作台的桌面应用（协议：MIT，<img src="https://img.shields.io/github/stars/stablyai/orca?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把 Claude Code、Codex、Grok、Cursor、OpenCode 等 CLI 代理放进同一个窗口：每个任务开独立 git worktree 并行跑，同时有终端分屏、内置浏览器与 Design Mode，还能从手机看进度、接管对话。

- 支持的 Agent：Claude Code、Codex、Grok、Cursor、GitHub Copilot、OpenCode、Qwen Code、Kimi、Goose 等，终端里能跑的 CLI 都能接
- 并行方式：一个需求分给多个 Agent，各自独立 worktree，跑完对比结果再合并
- 额外能力：终端分屏、内置浏览器 / Design Mode、GitHub 与 Linear 任务、SSH 远程 worktree、CLI 脚本
- 平台：macOS（Intel / Apple Silicon）、Windows、Linux（AppImage / deb / rpm），另有 iOS / Android 配套 App

（来源：[官方仓库](https://github.com/stablyai/orca)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 108.5k stars，更新活跃 | 最新 v1.4.243（2026-10-28），仓库当天仍有提交 |
| 多 Agent 并行 | 每个任务独立 worktree，互不干扰，方便对比结果 |
| 支持面广 | Claude Code、Codex、Grok、Cursor、Copilot、OpenCode 等任意 CLI |
| 不止终端 | 内置浏览器 / Design Mode、GitHub 与 Linear、SSH 远程 |
| 三平台 + 移动端 | macOS / Windows / Linux，另有 iOS / Android 配套 App |
| MIT 协议 | 可自由修改 |

| 需要注意 | 说明 |
|---|---|
| 不提供模型 | 要自己准备 CLI 代理和订阅 / API Key |
| 安装包很大 | Windows 约 193 MB，macOS 约 259–268 MB，Linux 约 234 MB |
| 必须在图形界面用 | 没有网页版；服务器场景只能通过 SSH 远程 worktree |
| 移动端只是配套 | 手机 App 不能单独跑 Agent，需要和桌面端配对 |
| 迭代非常快 | 几乎每天发版，界面和文档以最新 Release 为准 |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
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
```

安装包来源：[https://github.com/stablyai/orca/releases/tag/v1.4.243](https://github.com/stablyai/orca/releases/tag/v1.4.243)

## 验证状态

| 场景 | 状态 |
|---|---|
| Release v1.4.243 的资产与 SHA256 digest 已核对 | 已核对 2026-10-28 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-25 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-25 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

Orca 本身不是 MCP server，也不强制 MCP；它运行的是你已有的 CLI 代理，MCP 能力由那些代理自己提供。本仓库的 MCP 只提供安装步骤、包选择与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\orca-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后：接上你的 Agent

1. 打开 Orca，按引导选择本机已安装的 CLI 代理（Claude Code / Codex / OpenCode 等）
2. 新建工作区并选一个 git 仓库，Orca 会为每个任务创建独立 worktree
3. 同一个需求可以分给多个 Agent 并行跑，跑完对比 diff 再合并
4. 手机上装 Orca 配套 App，与桌面端配对后可以看进度、发后续指令

> Orca 不卖模型额度：Agent 的订阅 / API Key 由你自己准备。Linux 的 AppImage 需要先 `chmod +x`，本指南的脚本已经处理。

## 常见坑

- Orca 不附带模型：先装好 Claude Code / Codex 等 CLI 并登录，再在 Orca 里选择它
- macOS 首次打开若提示无法验证开发者：到「系统设置 → 隐私与安全性」点「仍要打开」
- Windows 若弹出 SmartScreen：点「更多信息 → 仍要运行」
- Linux 的 AppImage 要先 `chmod +x`；缺 FUSE 时可加 `--appimage-extract-and-run` 启动
- 手机端只是配套：必须和桌面端配对，不能单独使用
- macOS 分 Intel 和 Apple Silicon 两个包，下错会打不开或明显变慢
- 项目几乎每天发版，遇到问题先确认是不是旧版本

## 免责声明

本仓库为第三方指南，与 Orca 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://www.onorca.dev/docs)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
