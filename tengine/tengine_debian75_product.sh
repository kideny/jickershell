#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#定义servername
servername="www.jicker.cn"

#读取用户输入的hostname，如果hostname为空，则默认为servername
read -p " --Enter: " hostname
if [ "$hostname" = "" ]; then
	hostname="$servername"
fi

#检测是否root账户权限
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install LTNMP"
    exit 1
fi

#判定是否开启selinux，如果开启则关闭
if [ -s /etc/selinux/config ]; then
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
fi

#删除系统自带的时区文件
rm -rf /etc/localtime

#设置时区为上海
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

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

#修改默认的源然后upgrade
if [ -s /etc/apt/sources.list.bak ]; then
rm /etc/apt/sources.list -f
mv /etc/apt/sources.list.bak /etc/apt/sources.list
fi
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cat >> /etc/apt/sources.list<<EOF
deb http://mirrors.163.com/debian/ wheezy main
deb-src http://mirrors.163.com/debian/ wheezy main
deb http://security.debian.org/ wheezy/updates main
deb-src http://security.debian.org/ wheezy/updates main
deb http://packages.dotdeb.org stable all
deb-src http://packages.dotdeb.org stable all
deb http://mirrors.163.com/debian/ wheezy-updates main
deb-src http://mirrors.163.com/debian/ wheezy-updates main
EOF
apt-get clean
apt-get autoclean
rm /var/lib/apt/lists/* -vf
apt-get check
apt-get upgrade
apt-get update
apt-get autoremove -y
apt-get -fy install

#安装Tengine的依赖库
apt-get -y install libpcre3-dev zlib1g-dev libssl-dev libxml2-dev libgd2-xpm-dev libgeoip-dev

#删除安装软件的备份，释放硬盘空间
apt-get clean

#进入Debian的源文件目录
cd /usr/local/src

#下载指定版本的Tengine
wget http://tengine.taobao.org/download/tengine-2.1.2.tar.gz

#解压缩
tar zxvf tengine-2.1.2.tar.gz

#进入gcc文件的目录
cd /usr/local/src/tengine-2.1.2/auto/cc

#使用sed命令注释掉nginx编译文件中的debug
sed -i '/CFLAGS="$CFLAGS -g"/s/CFLAGS="$CFLAGS -g"/# CFLAGS="$CFLAGS -g"/g' gcc

#进入Tengine的目录
cd /usr/local/src/tengine-2.1.2

#配置并检查依赖
./configure --prefix=/usr/local/nginx --group=www-data --user=www-data  --with-http_stub_status_module --with-http_ssl_module --with-openssl=/usr/local/ssl --without-http-cache --without-mail_pop3_module --without-mail_imap_module  --without-mail_smtp_module

#编译并且执行安装
time make

#执行make
make install

#下载Tengine的控制脚本到初始化配置文件的目录
wget http://www.jicker.cn/down/source/nginx -O /etc/init.d/nginx

#给Tengine控制脚本添加执行权限
chmod +x /etc/init.d/nginx

#将Tengine控制脚本添加到自启动的列表
update-rc.d -f nginx defaults

#创建站点配置文件的目录
mkdir -p /usr/local/nginx/conf/vhost

#重新启动Tengine
service nginx start

#安装成功的欢迎致辞！
echo "Tengine install chenggong!";
