#!/bin/bash

# 选择要安装的组件
install() {

    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  0:  Install  Docker CE + Docker Compose  "
    echo "  1:  Install  Tengine as proxy  "
    echo "  2:  Install  Nginx as proxy  "
    echo "  3:  Install  OpenResty  as proxy  "
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  11: Install  PHP5.6  "
    echo "  12: Install  PHP7.1  "
    echo "  13: Install  PHP7.2  "
    echo "  14: Install  PHP7.3  "
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  7201:  Install  Tengine  +  PHP72  "
    echo "  7202:  Install  Nginx  +  PHP72  "
    echo "  7203:  Install  OpenResty  +  PHP72  "
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  7101:  Install  Tengine  +  PHP71  "
    echo "  7102:  Install  Nginx  +  PHP71  "
    echo "  7103:  Install  OpenResty  +  PHP71  "
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  7301:  Install  Tengine  +  PHP73  "
    echo "  7302:  Install  Nginx  +  PHP73  "
    echo "  7303:  Install  OpenResty  +  PHP73  "
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  561: Install  Tengine  +  PHP5.6  "
    echo "  562: Install  Nginx  +  PHP5.6  "
    echo "  563: Install  OpenResty  +  PHP5.6  "
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
            install_php71
            ;;
        13)
            install_php72
            ;;
        14)
            install_php73
            ;;
        7201)
            install_tengine_product
            install_php72
            ;;
        7202)
            install_nginx_product
            install_php72
            ;;
        7203)
            install_openresty_product
            install_php72
            ;;
        7101)
            install_tengine_product
            install_php71
            ;;
        7102)
            install_nginx_product
            install_php71
            ;;
        7103)
            install_openresty_product
            install_php71
            ;;
        7301)
            install_tengine_product
            install_php73
            ;;
        7302)
            install_nginx_product
            install_php73
            ;;
        7303)
            install_openresty_product
            install_php73
            ;;
        561)
            install_tengine_product
            install_php56
            ;;
        562)
            install_nginx_product
            install_php56
            ;;
        563)
            install_openresty_product
            install_php56
            ;;
        * )
            exit 1
        ;;
    esac
}