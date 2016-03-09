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
./configure --prefix=/usr/local/nginx --group=www-data --user=www-data

#编译并且执行安装
make & make install

