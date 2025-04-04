# AppUninstaller.ps1
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::UTF8

# 使用2>&1和ForEach-Object处理可能的错误输出
Write-Host "开始清理UV缓存和文件..."

# 清理UV缓存
uv cache clean 2>&1 | ForEach-Object { "$_" }

# 获取Python目录路径并删除
$pythonDir = (uv python dir 2>&1 | Out-String).Trim()
if (Test-Path $pythonDir) {
    Write-Host "删除Python目录: $pythonDir"
    Remove-Item -Path $pythonDir -Recurse -Force -ErrorAction SilentlyContinue
} else {
    Write-Host "Python目录不存在，跳过删除"
}

# 获取工具目录路径并删除
$toolDir = (uv tool dir 2>&1 | Out-String).Trim()
if (Test-Path $toolDir) {
    Write-Host "删除工具目录: $toolDir"
    Remove-Item -Path $toolDir -Recurse -Force -ErrorAction SilentlyContinue
} else {
    Write-Host "工具目录不存在，跳过删除"
}

# 删除可执行文件
$uvPath = "$HOME\.local\bin\uv.exe"
$uvxPath = "$HOME\.local\bin\uvx.exe"

if (Test-Path $uvPath) {
    Write-Host "删除文件: $uvPath"
    Remove-Item -Path $uvPath -Force -ErrorAction SilentlyContinue
} else {
    Write-Host "$uvPath 不存在，跳过删除"
}

if (Test-Path $uvxPath) {
    Write-Host "删除文件: $uvxPath"
    Remove-Item -Path $uvxPath -Force -ErrorAction SilentlyContinue
} else {
    Write-Host "$uvxPath 不存在，跳过删除"
}

Write-Host "清理完成!"
Write-Host "请按任意键退出..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
