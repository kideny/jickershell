#!/bin/bash

# 安装phalcon所需依赖
apt-get install - y \
    php5-dev \
    libpcre3-dev \
    php5-mysql

# 进入源码下载目录
cd  /usr/local/src

# git克隆phalcon源码
git  clone  git://github.com/phalcon/cphalcon.git

# 进入安装目录，执行安装程序
cd  cphalcon/build  &&  ./install

# 修改php7配置文件，开启phalcon扩展
echo "zend_extension=opcache.so"  >>  /usr/local/php7/etc/php.ini

# 重新启动php-fpm
service  php7-fpm  restart

# 拷贝默认的系统文件
cp  ./conf/phalcon.conf  /usr/local/nginx/conf/vhost/phalcon.conf

# 必读提示一：Ubuntu/Debian with php5-fpm: 在 /etc/php5/fpm/conf.d/ 目录下添加一个名为 30-phalcon.ini 的文件, 内容如下:
extension=phalcon.so

# 必读提示二：php.ini必须修改cgi.fix_pathinfo=1
cgi.fix_pathinfo=1