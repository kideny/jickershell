#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 检测是否是root账户权限
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install ltnmp"
    exit 1
fi

#删除系统自带的时区文件
rm -rf /etc/localtime

#设置时区为上海
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#卸载exim4
apt-get remove -y exim4

#对Debian系统Update
apt-get update -y

#对Debian系统Upgrade，-u参数可以罗列出需要升级的软件
apt-get -u upgrade -y

#安装Tengine的依赖库
apt-get install vsftp

#重新启动Tengine
service vsftp start

#安装成功的欢迎致辞！
echo "Tengine install chenggong!";
