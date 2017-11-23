#!/bin/bash

# https://docs.docker.com/compose/install/#install-compose

install__compose() {

    # Run this command to download the latest version of Docker Compose:
    sudo curl -L https://github.com/docker/compose/releases/download/${defaultDockerCompose}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

    # Apply executable permissions to the binary:
    sudo chmod +x /usr/local/bin/docker-compose

    #检查nginx的进程是否存在
    dockerComposeVersion = $(docker-compose -v)

    if [ "${dockerComposeVersion}" = "" ]; 
        #安装失败的欢迎致辞！
        echo "Docker-Compose install fail!";
    then
        #安装成功的欢迎致辞！
        echo "Docker-Compose install success!";
    fi
}