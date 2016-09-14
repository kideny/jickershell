#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#  Auther      Frank.Yuan
#  Website    http://www.jicker.cn https://www.frankyuan.com
#  Company  http://www.qmschool.cn

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

#修改默认的源，添加往医院和debian官方源
if [ -s /etc/apt/sources.list.bak ]; then
rm /etc/apt/sources.list -f
mv /etc/apt/sources.list.bak /etc/apt/sources.list
fi
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cat >> /etc/apt/sources.list<<EOF
deb http://mirrors.163.com/debian/ wheezy main
deb-src http://mirrors.163.com/debian/ wheezy main
deb http://security.debian.org/ wheezy/updates main
deb-src http://security.debian.org/ wheezy/updates main
deb http://packages.dotdeb.org stable all
deb-src http://packages.dotdeb.org stable all
deb http://mirrors.163.com/debian/ wheezy-updates main
deb-src http://mirrors.163.com/debian/ wheezy-updates main
EOF
apt-get clean
apt-get autoclean
rm /var/lib/apt/lists/* -vf

# 定义变量
current_dir=$(pwd)  #定义当前路径变量

#清屏准备显示选择组件
clear

# 加载各种安装脚本
. tengine/tengine_debian7_proxy.sh
. tengine/tengine_debian7_product.sh
. php/php56_debian7.sh
. php/php7_debian7.sh
. go/go.sh
. mysql/mysql.sh

# 选择要安装的组件
install() {
    echo ""
    echo "  1: tengine on proxy server"
    echo "  2: tengine+php5.6"
    echo "  3: tengine+php7"
    echo "  4: tengine+go"
    echo "  5: tengine+go+php7"
    echo "  6: tengine+php5.6+mysql"
    echo "  7: tengine+php7+mysql"
    echo "  8: tengine+go+mysql"

    echo ""
    echo "  11: tengine on proxy server"
    echo "  12: tengine+php5.6"
    echo "  13: tengine+php7"
    echo "  14: tengine+go"
    echo "  15: tengine+go+php7"
    echo "  16: tengine+php5.6+mysql"
    echo "  17: tengine+php7+mysql"
    echo "  18: tengine+go+mysql"

    read -p ">>Enter your choose number (or exit): " num

    case "$(num)" in
        1)
            install_tengine_proxy
            ;;
        2)
            install_tengine_product
            install_php56
            ;;
        3)
            install_tengine_product
            install_php7
            ;;
        4)
            install_tengine_product
            install_go
            ;;
        5)
            install_tengine__product
            install_go
            install_php7
            ;;
        6)
            install_tengine__product
            install_php56
            install_mysql
            ;;
        7)
            install_tengine__product
            install_php7
            install_mysql
            ;;
        8)
            install_tengine__product
            install_go
            install_mysql
            ;;
        11)
            install_nginx_proxy
            ;;
        12)
            install_nginx_product
            install_php56
            ;;
        13)
            install_nginx_product
            install_php7
            ;;
        14)
            install_nginx_product
            install_go
            ;;
        15)
            install_nginx__product
            install_go
            install_php7
            ;;
        16)
            install_nginx__product
            install_php56
            install_mysql
            ;;
        17)
            install_nginx__product
            install_php7
            install_mysql
            ;;
        18)
            install_nginx__product
            install_go
            install_mysql
            ;;
        * )
            exit 1
        ;;
    esac
}

clear() {
    rm -rf /usr/local/src/*.*
    echo "Install Sucess! Debian DaFa GuoRan Hao ,HaHaHa!"
}
