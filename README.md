# 专业简历模板

一个现代化的简历模板，支持 Markdown 编辑、PDF 导出和 GitHub 在线展示。

## ✨ 特性

- 📝 **Markdown 编写** - 使用熟悉的 Markdown 语法编写简历
- 📄 **PDF 导出** - 自动生成专业的 PDF 格式简历
- 🌐 **GitHub 展示** - 在 GitHub Pages 上在线展示简历
- 🎨 **精美样式** - 专业的 CSS 样式，支持打印优化
- 🔄 **CI/CD 自动化** - GitHub Actions 自动构建和部署
- 📱 **响应式设计** - 适配各种设备屏幕

## 🚀 快速开始

### 1. 克隆模板

```bash
git clone https://github.com/davidcat/cv.git
cd cv
```

### 2. 编辑简历内容

编辑 `resume.md` 文件，替换为你的个人信息：

```markdown
# 你的名字

## 🎯 个人简介
简要介绍你的专业背景和职业目标...

## 💼 工作经历
### 职位 | 公司
*时间段 | 地点*
- 工作职责和成就...
```

### 3. 自定义样式（可选）

编辑 `style.css` 文件来自定义简历的外观。

### 4. 本地预览

使用 Markdown 预览工具查看效果，或安装依赖生成本地 PDF：

```bash
# 安装依赖
npm install -g markdown-pdf
npm install -g puppeteer

# 生成 PDF
markdown-pdf resume.md -o resume.pdf -s style.css
```

## 📁 项目结构

```
cv/
├── resume.md              # 简历 Markdown 源文件
├── style.css              # CSS 样式文件
├── README.md              # 项目说明文档
├── .github/
│   └── workflows/
│       └── generate-pdf.yml  # GitHub Actions 工作流
└── resume.pdf             # 生成的 PDF 文件（自动生成）
```

## 🔧 GitHub Actions 自动化

项目配置了 GitHub Actions 来实现：

1. **自动 PDF 生成** - 当推送更新到 `main` 分支时自动生成 PDF
2. **GitHub Pages 部署** - 自动部署到 GitHub Pages 在线展示
3. **工件保存** - PDF 文件作为工件保存 30 天

### 启用 GitHub Pages

1. 进入仓库的 Settings 页面
2. 找到 Pages 选项
3. Source 选择 "GitHub Actions"
4. 点击 Save

系统会自动使用 GitHub Actions 部署到 GitHub Pages。

## 📖 使用指南

### Markdown 简历编写技巧

1. **结构清晰** - 使用二级标题组织内容模块
2. **信息层次** - 合理使用粗体、斜体强调重点
3. **时间格式** - 统一使用 "YYYY年MM月" 格式
4. **链接规范** - 为社交媒体和个人网站添加链接

### 样式自定义

编辑 `style.css` 可以自定义：

- **颜色主题** - 修改 `--primary-color` 等变量
- **字体样式** - 调整 font-family 属性
- **布局间距** - 修改 margin 和 padding 值
- **打印样式** - 优化 @media print 部分

### 内容模块说明

| 模块 | 说明 | 必要性 |
|------|------|--------|
| 个人信息 | 姓名、联系方式等 | 必需 |
| 个人简介 | 职业概述和核心技能 | 必需 |
| 工作经历 | 详细的工作经验 | 必需 |
| 技术栈 | 掌握的技术和工具 | 必需 |
| 教育背景 | 学历和教育经历 | 必需 |
| 项目经验 | 具体项目案例 | 可选 |
| 证书奖项 | 专业认证和荣誉 | 可选 |
| 开源贡献 | GitHub 和开源活动 | 可选 |

## 🎨 样式特性

- **专业配色** - 使用蓝色系专业配色方案
- **清晰层次** - 通过颜色和字体大小区分信息层级
- **打印优化** - 专门优化的打印样式
- **响应式** - 适配移动端和桌面端
- **图标支持** - 支持 Emoji 图标美化界面

## 📊 兼容性

| 平台 | 支持情况 |
|------|----------|
| GitHub Pages | ✅ 完全支持 |
| GitLab Pages | ✅ 支持 |
| 本地预览 | ✅ 支持 |
| PDF 导出 | ✅ 支持 |
| 打印 | ✅ 优化支持 |

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个模板！

### 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📝 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

- 感谢所有贡献者
- 灵感来源于各种优秀的简历模板
- 使用 GitHub Actions 实现自动化

---

<div align="center">

**如果这个模板对你有帮助，请给一个 ⭐ Star！**

</div>

