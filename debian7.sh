#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#  Auther      Frank Kennedy Yuan
#  Website    http://www.jicker.cn
#  Company  http://www.loserhub.com

#检测是否root账户权限
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install DDFH"
    exit 1
fi

#判定是否开启selinux，如果开启则关闭
if [ -s /etc/selinux/config ]; then
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
fi

#删除系统自带的时区文件
rm -rf /etc/localtime

#设置时区为上海
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#修改默认的源，添加163源和debian官方源
if [ -s /etc/apt/sources.list.bak ]; then
rm /etc/apt/sources.list -f
mv /etc/apt/sources.list.bak /etc/apt/sources.list
fi
mv /etc/apt/sources.list /etc/apt/sources.list.bak
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

#执行自动清理
apt-get clean
apt-get autoclean

# rm /var/lib/apt/lists/* -vf

# 定义变量，获得当前脚本的路路径
current_dir=$(pwd)

# 加载各种安装脚本
. apps/nginx/install/proxy.sh
. apps/nginx/install/product.sh
. apps/openresty/install/proxy.sh
. apps/openresty/install/product.sh
. apps/tengine/install/proxy.sh
. apps/tengine/install/product.sh
. apps/php/php56.sh
. apps/php/php7.sh

run() {
    install
}

# 选择要安装的组件
install() {
    echo ""
    echo "  1: tengine on proxy server"
    echo "  2: nginx on proxy server"
    echo "  3: openresty on proxy server"
    echo "  11: php5.6 only install"
    echo "  12: php7.0 only Install"
    echo "  13: php7.1 only Install"
    echo "  4: tengine+php7"
    echo "  5: nginx+php7"
    echo "  6: openresty+php7"
    echo "  31: tengine+php5.6"
    echo "  32: nginx+php5.6"
    echo "  33: openresty+php5.6"
    echo ""

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

clear() {
    #rm -rf /usr/local/src/*.*
    echo "Install Sucess! Debian DaFa GuoRan Hao ,HaHaHa!"
}

install
clear