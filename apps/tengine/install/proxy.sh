#!/bin/bash

install_tengine_proxy() {

    #安装Tengine的依赖库
    apt-get install \
        libtool \
        libssl-dev \
        libperl-dev \
        libpcre3 \
        libpcre3-dev

    #定义默认安装的php版本号
    defaultVersion=${defaultTengineVersion}

    #输出提示
    echo -e "\033[41;37m Please enter the tengine version, the default is: ${defaultVersion}  < \033[0m"
    echo -e "\033[41;37m Example: ${defaultVersion} \033[0m"

    #读取用户输入的tengineVersion，如果tengineVersion为空，则默认为tengineVersion
    read -p " --Enter: " tengineVersion
    
    if [ "${tengineVersion}" = "" ]; then
        tengineVersion="$defaultVersion"
    fi

    #进入Debian的源文件目录
    cd ${srcDir}

    #下载指定版本的Tengine
    wget http://tengine.taobao.org/download/tengine-${tengineVersion}.tar.gz

    #解压缩
    tar zxvf tengine-${tengineVersion}.tar.gz

    #进入gcc文件的目录
    cd ${srcDir}/tengine-${tengineVersion}/auto/cc

    #使用sed命令注释掉nginx编译文件中的debug
    sed -i '/CFLAGS="$CFLAGS -g"/s/CFLAGS="$CFLAGS -g"/# CFLAGS="$CFLAGS -g"/g' gcc

    #进入Tengine的目录
    cd ${srcDir}/tengine-${tengineVersion}

    #配置并检查依赖
    ./configure \
        --prefix=/usr/local/nginx \
        --group=www-data \
        --user=www-data \
        --with-http_stub_status_module \
        --with-http_ssl_module \
        --without-http-cache \
        --without-mail_pop3_module \
        --without-mail_imap_module \
        --without-mail_smtp_module

    #编译并且执行安装
    time make

    #执行make
    make install

    #复制Tengine的控制脚本到初始化配置文件的目录
    cp ${current_dir}/apps/tengine/init.d/nginx   /etc/init.d/nginx

    #给Tengine控制脚本添加执行权限
    chmod +x /etc/init.d/nginx

    #将Tengine控制脚本添加到自启动的列表
    update-rc.d -f nginx defaults

    #创建站点配置文件的目录
    mkdir -p /usr/local/nginx/conf/vhost

    #复制默认站点配置文件到站点配置文件目录
    cp ${current_dir}/apps/tengine/conf/default.conf    /usr/local/nginx/conf/vhost/${hostname}.conf
    cp ${current_dir}/apps/tengine/conf/nginx.conf    /usr/local/nginx/conf/nginx.conf

    #重新启动Tengine
    service nginx start

    #检查nginx的进程是否存在
    process = pidof nginx

    if [ "${process}" = "" ]; 
        #安装失败的欢迎致辞！
        echo "tengine${nginxVersion} install fail!";
    then
        #安装成功的欢迎致辞！
        echo "tengine${nginxVersion} install success!";
    fi
}
