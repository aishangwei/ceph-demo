# 配置免密钥登录
su - ceph-admin
ssh-keygen
ssh-copy-id ${username}@c720181
ssh-copy-id ${username}@c720182
ssh-copy-id ${username}@c720183

# 安装 ceph-deploy
yum install -y  ceph-deploy

#
mkdir  my-cluster
cd my-cluster

# 创建节点1
ceph-deploy  new  c720181

ls
# 编辑 ceph.conf 配置文件
cat  ceph.conf
[global]
.....
public network = 192.168.20.0/24
cluster network = 192.168.20.0/24

# 安装 ceph包，替代  ceph-deploy install  node1  node2 ,不过下面的命令需要在每台node上安装
yum install -y ceph ceph-radosgw

# 配置初始 monitor(s)、并收集所有密钥：
ceph-deploy mon create-initial
ls -l *.keyring



