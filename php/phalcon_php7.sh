#!/bin/bash

#安装phalcon所需依赖
apt-get install - y libpcre3-dev gcc make autoconf git

#创建phalcon安装目录
mkdir /usr/local/phalcon  & cd /usr/local/phalcon

#git克隆phalcon源码
git clone --depth=1 git://github.com/phalcon/cphalcon.git

#进入安装目录，执行安装程序
cd cphalcon/build & ./install

#修改php7文件，开启phalcon扩展
sed -i '/$/a extension=phalcon.so'  /usr/local/php7/lib/php.ini

#重新启动php-fpm
service php7-fpm restart
