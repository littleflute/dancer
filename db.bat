@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 设置生成的索引文件名
set "indexFile=index.HTML"

:: 清空或创建索引文件并写入HTML头部
echo ^<!DOCTYPE html^> > "%indexFile%"
echo ^<html lang="zh-CN"^> >> "%indexFile%"
echo ^<head^> >> "%indexFile%"
echo ^<meta charset="UTF-8"^> >> "%indexFile%"
echo ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> "%indexFile%"
echo ^<title^>文件索引页面^</title^> >> "%indexFile%"
echo ^<style^> >> "%indexFile%"
echo body { font-family: Arial, sans-serif; max-width: 800px; margin: 2rem auto; padding: 0 1rem; } >> "%indexFile%"
echo h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 0.5rem; } >> "%indexFile%"
echo .file-list { list-style: none; padding: 0; } >> "%indexFile%"
echo .file-item { margin: 0.8rem 0; padding: 0.8rem; background: #f8f9fa; border-radius: 4px; } >> "%indexFile%"
echo .file-link { color: #3498db; text-decoration: none; font-size: 1.1rem; } >> "%indexFile%"
echo .file-link:hover { color: #2980b9; text-decoration: underline; } >> "%indexFile%"
echo .file-path { color: #7f8c8d; font-size: 0.9rem; margin-top: 0.3rem; } >> "%indexFile%"
echo .footer { margin-top: 2rem; color: #95a5a6; font-size: 0.8rem; text-align: center; } >> "%indexFile%"
echo ^</style^> >> "%indexFile%"
echo ^</head^> >> "%indexFile%"
echo ^<body^> >> "%indexFile%"
echo ^<h1^>当前目录HTML文件索引^</h1^> >> "%indexFile%"
echo ^<ul class="file-list"^> >> "%indexFile%"

:: 遍历当前目录下的HTML文件（排除自身）
set "fileCount=0"
for %%f in (*.html *.HTML) do (
    :: 排除索引文件本身（不区分大小写）
    if /i not "%%~nxf"=="%indexFile%" (
        :: 避免重复添加（处理大小写不同的同名文件）
        set "lowerName=%%~nxf"
        set "lowerName=!lowerName:~0,-5!"
        if not defined added_!lowerName! (
            set "added_!lowerName!=1"
            set /a fileCount+=1
            :: 写入文件链接
            echo ^<li class="file-item"^> >> "%indexFile%"
            echo ^<a class="file-link" href="%%~nxf"^>%%~nf^</a^> >> "%indexFile%"
            echo ^<div class="file-path"^>路径: .\%%~nxf^</div^> >> "%indexFile%"
            echo ^</li^> >> "%indexFile%"
        )
    )
)

:: 处理无其他HTML文件的情况
if !fileCount! equ 0 (
    echo ^<li^>当前目录下未找到其他HTML文件^</li^> >> "%indexFile%"
)

:: 写入HTML尾部
echo ^</ul^> >> "%indexFile%"
echo ^<div class="footer"^>生成时间: %date% %time% ^| 共 %fileCount% 个文件^</div^> >> "%indexFile%"
echo ^</body^> >> "%indexFile%"
echo ^</html^> >> "%indexFile%"

:: 完成提示
echo.
echo ==============================================
echo 索引文件生成完成！
echo 文件路径: %cd%\%indexFile%
echo 共包含 %fileCount% 个HTML文件链接
echo ==============================================
echo.

:: 可选：自动打开生成的文件
choice /c YN /m "是否立即打开索引文件 (Y/N)："
if errorlevel 2 goto end
if errorlevel 1 start "" "%indexFile%"

:end
pause >nul