#!/bin/bash
Platform=`cat /etc/issue|grep -i Ubuntu`
kill -9 $(pidof ./kuangqie_lambda)
rm -rf /home/server_lambda

if [ -n "$Platform" ];then
    version=`cat /etc/issue | grep 18`
	if [ -n "$version" ];then
        rm -rf /etc/systemd/system/rc-kuang_lamb.service
        rm -rf /etc/rc.kuang_lamb
        systemctl stop rc-kuang_lamb.service
        exit 0
    else
        cd /etc/init.d
        rm -rf forke_server_start.sh
        update-rc.d -f forke_server_start.sh remove
    fi
else
    sed -i "/server_web_forke/d" /etc/rc.d/rc.local
    sed -i "/nohup .\/kuangqie_lambda/d" /etc/rc.d/rc.local
fi
