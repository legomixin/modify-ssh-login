#!/bin/bash
clear

###### 通用代码 ######

#脚本变量
#设置服务器账户信息，账户分为维护：maintain, 安全：security
date=`date "+%Y%m%d"`
maintain="maintain"
security="security"

#使用说明
echo -e "\033[33m 《一键创建账户、修改 ssh 登录方式》使用说明 \033[0m"
echo ""
echo "A.此脚本仅适用于RHEL/CentOS操作系统，支持6.x、 7.x各系统版本

