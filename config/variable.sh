#!/bin/bash

# 定义变量，获得当前脚本的路路径
current_dir=$(pwd)

# 定义默认安装程序的下载路径
srcDir="/usr/local/src"

# 定义默认的PHP7.1的版本
defaultPHP71Version="7.1.13"

# 定义默认的PHP7.0的版本
defaultPHP70Version="7.0.27"

# 定义默认的PHP5.6的版本
defaultPHP56Version="5.6.33"

# 定义默认的Nginx的版本
defaultNginxVersion="1.12.2"

# 定义默认的Openresty的版本
defaultOpenrestyVersion="1.11.2.5"

# 定义默认的Tengine的版本
defaultTengineVersion="2.2.0"

# 定义默认安装的Docker Compose的版本
defaultDockerCompose="1.17.0"