@echo off
REM Jekyll 本地服务器启动脚本（Windows）
REM 使用方法：直接双击此文件或在命令行运行 run.bat

echo.
echo ========================================
echo    Jekyll 本地服务器启动
echo ========================================
echo.

REM 检查是否在项目根目录
if not exist "Gemfile" (
    echo 错误：未找到 Gemfile，请确保在项目根目录运行此脚本
    pause
    exit /b 1
)

REM 检查 bundle 是否已安装
bundle -v >nul 2>&1
if errorlevel 1 (
    echo Bundle 未安装，正在安装...
    gem install bundler
    if errorlevel 1 (
        echo 错误：Bundle 安装失败
        pause
        exit /b 1
    )
)

REM 检查依赖是否已安装
if not exist "Gemfile.lock" (
    echo 首次运行，正在安装依赖...
    bundle install
    if errorlevel 1 (
        echo 错误：依赖安装失败
        pause
        exit /b 1
    )
)

echo.
echo 正在启动 Jekyll 服务器...
echo 访问地址: http://localhost:4000
echo 按 Ctrl+C 停止服务器
echo.
echo ========================================
echo.

REM 启动 Jekyll 服务器（带自动重载）
bundle exec jekyll serve --livereload

REM 如果服务器异常退出，暂停以便查看错误信息
if errorlevel 1 (
    echo.
    echo ========================================
    echo 服务器启动失败，请查看上方错误信息
    echo ========================================
    pause
)
