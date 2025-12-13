@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM 设置输出文件名
set "OUTPUT_FILE=index.HTML"

REM 删除已存在的输出文件（如果存在）
if exist "%OUTPUT_FILE%" (
    echo 删除已存在的 %OUTPUT_FILE%
    del "%OUTPUT_FILE%"
)

REM 开始生成HTML文件
echo ^<!DOCTYPE html^> >> "%OUTPUT_FILE%"
echo ^<html lang="zh-CN"^> >> "%OUTPUT_FILE%"
echo ^<head^> >> "%OUTPUT_FILE%"
echo     ^<meta charset="UTF-8"^> >> "%OUTPUT_FILE%"
echo     ^<title^>当前目录HTML文件索引^</title^> >> "%OUTPUT_FILE%"
echo     ^<style^> >> "%OUTPUT_FILE%"
echo         body { font-family: Arial, sans-serif; margin: 40px; } >> "%OUTPUT_FILE%"
echo         h1 { color: #333; } >> "%OUTPUT_FILE%"
echo         ul { list-style-type: none; padding: 0; } >> "%OUTPUT_FILE%"
echo         li { margin: 8px 0; } >> "%OUTPUT_FILE%"
echo         a { text-decoration: none; color: #0066cc; } >> "%OUTPUT_FILE%"
echo         a:hover { text-decoration: underline; } >> "%OUTPUT_FILE%"
echo         .count { color: #666; font-style: italic; } >> "%OUTPUT_FILE%"
echo     ^</style^> >> "%OUTPUT_FILE%"
echo ^</head^> >> "%OUTPUT_FILE%"
echo ^<body^> >> "%OUTPUT_FILE%"
echo     ^<h1^>当前目录下的HTML文件^</h1^> >> "%OUTPUT_FILE%"

REM 查找当前目录下所有.html和.HTM文件（排除即将生成的index.HTML）
set /a FILE_COUNT=0
echo     ^<ul^> >> "%OUTPUT_FILE%"
for %%f in (*.html *.htm *.HTML *.HTM) do (
    if /i not "%%f"=="index.HTML" (
        if /i not "%%f"=="index.html" (
            set /a FILE_COUNT+=1
            echo         ^<li^>^<a href="%%f"^>%%f^</a^>^</li^> >> "%OUTPUT_FILE%"
        )
    )
)
echo     ^</ul^> >> "%OUTPUT_FILE%"

REM 如果未找到其他HTML文件，显示提示信息
if %FILE_COUNT% equ 0 (
    echo     ^<p^>当前目录下未找到其他HTML文件。^</p^> >> "%OUTPUT_FILE%"
) else (
    echo     ^<p class="count"^>共找到 %FILE_COUNT% 个HTML文件。^</p^> >> "%OUTPUT_FILE%"
)

REM 添加生成时间信息
echo     ^<hr^> >> "%OUTPUT_FILE%"
echo     ^<p^>本索引由 generate_index.bat 于 >> "%OUTPUT_FILE%"
echo %date% %time% >> "%OUTPUT_FILE%"
echo 自动生成。^</p^> >> "%OUTPUT_FILE%"
echo ^</body^> >> "%OUTPUT_FILE%"
echo ^</html^> >> "%OUTPUT_FILE%"

REM 完成提示
echo 已生成 %OUTPUT_FILE%，包含 %FILE_COUNT% 个HTML文件的链接。
pause
