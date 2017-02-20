#修改www-data用户的nologin为/bin/bash
vim /etc/passwd

#root用户创建www-data用户的.ssh目录
mkdir /var/www/.ssh

#上传私钥到.ssh目录，目录为
/var/www/.ssh/id_rsa

#修改id_rsa的权限为400
chmod 400 id_rsa

# git.oschina.net  SSH TestMethod
rm -rf /root/.ssh/known_hosts
ssh -vT git@git.oschina.net

#github.com SSH TestMethod
rm -rf /root/.ssh/known_hosts
ssh -vT git@github.com