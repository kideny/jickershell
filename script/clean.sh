#!/bin/bash

clear() {
    #执行自动清理
    apt-get clean && apt-get autoclean

    #执行自动移出
    apt-get autoremove -y

    # rm /var/lib/apt/lists/* -vf

    #rm -rf ${srcDir}/*.*
    echo "Install Sucess! Debian DaFa GuoRan Hao ,HaHaHa!"
}

