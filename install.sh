#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

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

# 定义变量
current_dir=$(pwd)  #定义当前路径变量

#清屏准备显示选择组件
clear

# 加载各种安装脚本
. tengine/tengine_debian75_proxy.sh
. tengine/tengine_debian75_product.sh
. php/php56_debian75.sh
. php/php7_debian75.sh
. go/go.sh
. mysql/mysql.sh


## 第一步，选择要安装的组件
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
        * )
            exit 1
        ;;
    esac
}
