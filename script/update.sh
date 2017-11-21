#!/bin/bash

update() {

    # 对Debian系统Update
    apt-get update -y

    # 对Debian系统Upgrade，-u参数可以罗列出需要升级的软件
    apt-get -u upgrade -y

    # 安装必要的软件
    apt-get install 
        git \
        composer \
        pkg-config \
        curl \
        openssl \
        gcc \
        g++ \
        make \
        wget \
        htop \
        perl \
}