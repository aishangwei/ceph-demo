

export username="ceph-admin"
export passwd="ceph-admin"
export node1="c720181"
export node2="c720182"
export node3="c720183"
export node1_ip="192.168.20.181"
export node2_ip="192.168.20.182"
export node3_ip="192.168.20.183"


# 配置 rpm
wget -O /etc/yum.repos.d/ceph.repo https://raw.githubusercontent.com/aishangwei/ceph-demo/master/ceph-deploy/ceph.repo

# 配置NTP
yum -y install ntpdate ntp
ntpdate  cn.ntp.org.cn
systemctl restart ntpd ntpdate && systemctl enable ntpd ntpdate

# 创建部署用户和ssh免密码登录
useradd ${username}
echo "${passwd}" | passwd --stdin ${username}
echo "${username} ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/${username}
chmod 0440 /etc/sudoers.d/${username}

# 配置防火墙，或者关闭
#firewall-cmd --zone=public --add-port=6789/tcp --permanent
#firewall-cmd --zone=public --add-port=6800-7100/tcp --permanent
#firewall-cmd --reload
#firewall-cmd --zone=public --list-all

# 关闭 selinux
sed -i "/^SELINUX/s/enforcing/disabled/" /etc/selinux/config
setenforce 0

# 配置主机名解析，使用  /etc/hosts,或者dns
cat >>/etc/hosts<<EOF
$node1_ip     $node1
$node2_ip     $node2
$node3_ip     $node3
EOF

# 配置sudo不需要tty
sed -i 's/Default requiretty/#Default requiretty/' /etc/sudoers
