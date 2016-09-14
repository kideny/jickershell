项目名称：webshell

作者名称：Frank Yuan

作者博客：http://www.jicker.cn

项目简介：使用shell语言编写的，用户Debian操作系统的web环境配置，默认64位。

项目特色：简单，轻量级，支持多种web环境的配置。

安装方法：

# 第一步：安装git
apt-get install git

# 第二步：命令进入源码下载目录
cd  /usr/local/src

# 第三步：使用git克隆代码
git clone https://github.com/kideny/webshell.git

# 第四步：执行安装脚本
cd /webshell & sh install.sh

常用debian命令：
检查编译后nginx文件的大小：ls -lh /usr/local/nginx/sbin/nginx