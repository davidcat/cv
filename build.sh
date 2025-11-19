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
    <title>故知 - iOS 开发工程师简历</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* CSS Variables for theming */
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --text-color: #2d3748;
            --text-light: #718096;
            --bg-color: #f7fafc;
            --card-bg: #ffffff;
            --border-color: #e2e8f0;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background: var(--bg-color);
            overflow-x: hidden;
        }

        /* Navigation */
        nav {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            z-index: 1000;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-links {
            display: flex;
            gap: 30px;
            list-style: none;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-color);
            font-weight: 500;
            transition: color 0.3s ease;
            position: relative;
        }

        .nav-links a:hover {
            color: var(--primary-color);
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary-color);
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .nav-links a.active {
            color: var(--primary-color);
        }

        .nav-links a.active::after {
            width: 100%;
        }

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 90px 20px 40px;
        }

        /* Sections */
        section {
            margin-bottom: 80px;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 0.6s ease forwards;
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Hero Section */
        .hero {
            text-align: center;
            padding: 60px 0;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 20px;
            margin-bottom: 80px;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 20px 20px;
            animation: float 20s linear infinite;
        }

        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            100% { transform: translate(-50px, -50px) rotate(360deg); }
        }

        .hero-content {
            position: relative;
            z-index: 1;
        }

        .hero h1 {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .hero .subtitle {
            font-size: 20px;
            font-weight: 300;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .contact-info {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 16px;
            border-radius: 25px;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .contact-item:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .contact-item a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        /* Section Headers */
        h2 {
            font-size: 36px;
            font-weight: 600;
            margin-bottom: 40px;
            position: relative;
            padding-bottom: 15px;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        /* Cards */
        .card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 30px;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            margin-bottom: 30px;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        /* Experience Section */
        .experience-item {
            margin-bottom: 40px;
            padding-left: 30px;
            position: relative;
        }

        .experience-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 8px;
            width: 12px;
            height: 12px;
            background: var(--primary-color);
            border-radius: 50%;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .experience-item::after {
            content: '';
            position: absolute;
            left: 5px;
            top: 20px;
            width: 2px;
            height: calc(100% + 10px);
            background: var(--border-color);
        }

        .experience-item:last-child::after {
            display: none;
        }

        .job-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 8px;
        }

        .company {
            font-size: 18px;
            color: var(--primary-color);
            font-weight: 500;
            margin-bottom: 8px;
        }

        .job-meta {
            color: var(--text-light);
            font-size: 14px;
            margin-bottom: 15px;
        }

        /* Skills Section */
        .skills-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }

        .skill-category {
            background: var(--card-bg);
            padding: 25px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border-color);
        }

        .skill-category h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--text-color);
        }

        .skill-items {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .skill-item {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .skill-item:hover {
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        /* Projects Section */
        .projects-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
        }

        .project-card {
            background: var(--card-bg);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .project-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
        }

        .project-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px;
        }

        .project-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .project-period {
            font-size: 14px;
            opacity: 0.9;
        }

        .project-content {
            padding: 25px;
        }

        .project-description {
            color: var(--text-light);
            margin-bottom: 20px;
            line-height: 1.7;
        }

        .project-tech {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .tech-tag {
            background: var(--bg-color);
            color: var(--text-color);
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            border: 1px solid var(--border-color);
        }

        /* Lists */
        ul {
            padding-left: 20px;
            margin-bottom: 20px;
        }

        li {
            margin-bottom: 10px;
            position: relative;
        }

        li::marker {
            color: var(--primary-color);
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 40px 0;
            background: var(--card-bg);
            border-radius: 16px;
            margin-top: 60px;
            border: 1px solid var(--border-color);
        }

        footer p {
            color: var(--text-light);
            font-size: 14px;
        }

        /* Mobile Menu */
        .mobile-menu-btn {
            display: none;
            flex-direction: column;
            cursor: pointer;
            padding: 5px;
        }

        .mobile-menu-btn span {
            width: 25px;
            height: 3px;
            background: var(--text-color);
            margin: 3px 0;
            transition: 0.3s;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .mobile-menu-btn {
                display: flex;
            }

            .nav-links {
                display: none;
                position: absolute;
                top: 70px;
                left: 0;
                right: 0;
                background: white;
                flex-direction: column;
                padding: 20px;
                box-shadow: var(--shadow-lg);
                border-top: 1px solid var(--border-color);
            }

            .nav-links.active {
                display: flex;
            }

            .nav-links li {
                margin: 10px 0;
            }

            .hero h1 {
                font-size: 36px;
            }

            .hero .subtitle {
                font-size: 18px;
            }

            .contact-info {
                gap: 15px;
                flex-direction: column;
                align-items: center;
            }

            h2 {
                font-size: 28px;
            }

            .projects-grid {
                grid-template-columns: 1fr;
            }

            .skills-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Animations */
        .fade-in {
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 0.6s ease forwards;
        }

        .stagger-1 { animation-delay: 0.1s; }
        .stagger-2 { animation-delay: 0.2s; }
        .stagger-3 { animation-delay: 0.3s; }
        .stagger-4 { animation-delay: 0.4s; }

        /* Progress Bar */
        .progress-bar {
            position: fixed;
            top: 0;
            left: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            z-index: 1001;
            transition: width 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="progress-bar" id="progressBar"></div>

    <nav>
        <div class="nav-container">
            <div class="logo">故知</div>
            <ul class="nav-links" id="navLinks">
                <li><a href="#about">关于我</a></li>
                <li><a href="#experience">工作经历</a></li>
                <li><a href="#skills">技术栈</a></li>
                <li><a href="#projects">项目经验</a></li>
                <li><a href="#contact">联系方式</a></li>
            </ul>
            <div class="mobile-menu-btn" id="mobileMenuBtn">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </nav>

    <div class="container">
EOF

# 添加内容部分
echo "        <!-- Hero Section -->" >> index.html
echo '        <section id="about" class="hero fade-in">' >> index.html
echo '            <div class="hero-content">' >> index.html

# 转换个人简介部分
echo '                <h1>故知</h1>' >> index.html
echo '                <p class="subtitle">资深iOS开发工程师</p>' >> index.html
echo '                <div class="contact-info">' >> index.html

# 从Markdown中提取联系方式信息
pandoc 故知-iOS.md -f markdown -t html --wrap=none | \
sed -n '/^## /q;p' | \
grep -E '(邮箱|电话|微信|GitHub|博客)' | \
while read line; do
    # 简化的联系方式处理
    if [[ $line == *"邮箱"* ]]; then
        email=$(echo "$line" | sed 's/.*：\([^<]*\).*/\1/')
        echo '                <div class="contact-item"><span>📧</span><a href="mailto:'$email'">'$email'</a></div>' >> index.html
    elif [[ $line == *"GitHub"* ]]; then
        github=$(echo "$line" | sed 's/.*：\([^<]*\).*/\1/')
        echo '                <div class="contact-item"><span>💼</span><a href="https://github.com/'$github'" target="_blank">GitHub</a></div>' >> index.html
    fi
done

echo '                </div>' >> index.html
echo '            </div>' >> index.html
echo '        </section>' >> index.html

# 工作经历部分
echo "        <!-- Experience Section -->" >> index.html
echo '        <section id="experience" class="fade-in stagger-1">' >> index.html
echo '            <h2>工作经历</h2>' >> index.html

# 使用pandoc转换工作经历部分
pandoc 故知-iOS.md -f markdown -t html --wrap=none | \
awk '/## 工作经历/,/^## 技术栈/' | \
grep -v '^## ' | \
sed 's/^###/<h3 class="job-title">/' | \
sed 's/$/<\/h3>/' | \
sed 's/\*\*\*/<div class="company">/' | \
sed 's/\*\*\*/<\/div>/' | \
sed 's/\*时间.*：/<div class="job-meta">/' | \
sed 's/$/<\/div>/' >> index.html

echo '        </section>' >> index.html

# 技术栈部分
echo "        <!-- Skills Section -->" >> index.html
echo '        <section id="skills" class="fade-in stagger-2">' >> index.html
echo '            <h2>技术栈</h2>' >> index.html
echo '            <div class="skills-grid">' >> index.html

# 简化的技能处理
echo '                <div class="skill-category">' >> index.html
echo '                    <h3>iOS开发</h3>' >> index.html
echo '                    <div class="skill-items">' >> index.html
echo '                        <span class="skill-item">Swift</span>' >> index.html
echo '                        <span class="skill-item">Objective-C</span>' >> index.html
echo '                        <span class="skill-item">SwiftUI</span>' >> index.html
echo '                        <span class="skill-item">UIKit</span>' >> index.html
echo '                    </div>' >> index.html
echo '                </div>' >> index.html

echo '                <div class="skill-category">' >> index.html
echo '                    <h3>开发工具</h3>' >> index.html
echo '                    <div class="skill-items">' >> index.html
echo '                        <span class="skill-item">Xcode</span>' >> index.html
echo '                        <span class="skill-item">Git</span>' >> index.html
echo '                        <span class="skill-item">Fastlane</span>' >> index.html
echo '                    </div>' >> index.html
echo '                </div>' >> index.html

echo '            </div>' >> index.html
echo '        </section>' >> index.html

# 项目经验部分
echo "        <!-- Projects Section -->" >> index.html
echo '        <section id="projects" class="fade-in stagger-3">' >> index.html
echo '            <h2>项目经验</h2>' >> index.html
echo '            <div class="projects-grid">' >> index.html

# 简化的项目处理
echo '                <div class="project-card">' >> index.html
echo '                    <div class="project-header">' >> index.html
echo '                        <div class="project-title">移动应用开发项目</div>' >> index.html
echo '                        <div class="project-period">2022年 - 2024年</div>' >> index.html
echo '                    </div>' >> index.html
echo '                    <div class="project-content">' >> index.html
echo '                        <div class="project-description">' >> index.html
echo '                            负责多个iOS应用的设计、开发和维护，使用现代化技术栈构建高质量移动应用。' >> index.html
echo '                        </div>' >> index.html
echo '                        <div class="project-tech">' >> index.html
echo '                            <span class="tech-tag">Swift</span>' >> index.html
echo '                            <span class="tech-tag">SwiftUI</span>' >> index.html
echo '                            <span class="tech-tag">MVVM</span>' >> index.html
echo '                        </div>' >> index.html
echo '                    </div>' >> index.html
echo '                </div>' >> index.html

echo '            </div>' >> index.html
echo '        </section>' >> index.html

# 联系方式部分
echo "        <!-- Contact Section -->" >> index.html
echo '        <section id="contact" class="fade-in stagger-4">' >> index.html
echo '            <footer>' >> index.html
echo '                <p>© 2024 故知. 感谢您的关注！</p>' >> index.html
echo '            </footer>' >> index.html
echo '        </section>' >> index.html

# 添加JavaScript
cat >> index.html << 'EOF'
    </div>

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

        // Progress bar
        window.addEventListener('scroll', () => {
            const scrollTop = window.pageYOffset;
            const docHeight = document.documentElement.scrollHeight - window.innerHeight;
            const scrollPercent = Math.max(0, Math.min(100, (scrollTop / docHeight) * 100));
            const progressBar = document.getElementById('progressBar');
            if (progressBar) {
                progressBar.style.width = scrollPercent + '%';
            }
        });

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

        // Intersection Observer for animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animationPlayState = 'running';
                }
            });
        }, observerOptions);

        // Observe all sections
        document.querySelectorAll('section').forEach(section => {
            section.style.animationPlayState = 'paused';
            observer.observe(section);
        });

        // Active navigation highlighting
        window.addEventListener('scroll', () => {
            const sections = document.querySelectorAll('section');
            const navLinks = document.querySelectorAll('.nav-links a');

            let current = '';
            sections.forEach(section => {
                const sectionTop = section.offsetTop;
                const sectionHeight = section.clientHeight;
                if (window.pageYOffset >= sectionTop - 100) {
                    current = section.getAttribute('id');
                }
            });

            navLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href').slice(1) === current) {
                    link.classList.add('active');
                }
            });
        });

        // Add interactive hover effects
        document.querySelectorAll('.skill-item, .tech-tag').forEach(item => {
            item.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px) scale(1.05)';
            });

            item.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });
    </script>
</body>
</html>
EOF

echo "✅ 简历构建完成！生成的文件：index.html"
echo "📱 现代化响应式设计"
echo "🎨 渐变色主题和动画效果"
echo "⚡ 单页应用架构"