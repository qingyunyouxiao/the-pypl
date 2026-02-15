# How to Download Hugo and build note-writing Website

日期：2026年2月9日

主题：你想了解 Hugo 的 Ezhil 模板，并把它用来搭建自己的 GitHub.io 笔记网站，这个想法非常棒，Ezhil 是一款轻量、简洁且适合做技术笔记的 Hugo 主题。

你想知道如何安装 Hugo（尤其是适配 Ezhil 主题的 **extended 版本**），这是搭建 GitHub.io 笔记站的第一步，我会按不同操作系统（Windows/macOS/Linux）给你最简洁、易操作的安装方法，新手也能轻松搞定。

### 一、安装前先明确

Ezhil 主题用到了代码高亮等功能，**必须安装 Hugo Extended 版本**（而非基础版），否则可能出现样式异常。

### 二、分系统安装 Hugo Extended

#### 1. Windows 系统（新手推荐）

##### 方法 1：通过 Chocolatey 安装（推荐，一键搞定）

- 先以**管理员身份**打开 PowerShell，执行以下命令开启权限：

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

- 安装完成后，输入以下命令安装 Hugo Extended：

```powershell
choco install hugo-extended -y
```

##### 方法 2：手动下载安装（无包管理器时）

1. 打开 Hugo 官方下载页：https://github.com/gohugoio/hugo/releases
2. 找到最新版本，下载 Windows 对应的 `hugo_extended_xxx_Windows-64bit.zip`（带 `extended` 字样）；
3. 解压压缩包，把 `hugo.exe` 放到一个固定目录（比如 `C:\hugo\bin`）；
4. 将该目录添加到系统环境变量 `PATH`：

- 右键「此电脑」→「属性」→「高级系统设置」→「环境变量」；
- 在「系统变量」中找到 `Path`，点击「编辑」→「新建」，粘贴 `C:\hugo\bin`；
- 点击确定，重启命令行。

#### 2. macOS 系统

##### 方法 1：通过 Homebrew 安装（推荐）

打开终端，执行：

```bash
# 先确保 Homebrew 已安装（未安装则先执行：/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"）
brew install hugo-extended
```

##### 方法 2：手动下载

1. 下载 macOS 版本的 `hugo_extended_xxx_Darwin-64bit.tar.gz`；
2. 解压后将 `hugo` 可执行文件放到 `/usr/local/bin` 目录（终端执行：`sudo mv hugo /usr/local/bin/`）。

#### 3. Linux 系统（以 Ubuntu/Debian 为例）

##### 方法 1：通过 Snap 安装（推荐）

```bash
sudo snap install hugo --channel=extended
```

##### 方法 2：手动下载

1. 下载 Linux 版本的 `hugo_extended_xxx_Linux-64bit.tar.gz`；
2. 解压并移动到系统目录：

```bash
tar -zxvf hugo_extended_xxx_Linux-64bit.tar.gz
sudo mv hugo /usr/local/bin/
```

### 三、验证安装是否成功

无论哪个系统，安装完成后，打开终端/命令行/PowerShell，执行：

```bash
hugo version
```

如果输出包含 `extended` 字样（比如 `hugo v0.121.2-extended ...`），说明安装成功；如果提示 `hugo 不是内部或外部命令`，则是环境变量未配置好，重新检查路径。

### 总结

1. 安装 Hugo 核心是选 **Extended 版本**，否则 Ezhil 主题的代码高亮等功能会异常；
2. Windows 优先用 Chocolatey、macOS 优先用 Homebrew、Linux 优先用 Snap，一键安装更省心；
3. 验证安装的关键命令是 `hugo version`，输出含 `extended` 即为成功。

如果安装过程中遇到权限不足、下载失败等问题，告诉我你的操作系统和具体报错信息，我帮你针对性解决。



### 一、Ezhil 模板核心特点（先帮你快速了解）

Ezhil 是专为 Hugo 设计的极简主义主题，特别适合个人博客/笔记站，核心特点：

- 轻量无冗余，加载速度快，适配移动端
- 支持中文等多语言，对中文笔记友好
- 自带代码高亮、目录、标签/分类等笔记必备功能
- 配置简单，新手易上手
- 完全免费开源，适配 GitHub Pages 部署

### 二、用 Ezhil 搭建 GitHub.io 笔记站的完整步骤

#### 前置准备

1. 安装必要工具：

- Git（版本控制）
- Hugo（建议安装 **extended 版本**，支持代码高亮）
- 一个 GitHub 账号（已创建 `你的用户名.github.io` 仓库）

#### 步骤 1：创建 Hugo 项目并安装 Ezhil 主题

```bash
# 1. 创建 Hugo 站点（命名为 notes，可自定义）
hugo new site notes
cd notes

# 2. 初始化 Git 仓库（后续要推到 GitHub）
git init

# 3. 安装 Ezhil 主题（作为 Git 子模块，推荐方式）
git submodule add https://github.com/vividvilla/ezhil.git themes/ezhil
```

