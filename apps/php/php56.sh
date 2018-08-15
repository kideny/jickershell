#!/bin/bash

install_php56() {

    #定义默认安装的php版本号
    defaultVersion=${defaultPHP56Version}

    #定义进程的名称
    procName="php-fpm5.6"

    #输出提示
    echo -e "\033[41;37m Please enter the php version, the default is: ${defaultVersion}  < \033[0m"
    echo -e "\033[41;37m Example: ${defaultVersion} \033[0m"

    #读取用户输入的defaultversion，
    read -p " --Enter: " hostname

    #如果defaultversion为空，则默认为defaultversion
    if [ "$phpversion" = "" ]; then
        phpversion="$defaultVersion"
    fi

    #安装PHP的依赖库
    apt-get install \
        php5-curl \
        freetype* \
        php5-gd \
        php5-mcrypt \
        php5-common \
        php-pear \
        php5-imagick \
        libpcre3 \
        libpcre3-dev \
        libtool \
        libxml2 \
        libxml2-dev \
        libmhash-dev \
        libmcrypt-dev \
        mcrypt \
        libcurl3 \
        libcurl4-gnutls-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libbz2-dev \
        libssl-dev \
        libsslcommon2-dev

    #停止nginx进程
    service nginx stop

    #进入Debian的源文件目录
    cd ${srcDir}

    #下载指定版本的PHP
    wget http://cn2.php.net/distributions/php-${phpversion}.tar.gz

    #解压缩
    tar zxvf php-${phpversion}.tar.gz

    #进入PHP源码的目录
    cd ${srcDir}/php-${phpversion}

    #配置并检查依赖
    ./configure \
        --prefix=/usr/local/php56  \
        --with-config-file-path=/usr/local/php56/etc \
        --with-fpm-user=www-data \
        --with-fpm-group=www-data \
        --with-gd \
        --with-freetype-dir \
        --with-jpeg-dir  \
        --with-mcrypt \
        --with-mhash \
        --with-openssl \
        --with-pdo-mysql=mysqlnd \
        --with-mysqli=mysqlnd \
        --with-mysql=mysqlnd \
        --with-curl \
        --with-iconv \
        --with-zlib  \
        --with-gettext \
        --enable-inline-optimization \
        --enable-ftp \
        --enable-mbstring \
        --enable-sockets \
        --enable-xml \
        --enable-fpm \
        --enable-opcache  \
        --enable-gd-native-ttf \
        --enable-soap \
        --enable-zip \
        --disable-debug \
        --disable-ipv6 \
        --disable-rpath \
        --disable-fileinfo

    #编译并且执行安装
    time make

    #执行make
    make install

    #在php5.6安装目录创建配置文件目录
    mkdir -p /usr/local/php56/etc

    #复制PHP的配置文件到配置文件目录
    cp ${srcDir}/php-${phpversion}/php.ini-production  /usr/local/php56/etc/php.ini

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
    cd ${srcDir}/php-${phpversion}/sapi/fpm

    #复制php-fpm5.6管理脚本到初始化启动目录
    cp init.d.php-fpm /etc/init.d/php5-fpm

    #复制站点的php-fpm5.6配置文件
    cp /usr/local/php56/etc/php-fpm.conf.default /usr/local/php56/etc/php-fpm.conf

    #给php-fpm5.6增加执行权限
    chmod +x /etc/init.d/${procName}

    #测试php-fpm5.6
    service ${procName} configtest

    #如果测试没问题，启动php-fpm5.6
    service ${procName} start

    #启动Nginx
    service nginx start

    #检查nginx的进程是否存在
    process = pidof ${procName}

    if [ "${process}" = "" ]; 
        #安装失败的欢迎致辞！
        echo "php${phpVersion} install fail!";
    then
        #安装成功的欢迎致辞！
        echo "php${phpVersion} install success!";
    fi
    # 执行php安装扩展的函数
    install_ext
}

# php安装扩展的函数
install_ext(){
    echo "php${phpVersion} install Start!";
    install_phalcon
    echo "php${phpVersion} install End!";
}

# 安装phalcon扩展
install_phalcon(){
    # 进入源码下载目录
    cd  ${phpDir}

    # git克隆phalcon源码
    git  clone  git://github.com/phalcon/cphalcon.git

    # 进入安装目录，执行安装程序
    cd  cphalcon/build  &&  ./install

    # 修改php7配置文件，开启phalcon扩展
    echo  "zend_extension=phalcon.so"  >>  ${phpDir}/etc/php.ini
}