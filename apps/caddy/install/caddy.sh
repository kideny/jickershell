#!/bin/bash

# 官方网站 https://caddyserver.com/docs
#
#   
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