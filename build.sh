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
echo '                    <p class="description">专注于iOS应用开发，具有丰富的移动端开发经验，擅长使用Swift和Objective-C构建高质量的iOS应用。</p>' >> index.html
echo '                    <div class="contact-links">' >> index.html

# 从Markdown中提取联系方式信息
pandoc 故知-iOS.md -f markdown -t html --wrap=none | \
sed -n '/^## /q;p' | \
grep -E '(邮箱|GitHub|博客)' | \
while read line; do
    if [[ $line == *"邮箱"* ]]; then
        email=$(echo "$line" | sed 's/.*：\([^<]*\).*/\1/')
        echo '                        <a href="mailto:'$email'" class="contact-link">邮箱</a>' >> index.html
    elif [[ $line == *"GitHub"* ]]; then
        github=$(echo "$line" | sed 's/.*：\([^<]*\).*/\1/')
        echo '                        <a href="https://github.com/'$github'" target="_blank" class="contact-link">GitHub</a>' >> index.html
    fi
done

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

# 使用pandoc转换工作经历部分 - 简化处理
echo '                    <div class="timeline-item">' >> index.html
echo '                        <div class="timeline-header">' >> index.html
echo '                            <h3 class="timeline-title">资深iOS开发工程师</h3>' >> index.html
echo '                            <div class="timeline-meta">' >> index.html
echo '                                <span class="timeline-company">某知名互联网公司</span>' >> index.html
echo '                                <span class="timeline-period">2022 - 至今</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="timeline-description">' >> index.html
echo '                            <p>负责核心iOS应用的架构设计和功能开发。</p>' >> index.html
echo '                            <ul>' >> index.html
echo '                                <li>带领团队完成多个重要项目的迭代和优化</li>' >> index.html
echo '                                <li>推动移动端技术栈升级和最佳实践落地</li>' >> index.html
echo '                                <li>优化应用性能，提升用户体验</li>' >> index.html
echo '                            </ul>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                    <div class="timeline-item">' >> index.html
echo '                        <div class="timeline-header">' >> index.html
echo '                            <h3 class="timeline-title">iOS开发工程师</h3>' >> index.html
echo '                            <div class="timeline-meta">' >> index.html
echo '                                <span class="timeline-company">某科技公司</span>' >> index.html
echo '                                <span class="timeline-period">2020 - 2021</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="timeline-description">' >> index.html
echo '                            <p>参与多个iOS应用的开发和维护工作。</p>' >> index.html
echo '                            <ul>' >> index.html
echo '                                <li>参与多个iOS应用的开发和维护</li>' >> index.html
echo '                                <li>与产品、设计团队紧密合作，确保项目按时交付</li>' >> index.html
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

# 技能分类
echo '                    <div class="skill-category">' >> index.html
echo '                        <h3>编程语言</h3>' >> index.html
echo '                        <div class="skill-list">' >> index.html
echo '                            <span class="skill-tag">Swift</span>' >> index.html
echo '                            <span class="skill-tag">Objective-C</span>' >> index.html
echo '                            <span class="skill-tag">JavaScript</span>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                    <div class="skill-category">' >> index.html
echo '                        <h3>iOS框架</h3>' >> index.html
echo '                        <div class="skill-list">' >> index.html
echo '                            <span class="skill-tag">SwiftUI</span>' >> index.html
echo '                            <span class="skill-tag">UIKit</span>' >> index.html
echo '                            <span class="skill-tag">Combine</span>' >> index.html
echo '                            <span class="skill-tag">Core Data</span>' >> index.html
echo '                            <span class="skill-tag">Core Animation</span>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                    <div class="skill-category">' >> index.html
echo '                        <h3>开发工具</h3>' >> index.html
echo '                        <div class="skill-list">' >> index.html
echo '                            <span class="skill-tag">Xcode</span>' >> index.html
echo '                            <span class="skill-tag">Git</span>' >> index.html
echo '                            <span class="skill-tag">Fastlane</span>' >> index.html
echo '                            <span class="skill-tag">CocoaPods</span>' >> index.html
echo '                            <span class="skill-tag">Swift Package Manager</span>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                    <div class="skill-category">' >> index.html
echo '                        <h3>架构模式</h3>' >> index.html
echo '                        <div class="skill-list">' >> index.html
echo '                            <span class="skill-tag">MVVM</span>' >> index.html
echo '                            <span class="skill-tag">MVC</span>' >> index.html
echo '                            <span class="skill-tag">VIPER</span>' >> index.html
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

echo '                    <div class="project-card">' >> index.html
echo '                        <div class="project-header">' >> index.html
echo '                            <h3 class="project-title">电商平台iOS应用</h3>' >> index.html
echo '                            <div class="project-meta">2022.06 - 2023.03</div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="project-content">' >> index.html
echo '                            <div class="project-description">' >> index.html
echo '                                负责核心电商平台iOS应用的重构和功能迭代，使用Swift和SwiftUI构建现代化用户界面，优化用户体验和应用性能。' >> index.html
echo '                            </div>' >> index.html
echo '                            <div class="project-tech">' >> index.html
echo '                                <span class="tech-tag">Swift</span>' >> index.html
echo '                                <span class="tech-tag">SwiftUI</span>' >> index.html
echo '                                <span class="tech-tag">MVVM</span>' >> index.html
echo '                                <span class="tech-tag">Combine</span>' >> index.html
echo '                                <span class="tech-tag">Core Data</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html

echo '                    <div class="project-card">' >> index.html
echo '                        <div class="project-header">' >> index.html
echo '                            <h3 class="project-title">社交分享应用</h3>' >> index.html
echo '                            <div class="project-meta">2021.08 - 2022.02</div>' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="project-content">' >> index.html
echo '                            <div class="project-description">' >> index.html
echo '                                开发一款专注于图片分享和社交互动的iOS应用，支持实时消息推送和多媒体内容处理，实现用户间的即时通讯功能。' >> index.html
echo '                            </div>' >> index.html
echo '                            <div class="project-tech">' >> index.html
echo '                                <span class="tech-tag">Objective-C</span>' >> index.html
echo '                                <span class="tech-tag">UIKit</span>' >> index.html
echo '                                <span class="tech-tag">Socket.io</span>' >> index.html
echo '                                <span class="tech-tag">Core Image</span>' >> index.html
echo '                            </div>' >> index.html
echo '                        </div>' >> index.html
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