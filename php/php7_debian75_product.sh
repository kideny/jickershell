#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 检测是否是root账户权限
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install ltnmp"
    exit 1
fi

#删除系统自带的时区文件
rm -rf /etc/localtime

#设置时区为上海
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#对Debian系统Update
apt-get update -y

#对Debian系统Upgrade，-u参数可以罗列出需要升级的软件
apt-get -u upgrade -y

#安装PHP7的依赖库
apt-get install make libxml2-dev libcurl4-openssl-dev libjpeg8-dev libpng12-dev libxpm-dev libmysqlclient-dev libicu-dev libfreetype6-dev libxslt1-dev libssl-dev libbz2-dev libgmp-dev libmcrypt-dev libpspell-dev librecode-dev libpq-dev

#移出Debian自带的apache2及PHP5
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common

#删除安装软件的备份，释放硬盘空间
apt-get clean

#杀死所有apache2的进程
killall apache2

#停止nginx进程
service nginx stop

#进入Debian的源文件目录
cd /usr/local/src

#下载指定版本的PHP7
wget http://cn2.php.net/distributions/php-7.0.5.tar.gz

#解压缩
tar zxvf php-7.0.5.tar.gz

#进入PHP7源码的目录
cd /usr/local/src/php-7.0.5

#配置并检查依赖
./configure --prefix=/usr/local/php7 --with-zlib-dir --with-config-file-path=/usr/local/php7/etc --with-fpm-user=www-data --with-fpm-group=www-data --with-gd --with-freetype-dir=DIR --with-jpeg-dir=DIR --with-png-dir=DIR --with-mcrypt --with-mhash --with-openssl --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-curl --with-iconv --with-gettext --with-bz2 --with-zlib --enable-bcmath --enable-inline-optimization --enable-mbstring --enable-sockets --enable-session --enable-fpm --enable-opcache --enable-pdo --enable-gd-native-ttf --enable-zip --disable-ipv6 --disable-rpath

#编译并且执行安装
time make

#执行make
make install

#复制PHP7的配置文件到配置文件目录
cp /usr/local/src/php-7.0.5/php.ini-production /usr/local/php7/lib/php.ini

#开启Opcache
sed -i '/$/a zend_extension=opcache.so'  /usr/local/php7/lib/php.ini

#进入PHP7源码的目录
cd /usr/local/src/php-7.0.5/sapi/fpm

#复制php7-fpm管理脚本到初始化启动目录
cp /usr/local/php/etc/php-fpm.conf.default /etc/init.d/php7-fpm

#复制站点的PHP7-fpm配置文件
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf

#给php7-fpm增加执行权限
chmod +x /etc/init.d/php7-fpm

#现在尝试启动php7的配置测试看看是否有误
service php7-fpm configtest

#如果测试没问题，启动php7-fpm
service php7-fpm start

#启动Nginx
service nginx start

#安装成功的欢迎致辞！
echo "PHP7 install chenggong!";
