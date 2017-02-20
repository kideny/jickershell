#!/bin/bash

install_php7() {

    #定义默认安装程序的下载路径
    srcDir="/usr/local/src"

    #输出提示，用户可以自定义自己要安装的版本好，覆盖默认安装的版本好
    echo -e "\033[41;37m Please enter the php version, the default is: 7.0.16  < \033[0m"
    echo -e "\033[41;37m Example: 7.0.16 \033[0m"

    #读取用户输入的phpVersion
    read -p " --Enter: " phpVersion

    #如果用户未填写，则默认为phpVersion
    if [ "$phpVersion" = "" ]; then
        $phpVersion="7.0.16"
    fi

    #定义默认安装的php路径
    phpDir="$(phpDir)"

    #输出提示，用户可以自定义自己要安装的路径，覆盖默认定义的安装路径
    echo -e "\033[41;37m Please enter the install dir, the default dir is: $(phpDir)  < \033[0m"
    echo -e "\033[41;37m Example: $(phpDir) \033[0m"

    #读取用户输入的phpDir
    read -p " --Enter: " phpDir

    #如果用户未填写，则默认为"$(phpDir)1",
    if [ "$phpDir" = "" ]; then
        $phpDir="$(phpDir)"
    fi

    #对Debian系统Update
    apt-get update -y

    #对Debian系统Upgrade，-u参数可以罗列出需要升级的软件
    apt-get -u upgrade -y

    #安装PHP7的依赖库
    apt-get install make libxml2-dev libcurl4-openssl-dev libjpeg8-dev libpng12-dev libxpm-dev libmysqlclient-dev libicu-dev libfreetype6-dev libxslt1-dev libssl-dev libbz2-dev libgmp-dev libmcrypt-dev libpspell-dev librecode-dev libpq-dev libpcre3-dev gcc make

    #删除安装软件的备份，释放硬盘空间
    apt-get clean

    #执行自动移出
    apt-get autoremove -y

    #停止nginx进程
    service nginx stop

    #进入Debian的源文件目录
    cd $(srcDir)

    #下载指定版本的PHP7
    wget http://cn2.php.net/distributions/php-${phpVersion}.tar.gz

    #解压缩
    tar zxvf php-${phpVersion}.tar.gz

    #进入PHP7源码的目录
    cd $(srcDir)/php-${phpVersion}

    #配置并检查依赖
    ./configure --prefix=$(phpDir) --with-zlib-dir --with-config-file-path=$(phpDir)/etc --with-fpm-user=www-data --with-fpm-group=www-data --with-gd --with-freetype-dir=DIR --with-jpeg-dir=DIR --with-png-dir=DIR --with-mcrypt --with-mhash --with-openssl --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-curl --with-iconv --with-gettext --with-bz2 --with-zlib --enable-bcmath --enable-inline-optimization --enable-mbstring --enable-sockets --enable-session --enable-fpm --enable-opcache --enable-pdo --enable-gd-native-ttf --enable-zip --enable-xml --disable-ipv6 --disable-rpath

    #编译并且执行安装
    time make && make install

    #复制PHP7的配置文件到配置文件目录
    cp $(srcDir)/php-${phpVersion}/php.ini-production  $(phpDir)/etc/php.ini

    #开启Opcache
    #sed -i '/$/a zend_extension=opcache.so'  $(phpDir)/etc/php.ini

    #进入PHP7源码的目录
    cd $(srcDir)/php-${phpVersion}/sapi/fpm

    #复制php7-fpm管理脚本到操作系统初始化启动目录
    cp $(srcDir)/php-${phpVersion}/sapi/fpm/init.d.php-fpm  /etc/init.d/php7-fpm

    #复制站点的PHP7-fpm默认配置文件
    cp $(phpDir)/etc/php-fpm.conf.default  $(phpDir)/etc/php-fpm.conf

    #复制站点的PHP7-fpm站点配置文件
    cp $(phpDir)/etc/php-fpm.d/www.conf.default  $(phpDir)/etc/php-fpm.d/www.conf

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

}
