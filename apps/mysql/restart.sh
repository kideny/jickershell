#!/bin/bash

# search mysql process and count num
process=`ps -ef | grep mysql | grep -v grep |wc -l`

#
if [ $process -ne 2 ]
    then
        service mysqld  restart
        echo "MySQL is restarted!"
    else
        echo "MySQL is running!"
fi
