项目名称：ltnmp，中文名字老太娘一键包

作者名称：文武双全

作者博客：http://www.jicker.cn

脚本功能：本脚本主要用于Debian7.5的web环境配置。

#脚本使用方法
将install.sh文件上传到服务器的任意目录，然后执行sh install.sh即可。tengine采用默认安装和默认配置，安装路径在/usr/local/。
更多Tengine的使用方法，请参考Tengine的官网http://tengine.taobao.org/。

#下面是重新安装的脚本，下载地址及安装指令：

wget http://www.jicker.cn/down/source/php56_debian75_product_install.sh

sh php56_debian75_product_install.sh

wget http://www.jicker.cn/down/source/php7_debian75_product_install.sh

sh php7_debian75_product_install.sh

wget http://www.jicker.cn/down/source/tengine_debian75_product_install.sh

sh tengine_debian75_product_install.sh

wget http://www.jicker.cn/down/source/tengine_debian75_proxy_install.sh

sh tengine_debian75_proxy_install.sh

常用debian命令：
检查编译后nginx文件的大小：ls -lh /usr/local/nginx/sbin/nginx