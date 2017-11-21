#!/bin/bash

# 操作系统预处理函数
sources(){
    #修改默认的源，添加163源和debian官方源
    if [ -s /etc/apt/sources.list.bak ]; then
        rm /etc/apt/sources.list -f
        mv /etc/apt/sources.list.bak /etc/apt/sources.list
    fi

    #备份sources.list
    mv /etc/apt/sources.list /etc/apt/sources.list.bak

    #获取Debian的版本号
    linux_version = more /etc/debian_version
}