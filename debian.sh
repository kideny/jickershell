#!/bin/bash

#  Auther      Frank Kennedy Yuan
#  Website    http://www.jicker.cn
#  Company  http://www.loserhub.com

# 第一步：执行操作系统的一些预先处理的命令

# 加载预处理脚本
. script/provision.sh
# 执行操作系统预处理函数
provision

# 第二步：处理系统源

# 加载系统源处理脚本
. script/sources.sh
# 执行系统源处理的脚本
sources

#第三步: 对操作系统进行更新

# 加载更新脚本
. script/update.sh
# 执行操作系统更新的函数
update

# 第四步：定义变量

# 定义变量，获得当前脚本的路路径
current_dir=$(pwd)
# 定义默认安装程序的下载路径
srcDir="/usr/local/src"

# 第五步：加载安装脚本并选择要安装的组件

# 加载各种安装脚本
. apps/docker/install/docker.sh
. apps/docker/install/compose.sh
. apps/nginx/install/proxy.sh
. apps/nginx/install/product.sh
. apps/openresty/install/proxy.sh
. apps/openresty/install/product.sh
. apps/tengine/install/proxy.sh
. apps/tengine/install/product.sh
. apps/php/php56.sh
. apps/php/php7.sh
. apps/php/php71.sh

# 选择要安装的组件
install() {

    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  0:  Install  Docker CE + Docker Compose  "
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
        0)
            install__docker
            install__compose
            ;;
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

# 最后一步：系统清理

# 加载系统清理的脚本
. script/clean.sh
# 执行清理函数
clear