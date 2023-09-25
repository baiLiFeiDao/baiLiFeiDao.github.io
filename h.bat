@echo off
echo ====================================
echo 欢迎使用 Hexo 命令助手 请选择命令
echo 本地测试或上传网站时，将自动清理缓存
echo ====================================
echo 1. 访问作者博客
echo 2. 本地测试
echo 3. 上传网站
echo 4. 清理缓存
echo 5. 新建文章
echo 6. 新建页面
echo .
set /p input="请选择命令并按下回车："
if %input%==1 goto A
if %input%==2 goto B
if %input%==3 goto C
if %input%==4 goto D
if %input%==5 goto E
if %input%==6 goto F

:A
cls
start https://hipeach.eu.org
exit

:B
start cmd.exe /k "@echo off && hexo cl && echo. && echo 已清理缓存 && hexo s && pause && exit"


:C
start cmd.exe /k "@echo off && hexo cl && echo. && echo 已清理缓存 && hexo d && echo. && echo 指令已完成 如出错请检查配置 && pause && cls && 运行脚本.bat"
exit

:D
start cmd.exe /k "@echo off && hexo cl && echo. && echo 已清理缓存 && pause && cls && 运行脚本.bat"
exit

:E
cls
set /p t1="请输入文章文件名："
start cmd.exe /k "hexo n %t1% && echo. && echo 已在 source/_posts 目录下生成文件：%t1%.md 与 资源文件夹： %t1% && pause && exit"
exit

:F
cls
set /p t2="请输入独立页面文件名："
start cmd.exe /k "hexo n page %t2% && echo. && echo 已在 source 目录下生成一个文件夹： %t2% 并在文件夹内创建了文件： %t2%.md && pause && exit"
exit

pause


