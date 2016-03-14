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

#对Debian系统Upgrade
apt-get upgrade -y

#安装PHP7的依赖库
apt-get install php5-fpm php5-curl php5-gd php5-mcrypt php5-common php-pear php5-imagick

#移出debian自带的apache2及PHP5
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common

#删除安装软件的备份，释放硬盘空间
apt-get clean

#杀死所有apache2的进程
killall apache2

#进入Debian的源文件目录
cd /usr/local/src

#下载指定版本的PHP7
wget http://cn2.php.net/distributions/php-5.6.19.tar.gz

#解压缩
tar zxvf php-5.6.19.tar.gz

#进入PHP7源码的目录
cd /usr/local/src/php-5.6.19

#配置并检查依赖
./configure --prefix=/usr/local/php56  --with-config-file-path=/usr/local/php7/etc --with-fpm-user=www-data --with-fpm-group=www-data --with-gd --with-freetype --with-jpeg --with-mcrypt --with-mhash --with-openssl --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-curl --with-iconv --with-zlib  --with-gettext --enable-inline-optimization --enable-mbstring --enable-sockets --enable-fpm --enable-opcache --enable-gd-native-ttf --disable-debug --disable-ipv6

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

#安装成功的欢迎致辞！
echo "PHP7 install chenggong!";
