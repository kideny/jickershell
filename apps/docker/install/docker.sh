#!/bin/bash

# 官方网站 https://docs.docker.com/engine/installation/linux/docker-ce/debian/#set-up-the-repository

# OS requirements
#
#    Buster 10 (Docker CE 17.11 Edge only)
#    Stretch 9 (stable) / Raspbian Stretch
#    Jessie 8 (LTS) / Raspbian Jessie
#    Wheezy 7.7 (LTS)
#

install__docker() {
    # Uninstall old versions
    sudo apt-get remove \
        docker \
        docker.io \
        docker-common \
        docker-selinux \
        docker-engine \
        docker.io

    ## Install the latest version of Docker CE
    sudo apt-get install docker-ce

    ## Start Docker
    sudo systemctl start docker
}