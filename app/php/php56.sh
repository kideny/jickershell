#!/bin/bash

install_php56() {

    #定义默认安装的php版本号
    defaultversion="5.6.30"

    #输出提示
    echo -e "\033[41;37m Please enter the php version, the default is: $(defaultversion)  < \033[0m"
    echo -e "\033[41;37m Example: $(defaultversion) \033[0m"

    #读取用户输入的defaultversion，如果defaultversion为空，则默认为defaultversion
    read -p " --Enter: " hostname
    if [ "$phpversion" = "" ]; then
        phpversion="$defaultversion"
    fi

    #对Debian系统Update
    apt-get update -y
    #对Debian系统Upgrade，-u参数可以罗列出需要升级的软件
    apt-get -u upgrade -y

    #安装PHP的依赖库
    apt-get install php5-curl freetype* php5-gd php5-mcrypt php5-common php-pear php5-imagick libpcre3 libpcre3-dev libtool openssl libxml2 libxml2-dev libmhash-dev libmcrypt-dev mcrypt curl libcurl3 libcurl4-gnutls-dev libjpeg8-dev libpng12-dev libbz2-dev libssl-dev libsslcommon2-dev pkg-config

    #删除安装软件的备份，释放硬盘空间
    apt-get clean
    #执行自动移出
    apt-get autoremove -y

    #停止nginx进程
    service nginx stop

    #进入Debian的源文件目录
    cd /usr/local/src

    #下载指定版本的PHP
    wget http://cn2.php.net/distributions/php-${phpversion}.tar.gz

    #解压缩
    tar zxvf php-${phpversion}.tar.gz

    #进入PHP源码的目录
    cd /usr/local/src/php-${phpversion}

    #配置并检查依赖
    ./configure --prefix=/usr/local/php56  --with-config-file-path=/usr/local/php56/etc --with-fpm-user=www-data --with-fpm-group=www-data --with-gd --with-freetype-dir --with-jpeg-dir  --with-mcrypt --with-mhash --with-openssl --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-mysql=mysqlnd --with-curl --with-iconv --with-zlib  --with-gettext --enable-inline-optimization --enable-ftp --enable-mbstring --enable-sockets --enable-xml --enable-fpm --enable-opcache  --enable-bcmath --enable-gd-native-ttf --enable-soap --enable-zip --disable-debug --disable-ipv6 --disable-rpath --disable-fileinfo

    #编译并且执行安装
    time make

    #执行make
    make install

    #在php5.6安装目录创建配置文件目录
    mkdir -p /usr/local/php56/etc

    #复制PHP的配置文件到配置文件目录
    cp /usr/local/src/php-${phpversion}/php.ini-production /usr/local/php56/etc/php.ini

    #开启Opcache
    #sed -i '/$/a zend_extension=opcache.so'  /usr/local/php56/etc/php.ini
    sed -i '/;opcache.enable=0/i\zend_extension=opcache.so' /usr/local/php56/etc/php.ini
    sed -i 's/;opcache.enable=0/opcache.enable=1/g' /usr/local/php56/etc/php.ini
    sed -i 's/;opcache.enable_cli=0/opcache.enable_cli=1/g' /usr/local/php56/etc/php.ini
    sed -i 's/;opcache.memory_consumption=64/opcache.memory_consumption=128/g' /usr/local/php56/etc/php.ini
    sed -i 's/;opcache.interned_strings_buffer=4/opcache.interned_strings_buffer=8/g' /usr/local/php56/etc/php.ini
    sed -i 's/;pcache.max_accelerated_files=2000/pcache.max_accelerated_files=4000/g' /usr/local/php56/etc/php.ini
    sed -i 's/;opcache.revalidate_freq=2/opcache.revalidate_freq=60/g' /usr/local/php56/etc/php.ini
    sed -i 's/;opcache.fast_shutdown=0/opcache.fast_shutdown=1/g' /usr/local/php56/etc/php.ini

    #进入PHP源码的目录
    cd /usr/local/src/php-${phpversion}/sapi/fpm

    #复制php5-fpm管理脚本到初始化启动目录
    cp init.d.php-fpm /etc/init.d/php5-fpm

    #复制站点的php5-fpm配置文件
    cp /usr/local/php56/etc/php-fpm.conf.default /usr/local/php56/etc/php-fpm.conf

    #给php5-fpm增加执行权限
    chmod +x /etc/init.d/php5-fpm

    #测试php5-fpm
    service php5-fpm configtest

    #如果测试没问题，启动php5-fpm
    service php5-fpm start

    #启动Nginx
    service  nginx start

    #安装成功的欢迎致辞！
    echo "PHP5.6 install chenggong!";

}
