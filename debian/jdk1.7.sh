#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

//删除系统自带的openjdk及其配置文件
apt-get purge openjdk*

//进入src目录
cd /usr/local/src

//下载java1.7
wget http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz

//创建java7目录
mkdir /usr/local/java7

//复制压缩包到java7目录
cp -r /usr/local/src/jdk-7u79-linux-x64.tar.gz /usr/local/java7

cd /usr/local/java7

//解压缩
tar -xf jdk-7u79-linux-x64.tar.gz
