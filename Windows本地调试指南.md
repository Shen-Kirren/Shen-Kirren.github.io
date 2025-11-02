# Windows 本地调试指南

本指南将帮助你在 Windows 系统下本地运行和调试 Jekyll 博客。

## 一、环境准备

### 1. 安装 Ruby

Jekyll 是基于 Ruby 的，所以需要先安装 Ruby。

#### 方法一：使用 RubyInstaller（推荐）

1. 访问 [RubyInstaller 官网](https://rubyinstaller.org/downloads/)
2. 下载 **Ruby+Devkit** 版本（建议下载 Ruby 3.1 或更高版本）
   - 选择 "Ruby+Devkit 3.x.x (x64)" 
   - **注意**：必须选择带 Devkit 的版本，否则后续安装 gem 会失败
3. 运行安装程序，按照向导安装
   - ✅ 勾选 "Add Ruby executables to your PATH"
   - ✅ 勾选 "Associate .rb and .rbw files with this Ruby installation"
4. 安装完成后会打开一个终端窗口，按提示运行：
   ```
   ridk install
   ```
   选择选项 `3`（安装所有组件）

#### 验证 Ruby 安装

打开 PowerShell 或 CMD，运行：

```powershell
ruby -v
```

应该显示类似：`ruby 3.1.4p123 (2023-04-12 revision 12345) [x64-mingw-ucrt]`

```powershell
gem -v
```

应该显示 gem 的版本号。

### 2. 安装 Bundler

Ruby 安装后，安装 Bundler（Ruby 的包管理器）：

```powershell
gem install bundler
```

验证安装：

```powershell
bundle -v
```

## 二、安装项目依赖

1. **打开终端**，切换到项目目录：

```powershell
cd F:\Shen-Kirren.github.io
```

2. **安装依赖**：

```powershell
bundle install
```

这个过程可能需要几分钟，会下载所有需要的 gem 包。

**注意**：如果遇到 SSL 证书问题，可以尝试：
```powershell
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
bundle install
```

## 三、运行本地服务器

### 方法一：使用 Bundle（推荐）

```powershell
bundle exec jekyll serve
```

或者使用带自动重载的版本（推荐，修改文件后自动刷新）：

```powershell
bundle exec jekyll serve --livereload
```

### 方法二：使用我创建的批处理脚本

在项目根目录运行：
```powershell
.\run.bat
```

### 启动后访问

服务器启动后，你会看到类似输出：

```
Server address: http://127.0.0.1:4000/
Server running... press ctrl-c to stop.
```

在浏览器中访问：**http://localhost:4000** 或 **http://127.0.0.1:4000**

## 四、常用命令

### 启动服务器（基础）
```powershell
bundle exec jekyll serve
```

### 启动服务器（带自动重载）
```powershell
bundle exec jekyll serve --livereload
```

### 启动服务器（指定端口）
```powershell
bundle exec jekyll serve --port 4001
```

### 启动服务器（绑定所有 IP，允许局域网访问）
```powershell
bundle exec jekyll serve --host 0.0.0.0
```

### 构建网站（不启动服务器）
```powershell
bundle exec jekyll build
```

构建后的文件会在 `_site` 目录下。

### 清理构建文件
```powershell
bundle exec jekyll clean
```

## 五、常见问题解决

### 问题 1：`bundle install` 失败

**错误信息**：`Failed to build gem native extension`

**解决方案**：
1. 确保安装的是 Ruby+Devkit 版本
2. 运行 `ridk install` 选择选项 3
3. 如果还有问题，尝试：
   ```powershell
   gem install bundler
   bundle install
   ```

### 问题 2：端口被占用

**错误信息**：`Address already in use`

**解决方案**：
```powershell
# 使用其他端口
bundle exec jekyll serve --port 4001

# 或者找到占用 4000 端口的进程并关闭
netstat -ano | findstr :4000
taskkill /PID <进程ID> /F
```

### 问题 3：中文文件名或路径问题

如果遇到中文路径问题，确保：
- 项目路径中避免中文字符（你的路径看起来没问题）
- Ruby 使用 UTF-8 编码：
  ```powershell
  chcp 65001
  ```

### 问题 4：`jekyll serve` 找不到命令

**解决方案**：
```powershell
# 确保在项目目录下
cd F:\Shen-Kirren.github.io

# 使用 bundle exec
bundle exec jekyll serve

# 不要直接使用 jekyll serve
```

### 问题 5：依赖版本冲突

如果遇到版本冲突，可以：
```powershell
# 更新 bundler
gem update bundler

# 清理并重新安装
bundle clean --force
bundle install
```

### 问题 6：Windows 路径问题

如果遇到路径相关错误，确保：
- 使用正斜杠 `/` 或双反斜杠 `\\`，不要使用单个反斜杠 `\`
- 路径中避免空格和特殊字符

## 六、开发工作流

### 推荐的开发流程：

1. **启动服务器**：
   ```powershell
   bundle exec jekyll serve --livereload
   ```

2. **编辑文件**：
   - 修改 `index.html`、`_config.yml` 等
   - 在 `_posts` 下创建新文章

3. **自动刷新**：
   - 如果使用 `--livereload`，浏览器会自动刷新
   - 如果没有，手动刷新浏览器（Ctrl+F5）

4. **查看日志**：
   - 终端会显示构建信息和错误
   - 注意观察是否有警告或错误

5. **停止服务器**：
   - 按 `Ctrl+C` 停止服务器

## 七、性能优化

### 禁用不必要的插件

如果构建速度慢，可以在 `_config.yml` 中检查是否有不必要的插件。

### 使用增量构建

```powershell
bundle exec jekyll serve --incremental
```

这样只构建更改的文件，速度更快。但可能不会检测到所有更改。

## 八、调试技巧

### 1. 查看详细日志

```powershell
bundle exec jekyll serve --verbose
```

### 2. 查看构建统计

构建完成后，会显示构建了多少文件、用了多长时间。

### 3. 检查 Liquid 语法错误

如果有 Liquid 语法错误，终端会显示具体错误位置。

### 4. 验证配置文件

```powershell
bundle exec jekyll doctor
```

这会检查配置文件的常见问题。

## 九、生产环境构建测试

在部署前，可以用生产模式测试：

```powershell
$env:JEKYLL_ENV="production"
bundle exec jekyll build
```

或者：

```powershell
bundle exec jekyll build --config _config.yml
```

构建后检查 `_site` 目录下的文件。

## 十、快速命令参考

| 操作 | 命令 |
|------|------|
| 安装依赖 | `bundle install` |
| 启动服务器 | `bundle exec jekyll serve` |
| 启动服务器（自动刷新） | `bundle exec jekyll serve --livereload` |
| 构建网站 | `bundle exec jekyll build` |
| 清理构建文件 | `bundle exec jekyll clean` |
| 检查配置 | `bundle exec jekyll doctor` |
| 更新依赖 | `bundle update` |

## 十一、使用批处理脚本（可选）

我已经为你创建了 `run.bat` 脚本，可以直接双击运行或使用命令行：

```powershell
.\run.bat
```

这样可以简化启动过程。

---

## 快速开始检查清单

- [ ] 安装 Ruby+Devkit
- [ ] 验证 Ruby 和 gem 安装：`ruby -v` 和 `gem -v`
- [ ] 安装 Bundler：`gem install bundler`
- [ ] 切换到项目目录：`cd F:\Shen-Kirren.github.io`
- [ ] 安装项目依赖：`bundle install`
- [ ] 启动服务器：`bundle exec jekyll serve --livereload`
- [ ] 在浏览器访问：http://localhost:4000

祝你调试顺利！如有问题，可以参考常见问题部分或查看 Jekyll 官方文档。
