英文名称：DDFH

中文名称：Debian大法好

作者名称：袁斌

作者博客：http://www.jicker.cn

项目简介：主要用于Debian操作系统的web环境配置。

#克隆脚本文件到服务器

使用cd  /usr/local/src 命令进入源码下载目录。

使用 git clone https://git.oschina.net/jicker/DDFH.git 命令把源码从OSC GIT下载到服务器。

#下面是重新安装的脚本，下载地址及安装指令：

安装php5.6的命令
sh php56_debian75_product_install.sh

安装php7的命令
sh php7_debian75_product_install.sh

生产服务器安装tengine的命令
sh tengine_debian75_product_install.sh

反向代理服务器安装tengine的命令
sh tengine_debian75_proxy_install.sh

常用debian命令：
检查编译后nginx文件的大小：ls -lh /usr/local/nginx/sbin/nginx