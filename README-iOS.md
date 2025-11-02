# iOS 开发者简历模板

专业的 iOS 开发者简历模板，支持 LaTeX 排版和 Markdown 编辑。

## ✨ 特性

- 📱 **iOS 专业化** - 针对 iOS 开发职位优化的简历内容
- 🎨 **专业排版** - 基于 Awesome-CV 的精美 LaTeX 排版
- 📝 **Markdown 支持** - 同时提供 Markdown 版本便于编辑
- 🔄 **CI/CD 自动化** - GitHub Actions 自动编译 PDF
- 📄 **PDF 导出** - 生成高质量的 PDF 简历
- 🌐 **GitHub 展示** - 在线展示简历和作品

## 📁 文件结构

```
cv/
├── resume-ios.tex           # iOS 开发者 LaTeX 简历
├── ios-resume.md            # iOS 开发者 Markdown 简历
├── README-iOS.md            # iOS 模板说明文档
├── .github/workflows/
│   └── compile-latex.yml    # LaTeX 自动编译工作流
└── README.md                # 主文档说明
```

## 🚀 使用方法

### 1. LaTeX 版本（推荐）

```bash
# 安装 TeX Live
brew install --cask mactex

# 下载 Awesome-CV 类文件
wget https://github.com/posquit0/Awesome-CV/archive/refs/tags/v2.0.0.tar.gz
tar -xzf v2.0.0.tar.gz
cp Awesome-CV-2.0.0/awesome-cv.cls .
cp Awesome-CV-2.0.0/awesome-cv.sty .

# 编译简历
xelatex resume-ios.tex
```

### 2. Markdown 版本

编辑 `ios-resume.md` 文件，使用任何 Markdown 编辑器进行编辑。

### 3. GitHub Actions 自动编译

1. 将文件推送到 GitHub 仓库
2. GitHub Actions 会自动编译 LaTeX 并生成 PDF
3. 在 Actions 页面下载生成的 PDF 文件

## 📱 iOS 开发者特色内容

### 🎯 专业技能展示

- **iOS 技术栈**: Swift, SwiftUI, UIKit, Combine 等
- **架构模式**: MVVM, Clean Architecture 等
- **系统集成**: Face ID, Apple Pay, 推送通知等
- **性能优化**: 启动时间、内存使用优化经验

### 📱 已发布应用

包含详细的已发布应用信息：
- 下载量和用户评分
- 使用的技术栈
- 个人贡献和职责

### 🏆 证书与认证

- Apple 官方认证
- WWDC 参与经历
- 技术博客和分享经历

## 🛠️ 自定义指南

### 修改个人信息

在 `resume-ios.tex` 中修改以下部分：

```latex
\name{张}{三}
\address{北京市朝阳区}
\mobile{138-8888-8888}
\email{zhangsan@email.com}
\github{zhangsan}
\linkedin{zhangsan}
\homepage{zhangsan.dev}
\extrainfo{\faAppStore\ https://apps.apple.com/developer/zhangsan}
```

### 添加新的应用

在 "已发布应用" 部分添加：

```latex
\cvachievement{\faMobile}{应用名称}{应用描述}{功能亮点和成就}
```

### 更新技能标签

在技术栈部分添加或修改技能：

```latex
\cvtag{SwiftUI}
\cvtag{Combine}
\cvtag{Core Data}
```

## 📋 模板优势

### ✅ 针对 iOS 开发优化

1. **技术栈展示全面** - 涵盖 iOS 开发的各个方面
2. **项目经验丰富** - 突出已发布应用的开发经验
3. **Apple 生态认知** - 体现对 Apple 技术生态的深入理解
4. **性能优化能力** - 强调性能调优的实际成果

### ✅ 内容结构合理

1. **个人简介** - 突出 iOS 开发经验和技术热情
2. **技术栈** - 分类清晰，涵盖 iOS 开发全流程
3. **项目经验** - 重点展示已上线应用
4. **开源贡献** - 体现技术社区参与度
5. **持续学习** - 展示技术博客和分享经历

### ✅ 设计专业美观

1. **现代排版** - 使用 Awesome-CV 的专业设计
2. **图标丰富** - FontAwesome 图标增强视觉效果
3. **布局清晰** - 信息层次分明，易于阅读
4. **颜色协调** - iOS 蓝色主题，符合技术身份

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进 iOS 开发者简历模板！

### 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/ios-improvement`)
3. 提交更改 (`git commit -m 'Add iOS specific improvements'`)
4. 推送到分支 (`git push origin feature/ios-improvement`)
5. 创建 Pull Request

## 📝 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

- [Awesome-CV](https://github.com/posquit0/Awesome-CV) - 优秀的 LaTeX 简历模板
- Apple 开发者社区 - 提供的技术文档和最佳实践
- iOS 开发社区 - 分享的经验和知识

---

<div align="center">

**如果这个 iOS 开发者简历模板对你有帮助，请给一个 ⭐ Star！**

</div>