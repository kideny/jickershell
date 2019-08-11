#!/bin/bash

# Nginx Version  https://nginx.org/en/download.html
# Openresty Version  https://openresty.org/cn/download.html
# Docker Version  https://www.docker.com/community-edition#/download
# Docker Debian   https://docs.docker.com/install/linux/docker-ce/debian/
# Docker Ubuntu   https://docs.docker.com/install/linux/docker-ce/ubuntu/

# 定义变量，获得当前脚本的路路径
current_dir=$(pwd)

# 定义默认安装程序的下载路径
srcDir="/usr/local/src"

# 定义默认的Phalcon的版本  
defualtPhalconVersion="3.4.1"

# PHP Version    http://www.php.net/
defaultPHP70Version="7.3.3"
defaultPHP72Version="7.2.21"
defaultPHP71Version="7.1.31"
defaultPHP56Version="5.6.40"

# 定义默认的Nginx的版本 http://nginx.org/en/download.html
defaultNginxVersion="1.16.0"

# 定义默认的Openresty的版本 http://openresty.org/cn/download.html
defaultOpenrestyVersion="1.15.8.1"

# 定义默认安装的Docker Compose的版本
defaultDockerCompose="1.21.2"