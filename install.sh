#删除系统自带的时区文件
rm -rf /etc/localtime

#设置时区为上海
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#对Debian系统Update
apt-get update

#对Debian系统Upgrade
apt-get upgrade

#安装Tengine的依赖库
apt-get install openssl libtool libssl-dev libperl-dev libpcre3 libpcre3-dev

#移出debian自带的apache2
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common php5 php5-common php5-cgi php5-mysql php5-curl php5-gd

#杀死所有apache2的进程
killall apache2

#进入Debian的源文件目录
cd /usr/local/src

#下载指定版本的Tengine
wget http://tengine.taobao.org/download/tengine-2.1.2.tar.gz

#解压缩
tar zxvf tengine-2.1.2.tar.gz

#进入Tengine的目录
cd tengine-2.1.2

#配置并检查依赖
./configure --prefix=/usr/local/nginx --group=www-data --user=www-data  --with-http_stub_status_module --with-http_ssl_module --without-http-cache

#编译并且执行安装
make & make install

#下载Tengine的控制脚本到初始化配置文件的目录
wget http://www.jicker.cn/down/source/nginx -O /etc/init.d/nginx

#给Tengine控制脚本添加执行权限
chmod +x /etc/init.d/nginx

#将Tengine控制脚本添加到自启动的列表
update-rc.d -f nginx defaults

#创建站点配置文件的目录
mkdir -p /usr/local/nginx/conf/vhost

#重新启动Tengine
service nginx restart

#安装成功的欢迎致辞！
echo "Tengine install chenggong!";
