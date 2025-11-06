#!/bin/bash
# Goenv 一键安装脚本 v1.0
# 支持 CentOS、Ubuntu、Debian 等主流 Linux 发行版
# 作者: MiniMax Agent

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查是否以root用户运行
check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "请使用 sudo 运行此脚本"
        echo "正确用法: sudo bash goenv-installer.sh"
        exit 1
    fi
}

# 检测操作系统
detect_os() {
    log_info "正在检测操作系统..."
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
    else
        log_error "无法检测操作系统类型"
        exit 1
    fi
    
    log_info "检测到操作系统: $OS $VER"
    
    # 设置包管理器
    case "$OS" in
        "CentOS"*|"Red Hat"*|"Rocky"*|"AlmaLinux"*)
            PACKAGE_MANAGER="yum"
            if command -v dnf >/dev/null 2>&1; then
                PACKAGE_MANAGER="dnf"
            fi
            ;;
        "Ubuntu"*|"Debian"*)
            PACKAGE_MANAGER="apt"
            ;;
        *)
            log_error "不支持的操作系统: $OS"
            exit 1
            ;;
    esac
    
    log_info "使用包管理器: $PACKAGE_MANAGER"
}

# 安装基础依赖
install_dependencies() {
    log_info "正在安装基础依赖..."
    
    case "$PACKAGE_MANAGER" in
        "apt")
            export DEBIAN_FRONTEND=noninteractive
            apt update
            apt install -y curl git make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
            ;;
        "yum"|"dnf")
            $PACKAGE_MANAGER install -y curl git make gcc openssl-devel bzip2-devel zlib-devel readline-devel sqlite-devel wget llvm-devel ncurses-devel ncurses wxWidgets-devel xz-devel tk-devel libffi-devel python3-openssl
            ;;
    esac
    
    log_success "基础依赖安装完成"
}

# 下载和安装 goenv
install_goenv() {
    log_info "正在下载和安装 goenv..."
    
    GOENV_ROOT="/usr/local/goenv"
    
    # 克隆 goenv 仓库
    if [ ! -d "$GOENV_ROOT" ]; then
        git clone https://github.com/syndbg/goenv.git "$GOENV_ROOT"
    else
        log_info "goenv 已存在，正在更新..."
        cd "$GOENV_ROOT" && git pull
    fi
    
    # 设置环境变量
    export GOENV_ROOT="$GOENV_ROOT"
    export PATH="$GOENV_ROOT/bin:$PATH"
    export PATH="$GOENV_ROOT/shims:$PATH"
    
    # 初始化 goenv
    eval "$(goenv init -)"
    
    # 创建 goenv 配置
    cat > /etc/profile.d/goenv.sh << 'EOF'
export GOENV_ROOT=/usr/local/goenv
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOENV_ROOT/shims:$PATH"
eval "$(goenv init -)"
export GOENV_DISABLE_GIT=1
export GOPROXY=https://goproxy.cn,direct
EOF
    
    # 更新当前会话的环境变量
    export GOENV_ROOT="$GOENV_ROOT"
    export PATH="$GOENV_ROOT/bin:$PATH"
    export PATH="$GOENV_ROOT/shims:$PATH"
    eval "$(goenv init -)"
    
    log_success "goenv 安装完成"
}

# 验证安装
verify_installation() {
    log_info "正在验证 goenv 安装..."
    
    if command -v goenv >/dev/null 2>&1; then
        log_success "goenv 安装验证成功"
        goenv --version
        
        # 显示当前可用的 Go 版本
        log_info "正在获取最新可用的 Go 版本..."
        goenv install -l | tail -5
        
        echo
        log_success "🎉 goenv 安装完成！"
        echo
        echo "接下来您可以："
        echo "1. 查看可安装的 Go 版本: goenv install -l | grep '^[0-9]' | tail -10"
        echo "2. 安装特定版本: goenv install 1.21.5"
        echo "3. 设置全局版本: goenv global 1.21.5"
        echo "4. 查看当前版本: goenv version"
        echo "5. 查看所有已安装版本: goenv versions"
        echo
        
    else
        log_error "goenv 安装验证失败"
        exit 1
    fi
}

# 显示使用指南
show_usage_guide() {
    cat << 'EOF'

=== Goenv 使用指南 ===

🚀 快速开始：
1. 查看可安装的 Go 版本：
   goenv install -l | grep '^[0-9]' | tail -10

2. 安装最新稳定版 Go：
   goenv install 1.21.5

3. 设置全局默认版本：
   goenv global 1.21.5

4. 验证安装：
   go version
   echo $GOENV_VERSION

📚 常用命令：

查看已安装的版本：
   goenv versions

查看当前使用的版本：
   goenv version

查看所有可安装的版本：
   goenv install -l

安装特定版本：
   goenv install 1.20.13

设置全局默认版本（所有用户默认）：
   goenv global 1.21.5

设置项目本地版本（仅当前目录有效）：
   goenv local 1.20.13

卸载指定版本：
   goenv uninstall 1.20.13

🎯 版本管理技巧：

1. 项目专用版本：
   # 在项目根目录设置特定版本
   goenv local 1.21.5
   
   # 项目目录下会自动创建 .go-version 文件
   cat .go-version  # 1.21.5

2. 快速切换：
   # 查看所有已安装版本
   goenv versions
   
   # 切换到指定版本
   goenv global 1.20.13

3. 多个版本并存：
   # 可以安装多个版本，需要时切换即可
   goenv install 1.21.5
   goenv install 1.20.13
   goenv install 1.19.12

💡 提示：
- 建议先安装 1.21.5 作为稳定版本
- 使用 'goenv install -l' 查看所有可用版本
- 在项目根目录设置版本可以确保项目环境隔离
- 使用 'go version' 验证当前使用的 Go 版本

EOF
}

# 主函数
main() {
    echo "========================================"
    echo "        Goenv 一键安装脚本"
    echo "    支持 CentOS、Ubuntu、Debian"
    echo "========================================"
    echo
    
    check_root
    detect_os
    install_dependencies
    install_goenv
    verify_installation
    show_usage_guide
    
    log_success "安装完成！请重新打开终端或执行 'source /etc/profile.d/goenv.sh' 以启用 goenv"
}

# 执行主函数
main "$@"