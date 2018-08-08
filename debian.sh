#!/bin/bash

#  Auther      Frank Kennedy Yuan
#  Website    http://www.jicker.cn
#  Company  http://www.loserhub.com

# 第一步：执行操作系统的一些预先处理的命令

# 加载预处理脚本
. script/provision.sh
# 执行操作系统预处理函数
provision

# 第二步：处理系统源

# 加载系统源处理脚本
. script/sources.sh
# 执行系统源处理的脚本
sources

#第三步: 对操作系统进行更新

# 加载更新脚本
. script/update.sh
# 执行操作系统更新的函数
update

# 第四步：加载定义变量
. config/variable.sh

# 第五步：加载安装脚本并选择要安装的组件

# 加载各种安装脚本
. apps/docker/install/docker.sh
. apps/docker/install/compose.sh
. apps/nginx/install/proxy.sh
. apps/nginx/install/product.sh
. apps/openresty/install/proxy.sh
. apps/openresty/install/product.sh
. apps/tengine/install/proxy.sh
. apps/tengine/install/product.sh
. apps/php/php56.sh
. apps/php/php7.sh
. apps/php/php71.sh
. apps/php/php72.sh

#第六步：安装应用

# 加载安装应用的脚本
. script/install.sh
# 执行程序安装的函数
install

# 最后一步：系统清理

# 加载系统清理的脚本
. script/clean.sh
# 执行清理函数
clear