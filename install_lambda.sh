#!/bin/bash
Platform=`cat /etc/issue|grep -i Ubuntu`
action_url="http://lambda-forke.oss-cn-hangzhou.aliyuncs.com/rc-kuang_lamb.service"

Url="https://lambda-forke.oss-cn-hangzhou.aliyuncs.com/kuangqie_lambda.tar.gz"

if [ -n "$Platform" ];then
    if ! command -v wget > /dev/null;then
			apt update -y
			apt install wget -y
	fi
    if ! command -v tar > /dev/null;then
			apt update -y
			apt install tar -y
	fi
	ufw disable
else
    systemctl stop firewalld.service
    systemctl disable firewalld.service
    if ! command -v wget > /dev/null;then
		yum install wget -y
	fi
    if ! command -v tar > /dev/null;then
		yum install tar -y
	fi
fi
rm -rf server.tar.gz 
wget -O "server.tar.gz"  "$Url"

rm -rf /home/server_lambda
mkdir /home/server_lambda
kill -9 $(pidof ./kuangqie_lambda)
tar xzvf server.tar.gz -C  /home/server_lambda

cd /home/server_lambda
chmod +x kuangqie_lambda
nohup ./kuangqie_lambda > server_lambda.out 2>&1 &
echo "服务启动成功，请在浏览器输入http://127.0.0.1:9300查看详情 "

if [ -n "$Platform" ];then
	version=`cat /etc/issue | grep 18`
	if [ -n "$version" ];then
		wget -P /etc/systemd/system/  "$action_url"
		rm -rf /etc/rc.kuang_lamb
        echo "forke_start" >> /etc/rc.kuang_lamb
        sed -i '1i\#!/bin/bash' /etc/rc.kuang_lamb
		echo "cd /home/server_lambda" >> /etc/rc.kuang_lamb
        echo "nohup ./kuangqie_lambda > server_lambda.out 2>&1 &" >> /etc/rc.kuang_lamb
        echo "exit 0" >> /etc/rc.kuang_lamb
        sed -i "/forke_start/d" /etc/rc.kuang_lamb
        chmod +x /etc/rc.kuang_lamb
        systemctl enable rc-kuang_lamb
        exit 0
	else
		cd /etc/init.d
		rm -rf forke_server_start.sh
		touch forke_server_start.sh
		echo "forke_start" >> forke_server_start.sh
		sed -i '1i\#!/bin/bash' forke_server_start.sh
		echo "cd /home/server_lambda" >> forke_server_start.sh
		echo "nohup ./kuangqie_lambda > server_lambda.out 2>&1 &" >> forke_server_start.sh
		echo "exit 0" >> forke_server_start.sh
		sed -i "/forke_start/d" forke_server_start.sh
		chmod +x forke_server_start.sh
		update-rc.d forke_server_start.sh defaults 90
	fi
else
    sed -i "/server_lambda/d" /etc/rc.d/rc.local
    sed -i "/nohup .\/kuangqie_lambda/d" /etc/rc.d/rc.local
    echo "cd /home/server_lambda" >> /etc/rc.d/rc.local
    echo "nohup ./kuangqie_lambda > server_lambda.out 2>&1 &" >> /etc/rc.d/rc.local
    chmod +x /etc/rc.d/rc.local
fi

