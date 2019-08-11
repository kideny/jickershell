#!/bin/bash

# 选择要安装的组件
install() {

    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  0:  Install  Docker CE + Docker Compose  "
    echo "  2:  Install  Nginx as proxy  "
    echo "  3:  Install  OpenResty  as proxy  "
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  12: Install  PHP7.1  "
    echo "  13: Install  PHP7.2  "
    echo "  14: Install  PHP7.3  "
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  7102:  Install  Nginx  +  PHP71  "
    echo "  7103:  Install  OpenResty  +  PHP71  "
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  7202:  Install  Nginx  +  PHP72  "
    echo "  7203:  Install  OpenResty  +  PHP72  "
    echo ""
    echo "-------------------------------------------------------------------------"
    echo ""
    echo "  7302:  Install  Nginx  +  PHP73  "
    echo "  7303:  Install  OpenResty  +  PHP73  "
    echo ""
    echo "-------------------------------------------------------------------------"

    read -p ">>Enter your choose number (or exit): "  num

    case "${num}" in
        0)
            install__docker
            install__compose
            ;;
        2)
            install_nginx_proxy
            ;;
        3)
            install_openresty_proxy
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
        7102)
            install_nginx_product
            install_php72
            ;;
        7103)
            install_openresty_product
            install_php71
            ;;
        7202)
            install_nginx_product
            install_php72
            ;;
        7203)
            install_openresty_product
            install_php72
            ;;
        7302)
            install_nginx_product
            install_php73
            ;;
        7303)
            install_openresty_product
            install_php73
            ;;
        * )
            exit 1
        ;;
    esac
}