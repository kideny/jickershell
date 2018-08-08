#!/bin/bash

clean() {
    #执行自动移出
    apt-get autoremove -y

    #执行自动清理
    apt-get clean && apt-get autoclean

    # rm /var/lib/apt/lists/* -vf

    #rm -rf ${srcDir}/*.*
    echo "Clean Sucess! Debian DaFa GuoRan Hao ,HaHaHa!"
}
