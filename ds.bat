@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo 正在生成 index.html...

:: 创建HTML文件头部
(
echo ^<!DOCTYPE html^>
echo ^<html lang="zh-CN"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>目录索引^</title^>
echo     ^<style^>
echo         body { font-family: Arial, sans-serif; margin: 40px; background-color: #f5f5f5; }
echo         .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
echo         h1 { color: #333; border-bottom: 2px solid #4CAF50; padding-bottom: 10px; }
echo         ul { list-style-type: none; padding: 0; }
echo         li { padding: 8px 0; border-bottom: 1px solid #eee; }
echo         a { color: #4CAF50; text-decoration: none; font-size: 16px; }
echo         a:hover { color: #45a049; text-decoration: underline; }
echo         .file-count { color: #666; margin-top: 20px; font-size: 14px; }
echo         .generated { color: #888; font-size: 12px; margin-top: 30px; border-top: 1px solid #eee; padding-top: 10px; }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="container"^>
echo         ^<h1^>HTML文件索引^</h1^>
echo         ^<p^>当前目录下的所有HTML文件：^</p^>
echo         ^<ul^>
) > index.html

:: 查找并添加所有HTML文件链接（排除index.html自身）
set count=0
for %%f in (*.html) do (
    if not "%%f"=="index.html" (
        echo         ^<li^>^<a href="%%f"^>%%f^</a^>^</li^> >> index.html
        set /a count+=1
        echo   找到: %%f
    )
)

:: 添加HTML文件尾部
(
echo         ^</ul^>
echo         ^<div class="file-count"^>共找到 !count! 个HTML文件^</div^>
echo         ^<div class="generated"^>^<i^>本文件由批处理脚本自动生成于 %date% %time%^</i^>^</div^>
echo     ^</div^>
echo ^</body^>
echo ^</html^>
) >> index.html

echo.
echo 完成！已生成 index.html
echo 包含 !count! 个HTML文件链接
echo.

:: 可选：自动在浏览器中打开
set /p "open=是否在浏览器中打开？(Y/N): "
if /i "!open!"=="Y" (
    start index.html
)

endlocal
pause