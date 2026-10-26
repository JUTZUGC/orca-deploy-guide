# Orca 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://www.onorca.dev/docs
# 更新日期：2026-10-26
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

$exe = 'orca-windows-setup.exe'
curl.exe -L --fail -o $exe "https://github.com/stablyai/orca/releases/download/v1.4.241/$exe"
if ((Get-FileHash $exe -Algorithm SHA256).Hash.ToLower() -ne 'a63bbf18fa51d51805eb6581b766f8c0dd3a3418c62eb1f5094125173ab6b643') { throw 'SHA256 校验失败，请重新下载' }
Write-Host 'SHA256 校验通过'
Start-Process -FilePath (Join-Path $PWD $exe)

Write-Host ''

Write-Host '安装完成：打开 Orca 后先连接你已有的 CLI Agent（如 Claude Code），再新建工作区开始用'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://www.onorca.dev/docs'
