#!/bin/bash
# PHP Version    http://www.php.net/
# Nginx Version  https://nginx.org/en/download.html
# Openresty Version  https://openresty.org/cn/download.html
# Docker Version  https://www.docker.com/community-edition#/download

# 定义变量，获得当前脚本的路路径
current_dir=$(pwd)

# 定义默认安装程序的下载路径
srcDir="/usr/local/src"

# 定义默认的PHP7.2的版本  
defaultPHP72Version="7.2.8"

# 定义默认的PHP7.1的版本
defaultPHP71Version="7.1.20"

# 定义默认的PHP7.0的版本
defaultPHP70Version="7.0.31"

# 定义默认的PHP5.6的版本
defaultPHP56Version="5.6.36"

# 定义默认的Nginx的版本
defaultNginxVersion="1.14.0"

# 定义默认的Openresty的版本
defaultOpenrestyVersion="1.13.6.2"

# 定义默认的Tengine的版本
defaultTengineVersion="2.2.1"

# 定义默认安装的Docker Compose的版本
defaultDockerCompose="1.21.2"