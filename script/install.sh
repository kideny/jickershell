#!/bin/bash

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