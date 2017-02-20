#!/bin/bash

install_nginx_proxy() {

    #定义默认安装的php版本号
    nginxversion="1.11.4"

    #输出提示
    echo -e "\033[41;37m Please enter the nginx version, the default is: ${nginxversion}  < \033[0m"
    echo -e "\033[41;37m Example: ${nginxversion} \033[0m"

    #读取用户输入的nginxversion，如果nginxversion为空，则默认为nginxversion
    read -p " --Enter: " hostname
    if [ "$nginxversion" = "" ]; then
        nginxversion="$nginxversion"
    fi

    #卸载exim4邮件发送程序
    apt-get --purge remove exim4
    apt-get --purge remove exim4-base

    #对Debian系统Update
    apt-get update -y

    #对Debian系统Upgrade，-u参数可以罗列出需要升级的软件
    apt-get -u upgrade -y

    #安装nginx的依赖库
    apt-get install openssl libtool libssl-dev libperl-dev libpcre3 libpcre3-dev

    #移出debian自带的apache2
    apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common php5 php5-common php5-cgi php5-mysql php5-curl php5-gd

    #杀死所有apache2的进程
    killall apache2

    #删除安装软件的备份，释放硬盘空间
    apt-get clean

    #进入Debian的源文件目录
    cd ${srcDir}

    #下载指定版本的nginx
    wget http://nginx.org/download/nginx-${nginxversion}.tar.gz

    #解压缩
    tar zxvf nginx-${nginxversion}.tar.gz

    #进入gcc文件的目录
    cd ${srcDir}/nginx-${nginxversion}/auto/cc

    #使用sed命令注释掉nginx编译文件中的debug
    sed -i '/CFLAGS="$CFLAGS -g"/s/CFLAGS="$CFLAGS -g"/# CFLAGS="$CFLAGS -g"/g' gcc

    #进入nginx的目录
    cd ${srcDir}/nginx-${nginxversion}

    #配置并检查依赖
    ./configure --prefix=/usr/local/nginx --group=www-data --user=www-data  --with-http_stub_status_module --with-http_ssl_module --without-http-cache --without-mail_pop3_module --without-mail_imap_module  --without-mail_smtp_module

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
