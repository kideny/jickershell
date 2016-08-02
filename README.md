英文名称：DDFH

中文名称：Debian大法好

作者名称：袁斌

作者博客：http://www.jicker.cn

项目简介：主要用于Debian操作系统的web环境配置。

#脚本使用方法
将install.sh文件上传到服务器的任意目录，然后执行sh install.sh即可。tengine采用默认安装和默认配置，安装路径在/usr/local/。
更多Tengine的使用方法，请参考Tengine的官网http://tengine.taobao.org/。

#下面是重新安装的脚本，下载地址及安装指令：

#安装php5.6的命令

sh php56_debian75_product_install.sh

#安装php7的命令

sh php7_debian75_product_install.sh

#生产服务器安装tengine的命令

sh tengine_debian75_product_install.sh

#反向代理服务器安装tengine的命令

sh tengine_debian75_proxy_install.sh

常用debian命令：
检查编译后nginx文件的大小：ls -lh /usr/local/nginx/sbin/nginx