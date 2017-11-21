#!/bin/bash

install_openresty_product() {

    #定义默认安装的php版本号
    defaultVersion="1.11.2.5"

    #输出提示
    echo -e "\033[41;37m Please enter the nginx version, the default is: ${defaultVersion}  < \033[0m"
    echo -e "\033[41;37m Example: ${defaultVersion} \033[0m"

    #读取用户输入的openrestyVersion，如果openrestyVersion为空，则默认为${defaultVersion}
    read -p " --Enter: " hostname
    if [ "$defaultVersion" = "" ]; then
        openrestyVersion="$defaultVersion"
    fi

    #定义servername
    servername="wwwjickercn"

    #输出提示
    echo -e "\033[41;37m Please enter the website, the default is: $(servername)  < \033[0m"
    echo -e "\033[41;37m Example: $(servername) \033[0m"

    #读取用户输入的hostname，如果hostname为空，则默认为servername
    read -p " --Enter: " hostname
    if [ "$hostname" = "" ]; then
        hostname="$servername"
    fi

    #安装Tengine的依赖库
    apt-get -y install 
        libpcre3-dev \
        zlib1g-dev \
        libssl-dev \
        libxml2-dev \
        libgd2-xpm-dev \
        libgeoip-dev \
        libjpeg62-turbo-dev \
        libreadline-dev \
        libncurses5-dev \
        build-essential \

    #进入Debian的源文件目录
    cd ${srcDir}

    #下载指定版本的OpenResty
    wget https://openresty.org/download/openresty-${openrestyVersion}.tar.gz

    #解压缩
    tar zxvf nginx-${openrestyVersion}.tar.gz

    #进入gcc文件的目录
    cd ${srcDir}/nginx-${openrestyVersion}/auto/cc

    #使用sed命令注释掉nginx编译文件中的debug
    sed -i '/CFLAGS="$CFLAGS -g"/s/CFLAGS="$CFLAGS -g"/# CFLAGS="$CFLAGS -g"/g' gcc

    #进入nginx的目录
    cd ${srcDir}/nginx-${openrestyVersion}

    #配置并检查依赖
    ./configure --prefix=/usr/local/nginx --group=www-data --user=www-data --with-luajit --with-http_stub_status_module --with-http_ssl_module --without-http-cache --without-mail_pop3_module --without-mail_imap_module  --without-mail_smtp_module

    #编译并且执行安装
    time make

    #执行make
    make install

    #复制nginx的控制脚本到初始化配置文件的目录
    cp ${current_dir}/nginx/nginx /etc/init.d/nginx

    #给nginx控制脚本添加执行权限
    chmod +x /etc/init.d/nginx

    #将nginx控制脚本添加到自启动的列表
    update-rc.d -f nginx defaults

    #创建站点配置文件的目录
    mkdir -p /usr/local/nginx/conf/vhost

    #复制默认站点配置文件到站点配置文件目录
    cp ${current_dir}/conf/nginx/default.conf /usr/local/nginx/conf/vhost/${hostname}.conf

    #重新启动nginx
    service nginx start

    #安装成功的欢迎致辞！
    echo "nginx install chenggong!";

}
