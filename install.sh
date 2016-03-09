#对Debian系统Update
apt-get update

#安装Tengine的依赖库
apt-get install pcre-devel openssl openssl-devel

#进入Debian的源文件目录
cd /usr/local/src

#下载指定版本的Tengine
wget http://tengine.taobao.org/download/tengine-2.1.2.tar.gz

#解压缩
tar zxvf tengine-2.1.2.tar.gz

#进入Tengine的目录
cd tengine-2.1.2

#配置并检查依赖
./configure --prefix=/usr/local/nginx --group=www-data --user=www-data  --with-http_stub_status_module --with-http_ssl_module

#编译并且执行安装
make & make install

#下载Tengine的控制脚本到初始化配置文件的目录
wget http://www.jicker.cn/down/source/nginx -O /etc/init.d/nginx

#给Tengine控制脚本添加执行权限
chmod +x /etc/init.d/nginx

#重新启动Tengine
service nginx restart

#安装成功的欢迎致辞！
echo "Tengine install chenggong!";
