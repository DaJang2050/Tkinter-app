# 设置控制台编码为UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "第一步：从本地安装uv"
Set-Location -Path ".\uv"
# 设置 INSTALLER_DOWNLOAD_URL 环境变量 实现从本地安装，避免Github网络问题
$env:INSTALLER_DOWNLOAD_URL = (Get-Location).Path
# 执行 uv-installer.ps1 脚本
try {
    & powershell -ExecutionPolicy ByPass -File .\uv-installer.ps1 2>&1 | ForEach-Object { "$_" }
} catch {
    Write-Host "安装uv时发生错误: $_" -ForegroundColor Red
}

# 返回上一级目录，进入 python 目录
Set-Location -Path "..\python"

Write-Host "第二步：开始安装Python环境"
# 安装 Python 3.11.9，指定本地镜像源，避免Github网络问题
$LOCAL_MIRROR = "file:///" + ((Get-Location).Path -replace '\\','/')
# 通过将命令输出作为字符串处理，避免错误标记
uv python install 3.11.9 --mirror "$LOCAL_MIRROR" 2>&1 | ForEach-Object { "$_" }

Write-Host "第三步：使用uv恢复环境"
# 同步依赖，指定清华镜像源
uv sync --default-index "https://pypi.tuna.tsinghua.edu.cn/simple" 2>&1 | ForEach-Object { "$_" }

Write-Host "第四步：运行 app.py"
uv run app.py

Write-Host "请按任意键退出!"
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
