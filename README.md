# Goenv 一键安装脚本

> 🚀 自动化 Go 环境管理工具安装器，支持 CentOS、Ubuntu、Debian 等主流 Linux 发行版

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Linux-lightgrey.svg)](https://github.com/Bacon-123/goenv-In)
[![Bash](https://img.shields.io/badge/language-Bash-blue.svg)](https://www.gnu.org/software/bash/)

## ✨ 特性

- 🎯 **一键安装**：一行命令完成 goenv 部署
- 🌍 **多系统支持**：支持 CentOS、Ubuntu、Debian 等主流发行版
- 🔄 **版本管理**：轻松安装、切换多个 Go 版本
- 🛡️ **高成功率**：智能错误处理和自动恢复机制
- 📚 **用户友好**：详细的使用指南和示例

## 🚀 快速开始

### 一键安装

```bash
# 方法1：使用 curl 直接安装
curl -fsSL https://github.com/Bacon-123/goenv-In/main/goenv-installer.sh | sudo bash

# 方法2：下载脚本后安装
wget https://github.com/Bacon-123/goenv-In/main/goenv-installer.sh
sudo bash goenv-installer.sh
```

### 验证安装

```bash
# 检查 goenv 是否安装成功
goenv --version

# 查看当前 Go 版本
go version
```

## 📖 快速使用

### 安装 Go 版本
```bash
# 查看可安装的版本
goenv install -l | grep '^[0-9]' | tail -10

# 安装最新稳定版
goenv install 1.21.5

# 设置全局默认版本
goenv global 1.21.5
```

### 版本切换
```bash
# 查看已安装版本
goenv versions

# 切换到指定版本
goenv global 1.20.13

# 验证当前版本
go version
```

### 项目版本管理
```bash
# 在项目目录设置专用版本
goenv local 1.19.12  # 自动创建 .go-version 文件

# 离开该目录后自动恢复全局版本
cd /path/to/project
goenv local 1.21.5   # 项目专用版本
```

## 🔧 支持的系统

| 操作系统 | 版本支持 | 包管理器 |
|---------|---------|----------|
| CentOS | 7/8/9 | yum/dnf |
| Ubuntu | 18.04/20.04/22.04 | apt |
| Debian | 9/10/11 | apt |
| Rocky Linux | 8/9 | dnf |
| AlmaLinux | 8/9 | dnf |
| RHEL | 7/8/9 | yum/dnf |

## 📁 项目结构

```
goenv-installer/
├── goenv-installer.sh    # 主安装脚本
├── USAGE_GUIDE.md        # 详细使用教程
├── README.md            # 项目说明文档
├── test-installer.sh    # 安装测试脚本
└── examples/            # 使用示例
    ├── install-examples.sh
    └── version-management.sh
```

## 🛠️ 本地开发

```bash
# 克隆仓库
git clone https://github.com/Bacon-123/goenv-In.git
cd goenv-installer

# 本地测试（在测试环境中）
sudo bash goenv-installer.sh

# 运行测试脚本
bash test-installer.sh
```

## 📋 测试

脚本经过以下测试环境验证：
- ✅ CentOS 7.9 (Docker)
- ✅ Ubuntu 20.04 (Docker)
- ✅ Ubuntu 22.04 (Docker)
- ✅ Debian 11 (Docker)
- ✅ CentOS 8 Stream (Docker)

## 🤝 贡献

欢迎贡献！请遵循以下步骤：

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交修改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📝 更新日志

### v1.0.0 (2025-11-06)
- 🎉 初始版本发布
- ✨ 支持主流 Linux 发行版
- 🛠️ 完整的错误处理机制
- 📚 详细的使用文档

## ❓ 常见问题

### Q: 安装失败怎么办？
A: 检查网络连接和系统权限，确保以 root 权限运行脚本

### Q: 如何卸载 goenv？
A: 删除 /usr/local/goenv 目录和 /etc/profile.d/goenv.sh 文件

### Q: 支持 ARM 架构吗？
A: 目前主要支持 x86_64，ARM 支持正在开发中

## 📄 许可证

本项目基于 MIT 许可证开源 - 查看 [LICENSE](LICENSE) 文件了解详情

## 📧 联系方式

- 项目地址：https://github.com/Bacon-123/goenv-In
- 问题反馈：https://github.com/Bacon-123/goenv-In/issues
- 作者：MiniMax Agent

## ⭐ 支持

如果这个项目对您有帮助，请给个 ⭐ Star！

---

**使用 goenv-installer，让 Go 版本管理变得简单！**