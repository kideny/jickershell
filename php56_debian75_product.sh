#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 检测是否是root账户权限
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install ltnmp"
    exit 1
fi

#对Debian系统Update
apt-get update -y

#对Debian系统Upgrade
apt-get -u upgrade -y

#安装PHP5.6的依赖库
apt-get install php5-fpm php5-curl freetype* php5-gd php5-mcrypt php5-common php-pear php5-imagick libpcre3 libpcre3-dev libtool openssl libxml2 libxml2-dev libmhash-dev libmcrypt-dev mcrypt curl libbz2-dev libssl-dev libsslcommon2-dev

#删除安装软件的备份，释放硬盘空间
apt-get clean

#停止nginx进程
service nginx stop

#进入Debian的源文件目录
cd /usr/local/src

#下载指定版本的PHP7
wget http://cn2.php.net/distributions/php-5.6.19.tar.gz

#解压缩
tar zxvf php-5.6.19.tar.gz

#进入PHP7源码的目录
cd /usr/local/src/php-5.6.19

#配置并检查依赖
./configure --prefix=/usr/local/php56  --with-config-file-path=/usr/local/php56/etc --with-fpm-user=www-data --with-fpm-group=www-data --with-gd --with-freetype --with-jpeg  --with-mcrypt --with-mhash --with-openssl --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-mysql=mysqlnd --with-curl --with-iconv --with-zlib  --with-gettext --enable-inline-optimization --enable-ftp --enable-mbstring --enable-sockets --enable-xml --enable-fpm --enable-opcache  --enable-bcmath --enable-gd-native-ttf --enable-soap --enable-zip --disable-debug --disable-ipv6 --disable-rpath --disable-fileinfo

#编译并且执行安装
time make

#执行make
make install

#开启Opcache
sed -i '/$/a zend_extension=opcache.so'  /usr/local/php56/lib/php.ini

#复制PHP7的配置文件到配置文件目录
cp /usr/local/src/php-5.6.19/php.ini-production /usr/local/php7/lib/php.ini

#进入PHP7源码的目录
cd /usr/local/src/php-5.6.19/sapi/fpm

#复制php7-fpm管理脚本到初始化启动目录
cp /usr/local/php/etc/php-fpm.conf.default /etc/init.d/php5-fpm

#复制站点的PHP7-fpm配置文件
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf

#给php7-fpm增加执行权限
chmod +x /etc/init.d/php5-fpm

#测试php7-fpm
service php7-fpm configtest

#如果测试没问题，启动php7-fpm
service php7-fpm start

#启动Nginx
service  nginx start

#安装成功的欢迎致辞！
echo "PHP7 install chenggong!";
