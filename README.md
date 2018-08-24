# 一键创建账户信息，并修改登录方式为密钥

##### 创建后的账户信息放在/tmp/backups_日期.log文件里面

## 功能描述
###### 1、禁用了除root，nginx(业务需求可在脚本中修改)，以外的所有可登录用户
###### 2、创建三个账户分别是ops、dev、security，账户密码/tmp/backups_日期/用户名.log
###### 3、从公网分别获取了三个账户的公钥信息（此功能是公司内部使用），如需更改，修改create_ssh 方法里面的值即可（公钥地址）
###### 4、修改了sshd_config 配置文件，支持密码密钥登录方式，确认密钥登录成功后，禁用密码登录

```
#脚本使用步骤
git clone https://github.com/stone-snginx/modify-ssh-login.git
cd modify-ssh-login
chmod +x modify_openssh_login.sh
./modify_openssh_login.sh  #执行后，根据提示输入即可
```

`注：记得给个 Star 哦！`
