#!/bin/bash

# search mysql process and count num
process=`ps -ef |grep mysql|grep -v grep |wc -l`

#
if [ $process -ne 2 ]
    then
        service mysqld  restart
    else
        echo "MySQL is running!"
fi

#search current mysql process and count num
mysql=`ps -ef |grep mysql|grep -v grep |wc -l`

if [ $mysql -ne 2 ]
    then
        service mysqld  restart
    else
        echo "MySQL restart sucess!"
fi
