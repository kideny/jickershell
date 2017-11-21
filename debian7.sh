#!/bin/bash

#  Auther      Frank Kennedy Yuan
#  Website    http://www.jicker.cn
#  Company  http://www.loserhub.com

# 加载预处理脚本
. script/provision.sh

# 执行操作系统预处理函数
provision

# 加载系统源处理脚本
. script/sources.sh

# 执行系统源处理的脚本
sources

#添加新的源
cat >> /etc/apt/sources.list<<EOF
deb http://mirrors.163.com/debian/ testing contrib main non-free
deb-src http://mirrors.163.com/debian/ testing contrib main non-free
deb http://mirrors.163.com/debian/ wheezy-updates main
deb http://mirrors.163.com/debian wheezy main non-free contrib
deb http://mirrors.163.com/debian wheezy-updates main non-free contrib
deb-src http://mirrors.163.com/debian/ wheezy-updates main
deb-src http://mirrors.163.com/debian wheezy main non-free contrib
deb-src http://mirrors.163.com/debian wheezy-updates main non-free contrib
deb http://mirrors.aliyun.com/debian/ wheezy main non-free contrib
deb http://mirrors.aliyun.com/debian/ wheezy-proposed-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ wheezy main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ wheezy-proposed-updates main non-free contrib
deb http://security.debian.org/ wheezy/updates main
deb-src http://security.debian.org/ wheezy/updates main
deb http://packages.dotdeb.org stable all
deb-src http://packages.dotdeb.org stable all
deb http://nginx.org/packages/debian/ wheezy nginx
deb-src http://nginx.org/packages/debian/ wheezy nginx
EOF

# Install Node.js 6.x ,Using Debian, as root
curl -sL https://deb.nodesource.com/setup_6.x | bash -
#apt-get install -y nodejs

# 定义变量，获得当前脚本的路路径
current_dir=$(pwd)

#定义默认安装程序的下载路径
srcDir="/usr/local/src"

# 加载各种安装脚本
. apps/nginx/install/proxy.sh
. apps/nginx/install/product.sh
. apps/openresty/install/proxy.sh
. apps/openresty/install/product.sh
. apps/tengine/install/proxy.sh
. apps/tengine/install/product.sh
. apps/php/php56.sh
. apps/php/php7.sh
. apps/php/php71.sh

run() {
    install
}

# 选择要安装的组件
install() {

    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  1:  Install  Tengine as proxy  "
    echo "  2:  Install  Nginx as proxy  "
    echo "  3:  Install  OpenResty  as proxy  "
    echo "  11: Install  PHP5.6  "
    echo "  12: Install  PHP7.0  "
    echo "  13: Install  PHP7.1  "
    echo "  4:  Install  Tengine  +  PHP7  "
    echo "  5:  Install  Nginx  +  PHP7  "
    echo "  6:  Install  OpenResty  +  PHP7  "
    echo "  31: Install  Tengine  +  PHP5.6  "
    echo "  32: Install  Nginx  +  PHP5.6  "
    echo "  33: Install  OpenResty  +  PHP5.6  "
    echo ""
    echo "-------------------------------------------------------------------------"

    read -p ">>Enter your choose number (or exit): "  num

    case "${num}" in
        1)
            install_tengine_proxy
            ;;
        2)
            install_nginx_proxy
            ;;
        3)
            install_tengine_proxy
            ;;
        11)
            install_php56
            ;;
        12)
            install_php7
            ;;
        13)
            install_php71
            ;;
        4)
            install_tengine_product
            install_php7
            ;;
        5)
            install_nginx_product
            install_php7
            ;;
        6)
            install_openresty_product
            install_php7
            ;;
        31)
            install_tengine_product
            install_php56
            ;;
        32)
            install_nginx_product
            install_php56
            ;;
        33)
            install_openresty_product
            install_php56
            ;;
        * )
            exit 1
        ;;
    esac
}

# 执行程序安装的函数
install

# 加载预处理脚本
. script/clean.sh

# 执行清理函数
clear