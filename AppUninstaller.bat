@echo off
chcp 65001 > nul

echo 执行："uv cache clean"
powershell -Command "uv cache clean"

echo 执行："rm -r "$(uv python dir)""
powershell -Command "rm -r "$(uv python dir)""

echo 执行："rm -r "$(uv tool dir)""
powershell -Command "rm -r "$(uv tool dir)""

echo 执行：rm $HOME\.local\bin\uv.exe
powershell -Command "rm $HOME\.local\bin\uv.exe"

echo 执行：rm $HOME\.local\bin\uvx.exe
powershell -Command "rm $HOME\.local\bin\uvx.exe"

echo 完成，请按回车键退出！
pause 