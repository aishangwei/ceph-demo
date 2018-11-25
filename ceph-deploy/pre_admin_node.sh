


# 配置免密钥登录
su - ceph-admin
export username=ceph-admin
ssh-keygen
ssh-copy-id ${username}@c720181
ssh-copy-id ${username}@c720182
ssh-copy-id ${username}@c720183

# 安装 ceph-deploy
sudo yum install -y  ceph-deploy python-pip

#
mkdir  my-cluster
cd my-cluster

# 创建节点1
ceph-deploy  new  c720181 c720182 c720183

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

# 把配置信息拷贝到各节点
ceph-deploy admin c720181 c720182 c720183

# 配置 osd
for dev in "/dev/vda /dev/vdc /dev/vdd"
do 
  ceph-deploy disk zap c720181 $dev
  ceph-deploy osd create c720181 --data $dev
  ceph-deploy disk zap c720182 $dev
  ceph-deploy osd create c720182 --data $dev
  ceph-deploy disk zap c720183 $dev
  ceph-deploy osd create c720183 --data $dev
done

# 部署 mgr
ceph-deploy mgr create c720181 c720182 c720183

# 开启 dashboard 模块，用于UI查看
ceph mgr module enable dashboard













