#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 检测是否是root账户权限
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install ltnmp"
    exit 1
fi

#删除vsftp的安装脚本
rm /usr/local/src/vsftp_debian75_product.sh

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
