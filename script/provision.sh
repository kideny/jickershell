#!/bin/bash

# 操作系统预处理函数
provision(){

    #处理PATH
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

    #杀死所有apache2的进程
    killall apache2

    #remove不需要的debian系统自带程序
    dpkg -P libmysqlclient15off libmysqlclient15-dev mysql-common
    dpkg -P apache2 apache2-doc apache2-mpm-prefork apache2-utils apache2.2-common
    dpkg -P mysql-server mysql-client
    dpkg -P nginx php5-fpm php5-gd php5-mysql
    dpkg -l |grep nginx | awk -F " " '{print $2}' | xargs dpkg -P

    # 移除操作系统自带的旧版本软件
    apt-get remove -y \
        exim4 \
        apache2 \
        apache2-doc \
        apache2-utils \
        apache2.2-common \
        apache2.2-bin \
        apache2-mpm-prefork \
        apache2-mpm-worker \
        mysql-client \
        mysql-server \
        mysql-common \
        php5 \
        php5-common \
        php5-cgi \
        php5-mysql \
        php5-curl \
        php5-gd
    
    #卸载exim4邮件发送程序
    apt-get --purge remove exim4
    apt-get --purge remove exim4-base
}