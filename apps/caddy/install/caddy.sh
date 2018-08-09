#!/bin/bash

# 官方网站 https://docs.docker.com/engine/installation/linux/docker-ce/debian/#set-up-the-repository

# OS requirements
#
#    Buster 10 (Docker CE 17.11 Edge only)
#    Stretch 9 (stable) / Raspbian Stretch
#    Jessie 8 (LTS) / Raspbian Jessie
#    Wheezy 7.7 (LTS)
#

install__caddy() {
    
    curl https://getcaddy.com | bash

    #检查docker的进程是否存在
    caddyVersion=$(caddy --version)

    if [ "${caddyVersion}" = "" ]; 
        #安装失败的欢迎致辞！
        echo "Caddy install fail!";
    then
        #安装成功的欢迎致辞！
        echo "Caddy install success!";
    fi
}