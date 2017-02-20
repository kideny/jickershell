#!/bin/bash

install_nginx_product() {

    #定义默认安装的php版本号
    defaultVersion="1.11.4"

    #输出提示
    echo -e "\033[41;37m Please enter the nginx version, the default is: ${defaultVersion}  < \033[0m"
    echo -e "\033[41;37m Example: ${defaultVersion} \033[0m"

    #读取用户输入的nginxVersion，如果nginxVersion为空，则默认为defaultVersion
    read -p " --Enter: " hostname
    if [ "$nginxVersion" = "" ]; then
        $nginxVersion="$defaultVersion"
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

    #安装基础环境
    apt-get install -y gcc g++ make wget htop

    #先卸载exim4及系统自带的apache2
    apt-get remove -y exim4 apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common php5 php5-common php5-cgi php5-mysql php5-curl php5-gd

    #杀死所有apache2的进程
    killall apache2

    #remove不需要的debian系统自带程序
    apt-get update
    apt-get autoremove -y
    apt-get -fy install
    dpkg -P libmysqlclient15off libmysqlclient15-dev mysql-common
    dpkg -P apache2 apache2-doc apache2-mpm-prefork apache2-utils apache2.2-common

    #debian系统的update
    apt-get autoremove -y
    apt-get -fy install
    dpkg -P mysql-server mysql-client
    dpkg -P nginx php5-fpm php5-gd php5-mysql
    dpkg -l |grep nginx | awk -F " " '{print $2}' | xargs dpkg -P
    apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common
    apt-get check
    apt-get upgrade
    apt-get update
    apt-get autoremove -y
    apt-get -fy install

    #安装nginx的依赖库
    apt-get -y install libpcre3-dev zlib1g-dev libssl-dev libxml2-dev libgd2-xpm-dev libgeoip-dev

    #删除安装软件的备份，释放硬盘空间
    apt-get clean

    #进入Debian的源文件目录
    cd ${srcDir}

    #下载指定版本的nginx
    wget http://nginx.org/download/nginx-${nginxVersion}.tar.gz

    #解压缩
    tar zxvf nginx-${nginxVersion}.tar.gz

    #进入gcc文件的目录
    cd ${srcDir}/nginx-${nginxVersion}/auto/cc

    #使用sed命令注释掉nginx编译文件中的debug
    sed -i '/CFLAGS="$CFLAGS -g"/s/CFLAGS="$CFLAGS -g"/# CFLAGS="$CFLAGS -g"/g' gcc

    #进入nginx的目录
    cd ${srcDir}/nginx-${nginxVersion}

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
