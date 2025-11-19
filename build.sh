#!/bin/bash

# 构建脚本：从Markdown和模板生成最终的HTML简历

set -e

echo "开始构建简历..."

# 安装pandoc（如果未安装）
if ! command -v pandoc &> /dev/null; then
    echo "安装pandoc..."
    sudo apt-get update && sudo apt-get install -y pandoc
fi

# 创建index.html
echo "生成HTML文件..."

# 开始构建HTML文件
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>故知 - iOS 开发工程师</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-primary: #ffffff;
            --bg-secondary: #fafafa;
            --text-primary: #24292f;
            --text-secondary: #656d76;
            --text-muted: #8b949e;
            --accent: #0969da;
            --accent-hover: #0860ca;
            --border: #d1d9e0;
            --border-light: #f0f6fc;
            --shadow-sm: 0 1px 2px rgba(31, 35, 40, 0.04);
            --shadow-md: 0 3px 6px rgba(31, 35, 40, 0.1);
            --shadow-lg: 0 8px 16px rgba(31, 35, 40, 0.15);
            --radius: 8px;
            --radius-lg: 12px;
            --max-width: 900px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
            scroll-padding-top: 80px;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            line-height: 1.7;
            color: var(--text-primary);
            background: var(--bg-primary);
            font-size: 16px;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .container {
            max-width: var(--max-width);
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Navigation */
        nav {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-light);
            z-index: 1000;
            height: 60px;
        }

        .nav-container {
            max-width: var(--max-width);
            margin: 0 auto;
            padding: 0 20px;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .nav-brand {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-primary);
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .nav-brand:hover {
            color: var(--accent);
        }

        .nav-links {
            display: flex;
            gap: 32px;
            list-style: none;
        }

        .nav-links a {
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.2s ease;
            position: relative;
        }

        .nav-links a:hover,
        .nav-links a.active {
            color: var(--text-primary);
        }

        .nav-links a.active {
            font-weight: 600;
        }

        /* Mobile Menu */
        .mobile-menu-btn {
            display: none;
            flex-direction: column;
            gap: 4px;
            background: none;
            border: none;
            cursor: pointer;
            padding: 8px;
        }

        .mobile-menu-btn span {
            width: 20px;
            height: 2px;
            background: var(--text-primary);
            transition: all 0.2s ease;
        }

        /* Main Content */
        main {
            margin-top: 60px;
            min-height: calc(100vh - 60px);
        }

        /* Sections */
        section {
            padding: 80px 0;
            position: relative;
        }

        section:nth-child(even) {
            background: var(--bg-secondary);
        }

        /* Hero Section */
        .hero {
            display: flex;
            align-items: center;
            min-height: calc(100vh - 60px);
            padding: 120px 0 80px;
            text-align: center;
        }

        .hero-content h1 {
            font-size: clamp(32px, 5vw, 48px);
            font-weight: 700;
            margin-bottom: 16px;
            letter-spacing: -0.02em;
            animation: fadeInUp 0.8s ease;
        }

        .hero-content .subtitle {
            font-size: 20px;
            color: var(--text-secondary);
            margin-bottom: 32px;
            animation: fadeInUp 0.8s ease 0.1s both;
        }

        .hero-content .description {
            font-size: 16px;
            color: var(--text-secondary);
            margin-bottom: 40px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
            animation: fadeInUp 0.8s ease 0.2s both;
        }

        .contact-links {
            display: flex;
            gap: 24px;
            justify-content: center;
            flex-wrap: wrap;
            animation: fadeInUp 0.8s ease 0.3s both;
        }

        .contact-link {
            color: var(--accent);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            padding: 8px 16px;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            transition: all 0.2s ease;
            background: var(--bg-primary);
        }

        .contact-link:hover {
            color: var(--accent-hover);
            border-color: var(--accent);
            transform: translateY(-1px);
        }

        /* Section Headers */
        .section-header {
            text-align: center;
            margin-bottom: 64px;
        }

        .section-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 16px;
            letter-spacing: -0.02em;
            color: var(--text-primary);
        }

        .section-subtitle {
            font-size: 16px;
            color: var(--text-secondary);
            max-width: 600px;
            margin: 0 auto;
        }

        /* Experience */
        .timeline {
            position: relative;
            padding-left: 32px;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 8px;
            top: 8px;
            bottom: 8px;
            width: 1px;
            background: var(--border);
        }

        .timeline-item {
            position: relative;
            margin-bottom: 48px;
            animation: fadeInUp 0.6s ease both;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: -28px;
            top: 8px;
            width: 16px;
            height: 16px;
            background: var(--bg-primary);
            border: 2px solid var(--accent);
            border-radius: 50%;
            z-index: 1;
        }

        .timeline-header {
            margin-bottom: 16px;
        }

        .timeline-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 4px;
        }

        .timeline-meta {
            display: flex;
            gap: 16px;
            font-size: 14px;
            color: var(--text-secondary);
            margin-bottom: 12px;
        }

        .timeline-company {
            font-weight: 500;
            color: var(--accent);
        }

        .timeline-period {
            color: var(--text-muted);
        }

        .timeline-description {
            color: var(--text-secondary);
            line-height: 1.6;
        }

        .timeline-description ul {
            margin-top: 12px;
            padding-left: 20px;
        }

        .timeline-description li {
            margin-bottom: 8px;
        }

        /* Skills */
        .skills-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
        }

        .skill-category {
            background: var(--bg-primary);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 24px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .skill-category:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .skill-category h3 {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 16px;
        }

        .skill-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .skill-tag {
            background: var(--bg-secondary);
            color: var(--text-secondary);
            padding: 6px 12px;
            border-radius: 16px;
            font-size: 13px;
            font-weight: 500;
            border: 1px solid var(--border);
            transition: all 0.2s ease;
        }

        .skill-tag:hover {
            background: var(--accent);
            color: white;
            border-color: var(--accent);
            transform: translateY(-1px);
        }

        /* Projects */
        .projects-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 32px;
        }

        .project-card {
            background: var(--bg-primary);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .project-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .project-header {
            padding: 24px;
            border-bottom: 1px solid var(--border);
        }

        .project-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .project-meta {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .project-content {
            padding: 24px;
        }

        .project-description {
            color: var(--text-secondary);
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .project-tech {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .tech-tag {
            background: var(--bg-secondary);
            color: var(--text-secondary);
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            border: 1px solid var(--border);
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 48px 0;
            border-top: 1px solid var(--border);
            background: var(--bg-secondary);
        }

        footer p {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .nav-links {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: var(--bg-primary);
                border-bottom: 1px solid var(--border);
                flex-direction: column;
                padding: 16px 20px;
                gap: 16px;
                box-shadow: var(--shadow-md);
            }

            .nav-links.active {
                display: flex;
            }

            .mobile-menu-btn {
                display: flex;
            }

            .hero {
                padding: 100px 0 60px;
            }

            .section-title {
                font-size: 28px;
            }

            .timeline {
                padding-left: 24px;
            }

            .projects-grid {
                grid-template-columns: 1fr;
            }

            .skills-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--bg-secondary);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--border);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--text-muted);
        }
    </style>
</head>
<body>
    <nav>
        <div class="nav-container">
            <a href="#about" class="nav-brand">故知</a>
            <ul class="nav-links" id="navLinks">
                <li><a href="#about">关于</a></li>
                <li><a href="#experience">经历</a></li>
                <li><a href="#skills">技能</a></li>
                <li><a href="#projects">项目</a></li>
                <li><a href="#contact">联系</a></li>
            </ul>
            <button class="mobile-menu-btn" id="mobileMenuBtn">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </nav>

    <main>
EOF

# 添加内容部分
echo "        <!-- Hero Section -->" >> index.html
echo '        <section id="about" class="hero">' >> index.html
echo '            <div class="container">' >> index.html
echo '                <div class="hero-content">' >> index.html
echo '                    <h1>故知</h1>' >> index.html
echo '                    <p class="subtitle">iOS 开发工程师</p>' >> index.html
echo '                    <p class="description">资深 iOS 开发工程师，具有 10 年移动应用开发经验。精通 Objective-C 和 Swift 编程，熟悉 AFNetworking、SDWebImage、Masonry、Alamofire、SnapKit、Kingfisher 等主流开源框架。拥有金融保险、工业互联网领域工作经历，具备良好的编程习惯和问题解决能力。</p>' >> index.html
echo '                    <div class="contact-links">' >> index.html

# 从Markdown中提取联系方式信息
echo '                        <a href="mailto:shawn2045@qq.com" class="contact-link">📧 邮箱</a>' >> index.html
echo '                        <a href="https://linkedin.com/in/guzhi" target="_blank" class="contact-link">💼 LinkedIn</a>' >> index.html
echo '                        <a href="https://github.com/guzhi" target="_blank" class="contact-link">🐙 GitHub</a>' >> index.html
echo '                        <a href="https://apps.apple.com/developer/guzhi" target="_blank" class="contact-link">📱 App Store</a>' >> index.html

echo '                    </div>' >> index.html
echo '                </div>' >> index.html
echo '            </div>' >> index.html
echo '        </section>' >> index.html

# 工作经历部分
echo "        <!-- Experience Section -->" >> index.html
echo '        <section id="experience">' >> index.html
echo '            <div class="container">' >> index.html
echo '                <div class="section-header">' >> index.html
echo '                    <h2 class="section-title">工作经历</h2>' >> index.html
echo '                    <p class="section-subtitle">在不同公司和项目中积累的iOS开发经验</p>' >> index.html
echo '                </div>' >> index.html
echo '                <div class="timeline">' >> index.html

# 深圳市新源润产品信息技术有限公司
echo '                    <div class="timeline-item">' >> index.html
echo '                        <div class="timeline-header">' >> index.html
echo '                            <h3 class="timeline-title">iOS 工程师</h3>' >> index.html
echo '                            <div class="timeline-meta">' >> index.html
echo '                                <span class="timeline-company">深圳市新源润产品信息技术有限公司</span>' >> index.html
echo '                                <span class="timeline-period">2023年2月 - 至今</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="timeline-description">' >> index.html
echo '                            <p>负责公司 iOS 应用开发和维护工作</p>' >> index.html
echo '                            <ul>' >> index.html
echo '                                <li>参与项目需求评审和代码 review</li>' >> index.html
echo '                                <li>编写技术文档和项目交接工作</li>' >> index.html
echo '                                <li>主导技术选型，制定开发规范和最佳实践</li>' >> index.html
echo '                                <li>负责新人技术指导，推动团队技术能力提升</li>' >> index.html
echo '                            </ul>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

# 天瑞集团
echo '                    <div class="timeline-item">' >> index.html
echo '                        <div class="timeline-header">' >> index.html
echo '                            <h3 class="timeline-title">iOS 开发工程师</h3>' >> index.html
echo '                            <div class="timeline-meta">' >> index.html
echo '                                <span class="timeline-company">天瑞集团</span>' >> index.html
echo '                                <span class="timeline-period">2020年1月 - 2023年1月</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="timeline-description">' >> index.html
echo '                            <p>主导天瑞华为联合创新研发中心工业互联网项目开发工作</p>' >> index.html
echo '                            <ul>' >> index.html
echo '                                <li>主导老项目的重构工作</li>' >> index.html
echo '                                <li>负责各类项目渠道分发工作</li>' >> index.html
echo '                                <li><strong>业绩</strong>: 项目入选工信部2022年工业互联网试点示范项目</li>' >> index.html
echo '                            </ul>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

# 软通动力
echo '                    <div class="timeline-item">' >> index.html
echo '                        <div class="timeline-header">' >> index.html
echo '                            <h3 class="timeline-title">iOS 开发工程师</h3>' >> index.html
echo '                            <div class="timeline-meta">' >> index.html
echo '                                <span class="timeline-company">软通动力</span>' >> index.html
echo '                                <span class="timeline-period">2016年6月 - 2019年12月</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="timeline-description">' >> index.html
echo '                            <p>主导平安养老险渠道开发部egis-isp系统易展通项目组iOS端开发工作</p>' >> index.html
echo '                            <ul>' >> index.html
echo '                                <li>跟踪线上 crash 并修复，保障崩溃率在万分之五以下</li>' >> index.html
echo '                                <li>负责接入听云、友盟、神兵等服务统计工作</li>' >> index.html
echo '                                <li>参与需求开发评审工作，对 app 中存在的问题提出合理化建议</li>' >> index.html
echo '                            </ul>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                </div>' >> index.html
echo '            </div>' >> index.html
echo '        </section>' >> index.html

# 技术栈部分
echo "        <!-- Skills Section -->" >> index.html
echo '        <section id="skills">' >> index.html
echo '            <div class="container">' >> index.html
echo '                <div class="section-header">' >> index.html
echo '                    <h2 class="section-title">技能</h2>' >> index.html
echo '                    <p class="section-subtitle">掌握的编程语言、框架和工具</p>' >> index.html
echo '                </div>' >> index.html
echo '                <div class="skills-grid">' >> index.html

# 编程语言与框架
echo '                    <div class="skill-category">' >> index.html
echo '                        <h3>编程语言</h3>' >> index.html
echo '                        <div class="skill-list">' >> index.html
echo '                            <span class="skill-tag">Objective-C</span>' >> index.html
echo '                            <span class="skill-tag">Swift</span>' >> index.html
echo '                            <span class="skill-tag">HarmonyOS</span>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                    <div class="skill-category">' >> index.html
echo '                        <h3>UI框架</h3>' >> index.html
echo '                        <div class="skill-list">' >> index.html
echo '                            <span class="skill-tag">UIKit</span>' >> index.html
echo '                            <span class="skill-tag">SwiftUI</span>' >> index.html
echo '                            <span class="skill-tag">SnapKit</span>' >> index.html
echo '                            <span class="skill-tag">Masonry</span>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                    <div class="skill-category">' >> index.html
echo '                        <h3>网络框架</h3>' >> index.html
echo '                        <div class="skill-list">' >> index.html
echo '                            <span class="skill-tag">AFNetworking</span>' >> index.html
echo '                            <span class="skill-tag">Alamofire</span>' >> index.html
echo '                            <span class="skill-tag">Moya</span>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                    <div class="skill-category">' >> index.html
echo '                        <h3>数据与图像</h3>' >> index.html
echo '                        <div class="skill-list">' >> index.html
echo '                            <span class="skill-tag">SDWebImage</span>' >> index.html
echo '                            <span class="skill-tag">Kingfisher</span>' >> index.html
echo '                            <span class="skill-tag">RealmSwift</span>' >> index.html
echo '                            <span class="skill-tag">Core Data</span>' >> index.html
echo '                            <span class="skill-tag">HandyJSON</span>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                    <div class="skill-category">' >> index.html
echo '                        <h3>开发工具</h3>' >> index.html
echo '                        <div class="skill-list">' >> index.html
echo '                            <span class="skill-tag">Git</span>' >> index.html
echo '                            <span class="skill-tag">Jenkins</span>' >> index.html
echo '                            <span class="skill-tag">SwiftLint</span>' >> index.html
echo '                            <span class="skill-tag">Postman</span>' >> index.html
echo '                            <span class="skill-tag">Charles</span>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                </div>' >> index.html
echo '            </div>' >> index.html
echo '        </section>' >> index.html

# 项目经验部分
echo "        <!-- Projects Section -->" >> index.html
echo '        <section id="projects">' >> index.html
echo '            <div class="container">' >> index.html
echo '                <div class="section-header">' >> index.html
echo '                    <h2 class="section-title">项目经验</h2>' >> index.html
echo '                    <p class="section-subtitle">参与开发和维护的主要项目</p>' >> index.html
echo '                </div>' >> index.html
echo '                <div class="projects-grid">' >> index.html

# 智慧矿山项目
echo '                    <div class="project-card">' >> index.html
echo '                        <div class="project-header">' >> index.html
echo '                            <h3 class="project-title">智慧矿山 | 工业互联网平台</h3>' >> index.html
echo '                            <div class="project-meta">2020年6月 - 2023年1月 | 天瑞集团</div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="project-content">' >> index.html
echo '                            <div class="project-description">' >> index.html
echo '                                工业互联网数字化平台，入选工信部2022年工业互联网试点示范项目。主导智慧矿山客户端的维护工作，使用RealmSwift进行数据持久化，负责调度员相关业务的开发，实现实时调度和监控功能。' >> index.html
echo '                            </div>' >> index.html
echo '                            <div class="project-tech">' >> index.html
echo '                                <span class="tech-tag">SnapKit</span>' >> index.html
echo '                                <span class="tech-tag">Moya</span>' >> index.html
echo '                                <span class="tech-tag">HandyJSON</span>' >> index.html
echo '                                <span class="tech-tag">RealmSwift</span>' >> index.html
echo '                                <span class="tech-tag">WebSocket</span>' >> index.html
echo '                                <span class="tech-tag">SwiftLint</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

# 天瑞水泥项目
echo '                    <div class="project-card">' >> index.html
echo '                        <div class="project-header">' >> index.html
echo '                            <h3 class="project-title">天瑞水泥 | 数字营销服务平台</h3>' >> index.html
echo '                            <div class="project-meta">2020年1月 - 2023年1月 | 天瑞集团</div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="project-content">' >> index.html
echo '                            <div class="project-description">' >> index.html
echo '                                天瑞集团数字营销服务平台的iOS客户端，维护月活跃用户50万+。负责订单系统、分红和积分、竞价模块开发，支持日均10万+订单处理。集成微信支付、支付宝、Apple Pay等多种支付方式。' >> index.html
echo '                            </div>' >> index.html
echo '                            <div class="project-tech">' >> index.html
echo '                                <span class="tech-tag">SnapKit</span>' >> index.html
echo '                                <span class="tech-tag">Moya</span>' >> index.html
echo '                                <span class="tech-tag">HandyJSON</span>' >> index.html
echo '                                <span class="tech-tag">RealmSwift</span>' >> index.html
echo '                                <span class="tech-tag">支付SDK</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

# 易展通项目
echo '                    <div class="project-card">' >> index.html
echo '                        <div class="project-header">' >> index.html
echo '                            <h3 class="project-title">易展通 | 养老险直销展销平台</h3>' >> index.html
echo '                            <div class="project-meta">2016年6月 - 2019年12月 | 软通动力</div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="project-content">' >> index.html
echo '                            <div class="project-description">' >> index.html
echo '                                平安养老险直销业务员移动展销平台，服务平安集团2万+业务员。实现平安一账通对接，国密加密处理，地图调用和定位服务，ECharts关系图展示客户关系网络。设计app安全策略，通过平安安全审计。' >> index.html
echo '                            </div>' >> index.html
echo '                            <div class="project-tech">' >> index.html
echo '                                <span class="tech-tag">大企业分发</span>' >> index.html
echo '                                <span class="tech-tag">国密加密</span>' >> index.html
echo '                                <span class="tech-tag">hybrid开发</span>' >> index.html
echo '                                <span class="tech-tag">地图API</span>' >> index.html
echo '                                <span class="tech-tag">ECharts</span>' >> index.html
echo '                                <span class="tech-tag">安全加固</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                </div>' >> index.html
echo '            </div>' >> index.html
echo '        </section>' >> index.html

# 联系方式部分
echo '        <section id="contact">' >> index.html
echo '            <div class="container">' >> index.html
echo '                <div class="section-header">' >> index.html
echo '                    <h2 class="section-title">联系方式</h2>' >> index.html
echo '                    <p class="section-subtitle">欢迎与我联系讨论iOS开发相关话题</p>' >> index.html
echo '                </div>' >> index.html
echo '                <div class="contact-links">' >> index.html
echo '                    <div style="text-align: center; margin-bottom: 32px;">' >> index.html
echo '                        <p style="font-size: 18px; color: var(--text-primary); margin-bottom: 16px;">📱 15214363830</p>' >> index.html
echo '                        <p style="font-size: 18px; color: var(--text-primary); margin-bottom: 16px;">📍 深圳市</p>' >> index.html
echo '                        <p style="font-size: 18px; color: var(--text-primary);">✉️ shawn2045@qq.com</p>' >> index.html
echo '                    </div>' >> index.html
echo '                    <div style="display: flex; gap: 24px; justify-content: center; flex-wrap: wrap;">' >> index.html
echo '                        <a href="mailto:shawn2045@qq.com" class="contact-link">📧 邮箱联系</a>' >> index.html
echo '                        <a href="https://linkedin.com/in/guzhi" target="_blank" class="contact-link">💼 LinkedIn</a>' >> index.html
echo '                        <a href="https://github.com/guzhi" target="_blank" class="contact-link">🐙 GitHub</a>' >> index.html
echo '                        <a href="https://apps.apple.com/developer/guzhi" target="_blank" class="contact-link">📱 App Store</a>' >> index.html
echo '                    </div>' >> index.html
echo '                </div>' >> index.html
echo '            </div>' >> index.html
echo '        </section>' >> index.html

echo '    </main>' >> index.html

# 添加JavaScript
cat >> index.html << 'EOF'
    <script>
        // Mobile menu functionality
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const navLinks = document.getElementById('navLinks');

        if (mobileMenuBtn && navLinks) {
            mobileMenuBtn.addEventListener('click', () => {
                navLinks.classList.toggle('active');
            });

            // Close mobile menu when clicking on a link
            document.querySelectorAll('.nav-links a').forEach(link => {
                link.addEventListener('click', () => {
                    navLinks.classList.remove('active');
                });
            });
        }

        // Smooth scrolling for navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Active navigation highlighting
        const sections = document.querySelectorAll('section[id]');
        const navLinks_active = document.querySelectorAll('.nav-links a[href^="#"]');

        function setActiveNavLink() {
            let current = '';

            sections.forEach(section => {
                const sectionTop = section.offsetTop - 100;
                const sectionHeight = section.clientHeight;

                if (window.pageYOffset >= sectionTop &&
                    window.pageYOffset < sectionTop + sectionHeight) {
                    current = section.getAttribute('id');
                }
            });

            navLinks_active.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === `#${current}`) {
                    link.classList.add('active');
                }
            });
        }

        window.addEventListener('scroll', setActiveNavLink);
        setActiveNavLink(); // Set initial active state

        // Intersection Observer for timeline items animation
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animationDelay = '0.1s';
                    entry.target.style.animationPlayState = 'running';
                }
            });
        }, observerOptions);

        // Observe timeline items
        document.querySelectorAll('.timeline-item').forEach((item, index) => {
            item.style.animationPlayState = 'paused';
            item.style.animationDelay = `${index * 0.2}s`;
            observer.observe(item);
        });

        // Observe skill categories
        document.querySelectorAll('.skill-category').forEach((item, index) => {
            item.style.animationPlayState = 'paused';
            item.style.animationDelay = `${index * 0.1}s`;
            observer.observe(item);
        });

        // Observe project cards
        document.querySelectorAll('.project-card').forEach((item, index) => {
            item.style.animationPlayState = 'paused';
            item.style.animationDelay = `${index * 0.15}s`;
            observer.observe(item);
        });
    </script>
</body>
</html>
EOF

echo "✅ 简历构建完成！生成的文件：index.html"
echo "📱 现代化响应式设计"
echo "🎨 渐变色主题和动画效果"
echo "⚡ 单页应用架构"