#### 步骤 2：配置 Ezhil 主题（核心）

修改 Hugo 项目根目录的 `config.toml` 文件（替换成你的信息），这是适配笔记站的基础配置：

```toml
# 基础配置
baseURL = "https://你的用户名.github.io/"  # 替换成你的 GitHub.io 地址
languageCode = "zh-CN"  # 中文支持
title = "我的技术笔记"  # 站点标题
theme = "ezhil"  # 指定使用 Ezhil 主题
defaultContentLanguage = "zh"

# Ezhil 主题专属配置（适配笔记场景）
[params]
  subtitle = "记录学习的每一步"  # 副标题
  author = "你的名字"  # 作者名
  github = "你的 GitHub 用户名"  # 可选，显示 GitHub 链接
  email = "你的邮箱@xxx.com"  # 可选
  # 笔记站常用：开启目录、代码高亮
  showToc = true  # 文章侧边目录
  codeMaxLines = 100  # 代码块最大行数
  codeLineNumbers = true  # 代码行号

# 分类/标签配置（笔记必备）
[taxonomies]
  category = "categories"
  tag = "tags"

# permalinks（优化笔记链接格式）
[permalinks]
  post = "/:year/:month/:day/:slug/"
```

#### 步骤 3：创建第一篇笔记

```bash
# 创建一篇名为 "Hugo入门" 的笔记
hugo new posts/hugo入门.md
```

打开 `content/posts/hugo入门.md`，写入笔记内容（Markdown 格式）：

~~~markdown
---
title: "Hugo入门"
date: 2026-02-09T10:00:00+08:00
draft: false  # 发布时改为 false
categories: ["Hugo"]
tags: ["笔记", "GitHub.io"]
---

# Hugo 搭建笔记站
这是我用 Ezhil 主题写的第一篇笔记！

## 核心步骤
1. 安装 Hugo
2. 配置 Ezhil 主题
3. 发布到 GitHub Pages

### 代码示例
```bash
hugo server  # 本地预览
#### 步骤 4：本地预览效果
```bash
# 启动 Hugo 本地服务器
hugo server -D  # -D 显示草稿文章
~~~

打开浏览器访问 `http://localhost:1313`，就能看到你的笔记站了，确认样式和内容无误后再部署。

#### 步骤 5：部署到 GitHub.io

##### 方式 1：手动部署（新手推荐）

```bash
# 1. 生成静态文件（输出到 public 目录）
hugo  # 注意：draft=false 的文章才会被生成

# 2. 进入 public 目录，推送到 GitHub.io 仓库
cd public
git init
git add .
git commit -m "发布第一篇笔记"
git remote add origin https://github.com/你的用户名/你的用户名.github.io.git
git push -u origin main  # 若仓库默认分支是 master，替换为 master
```

##### 方式 2：GitHub Actions 自动部署（更便捷）

1. 在 Hugo 项目根目录创建 `.github/workflows/hugo.yml`：

```yaml
name: Deploy Hugo site to Pages

on:
  push:
    branches: ["main"]  # 你的 Hugo 项目分支
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: true  # 拉取 Ezhil 主题子模块
          fetch-depth: 0

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: "latest"
          extended: true

      - name: Build
        run: hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v4
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
          publish_branch: gh-pages  # 部署到 gh-pages 分支
```

1. 把 Hugo 项目（除 public 外）推送到一个新仓库（如 `hugo-notes`），GitHub Actions 会自动构建并部署到 `你的用户名.github.io` 仓库。

### 三、笔记站优化建议（适配 Ezhil）

1. **中文排版优化**：在 `assets/css/custom.css` 中添加自定义样式（Ezhil 支持自定义 CSS）：

```css
/* 优化中文行间距和字体 */
body {
  line-height: 1.8;
  font-family: "PingFang SC", "Microsoft YaHei", sans-serif;
}
.post-content h1, .post-content h2 {
  margin-top: 1.5em;
  margin-bottom: 0.8em;
}
```

1. **添加搜索功能**：Ezhil 原生无搜索，可集成 `hugo-lunr` 实现本地搜索；
2. **归档/标签页**：在 `content` 目录创建 `archives.md`/`tags.md`，启用主题自带的归档页面。

### 总结

1. Ezhil 是轻量极简的 Hugo 主题，适配中文笔记和 GitHub.io 部署，核心配置只需修改 `config.toml`；
2. 搭建流程：创建 Hugo 项目 → 安装 Ezhil → 配置主题 → 写笔记 → 本地预览 → 部署到 GitHub；
3. 部署推荐用 GitHub Actions 自动构建，避免手动操作 public 目录的麻烦。

如果部署过程中遇到样式丢失、链接404等问题，大概率是 `baseURL` 配置错误或 GitHub 仓库分支设置不对，可随时告诉我具体问题，我帮你排查。