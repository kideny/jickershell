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
deb http://mirrors.aliyun.com/debian jessie main contrib non-free
deb http://mirrors.aliyun.com/debian jessie-proposed-updates main contrib non-free
deb http://mirrors.aliyun.com/debian jessie-updates main contrib non-free
deb http://mirrors.aliyun.com/debian jessie-backports main contrib non-free
deb-src http://mirrors.aliyun.com/debian jessie main contrib non-free
deb-src http://mirrors.aliyun.com/debian jessie-proposed-updates main contrib non-free
deb-src http://mirrors.aliyun.com/debian jessie-updates main contrib non-free
deb-src http://mirrors.aliyun.com/debian jessie-backports main contrib non-free
deb http://mirrors.aliyun.com/debian-security/ jessie/updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian-security/ jessie/updates main non-free contrib
deb http://mirrors.aliyuncs.com/debian jessie main contrib non-free
deb http://mirrors.aliyuncs.com/debian jessie-proposed-updates main contrib non-free
deb http://mirrors.aliyuncs.com/debian jessie-updates main contrib non-free
deb http://mirrors.aliyuncs.com/debian jessie-backports main contrib non-free
deb-src http://mirrors.aliyuncs.com/debian jessie main contrib non-free
deb-src http://mirrors.aliyuncs.com/debian jessie-proposed-updates main contrib non-free
deb-src http://mirrors.aliyuncs.com/debian jessie-updates main contrib non-free
deb-src http://mirrors.aliyuncs.com/debian jessie-backports main contrib non-free
deb http://mirrors.aliyuncs.com/debian-security/ jessie/updates main non-free contrib
deb-src http://mirrors.aliyuncs.com/debian-security/ jessie/updates main non-free contrib
deb http://nginx.org/packages/debian/  	jessie nginx
deb-src http://nginx.org/packages/debian/  	jessie nginx
EOF

#执行自动清理
apt-get clean
apt-get autoclean

# rm /var/lib/apt/lists/* -vf

# 定义变量
current_dir=${pwd}

# 加载各种安装脚本
. server/nginx/install/proxy.sh
. server/nginx/install/product.sh
. server/openresty/install/proxy.sh
. server/openresty/install/product.sh
. server/tengine/install/proxy.sh
. server/tengine/install/product.sh
. app/php/php56.sh
. app/php/php7.sh

# 选择要安装的组件
install() {
    echo ""
    echo "  1: tengine on proxy server"
    echo "  2: nginx on proxy server"
    echo "  3: openresty on proxy server"
    echo "  4: tengine+php7"
    echo "  5: nginx+php7"
    echo "  6: openresty+php7"
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
        * )
            exit 1
        ;;
    esac
}

install

clear() {
    rm -rf /usr/local/src/*.*
    echo "Install Sucess! Debian DaFa GuoRan Hao ,HaHaHa!"
}
