#!/bin/bash
clear

###### 通用代码 ######

#脚本变量
#设置服务器账户信息，账户分为维护：maintain, 安全：security
date=`date "+%Y%m%d"`
dev="dev"
dev_pass=`openssl rand -base64 18`
ops="ops"
ops_pass=`openssl rand -base64 18`
security="security"
security_pass=`openssl rand -base64 18`

#使用说明
echo -e "\033[33m 《一键创建账户、修改 ssh 登录方式》使用说明 \033[0m"
echo ""
echo "A.此脚本仅适用于RHEL/CentOS操作系统，支持6.x、 7.x各系统版本"
echo "B.必须切换为 Root 用户运行脚本，并且保证本地或者网络可以正常使用"
echo "C.运行后创建的用户信息会保留在/tmp/backup_$date文件夹。"
echo ""

#检查当前用户是否为root
if [ $(id -u) != "0" ]; then
    echo "当前用户为普通用户，必须使用root用户运行脚本，五秒后自动退出"
    echo ""
    sleep 5
    exit
fi

###### 通用代码 ######

###### 创建用户 ######

#创建用户价目录，并下载公钥信息
function create_ssh(){{
    make /home/$1/.ssh
    wget -o /home/$1/.ssh/authorized_keys http://scan.cmstop.com/download/$1/authorized_keys
    chown -R $1:$1 /home/$1/.ssh
    chmod 644 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys

}

#创建用户函数，并保存用户信息到/tmp/目录下
function create_user() {
    echo -e "\033[33m 开始创建 $1 用户\033[0m"
    echo ""
    useradd $1
    echo $2 | passwd $1 --stdin &>/dev/null 
    if [ $? -eq 0 ]; then
        if [ ! -d "/tmp/backup_$data" ];then
            mkdir -p /tmp/backup_$date
            echo "$1 : $2" >> /tmp/backup_$date/$1.log
        else
            echo "$1 : $2" >> /tmp/backup_$date/$1.log
        fi
        echo "用户已创建成功，账户信息已备份到/tmp/backup_$date/"
        echo ""
    fi
    create_ssh $1
}

#判断用户是否存在，并调用创建用户函数
function user(){
    egrep "^$dev" /etc/passwd >& /dev/null
    if [ $? -ne "0" ];then
        create_user $dev $dev_pass
    else
        echo "$dev 用户已存在！"
    fi
    egrep "^$ops" /etc/passwd >& /dev/null
    if [ $? -ne "0" ];then
        create_user $ops $ops_pass
    else
        echo "$ops 用户已经存在!"
    fi
    egrep "^$security" /etc/passwd >& /dev/null
    if [ $? -ne "0" ];then
        create_user $security $security_pass
    else
        echo "$security 用户已存在！"
    fi
}

#获取系统所有可登录的用户信息，除root外并禁用其他用户登录
function nologin_user(){
    num=`cat /etc/passwd | grep bash | wc -l`
    for val in `cat /etc/passwd | grep bash | awk -F: '{print $1}'`
    do
        if [ "$val" != "root" ] && [ "$val" != "nginx" ];then
            usermod -s /sbin/nologin "$val"
        fi
    done

}



###### 创建用户 #######

###### 脚本菜单 ######
echo -e "\033[36m1: 创建用户\033[0m"
echo ""
echo -e "\033[36m2: 退出脚本\033[0m"
echo ""
read -p "请输入对应的数字后按回车开始执行脚本：" install
if [ "$install" == "1" ];then
    clear
    nologin_user
else
    echo ""
    exit
fi
###### 脚本菜单 ######


















