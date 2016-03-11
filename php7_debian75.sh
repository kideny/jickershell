#删除系统自带的时区文件
rm -rf /etc/localtime

#设置时区为上海
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#对Debian系统Update
apt-get update -y

#对Debian系统Upgrade
apt-get upgrade -y

#安装PHP7的依赖库
apt-get install

#移出debian自带的apache2及PHP5
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common php5 php5-common php5-cgi php5-mysql php5-curl php5-gd

#删除安装软件的备份，释放硬盘空间
apt-get clean

#杀死所有apache2的进程
killall apache2

#进入Debian的源文件目录
cd /usr/local/src

#下载指定版本的PHP7
wget http://cn2.php.net/distributions/php-7.0.4.tar.gz

#解压缩
tar zxvf php-7.0.4.tar.gz

#进入Tengine的目录
cd /usr/local/src/php-7.0.4

#配置并检查依赖
./configure --prefix=/usr/local/php7 --with-fpm-user=www-data --with-fpm-group=www-data --with-gd --with-mcrypt --with-openssl --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-curl --with-iconv --with-zlib --enable-inline-optimization --enable-mbstring --enable-fpm --enable-opcache --disable-debug --disable-ipv6

#编译并且执行安装
time make

#执行make
make install

#下载PHP7的控制脚本到初始化配置文件的目录
wget http://www.jicker.cn/down/source/nginx -O /etc/init.d/nginx

#给PHP7控制脚本添加执行权限
chmod +x /etc/init.d/nginx

#将PHP7控制脚本添加到自启动的列表
update-rc.d -f nginx defaults

#创建站点配置文件的目录
mkdir -p /usr/local/nginx/conf/vhost

#重新启动php-fpm
service php7-fpm configtest

#安装成功的欢迎致辞！
echo "PHP7 install chenggong!";
