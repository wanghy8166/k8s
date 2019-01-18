#!/bin/bash
# install_docker.sh
# 测试环境:CentOS Linux release 7.5.1804 (Core),3.10.0-862.el7.x86_64
# https://www.cnrancher.com/docs/rancher/v2.x/cn/installation/basic-environment-configuration/
# https://www.cnrancher.com/docs/rancher/v2.x/cn/installation/best-practices/
hostname=node82
echo $hostname
echo $hostname >/etc/hostname
hostname $hostname

cat >/etc/hosts<<EOF
127.0.0.1   localhost
172.17.10.82   node82
172.17.10.86   node86
172.17.10.87   node87
EOF

systemctl disable firewalld
systemctl stop firewalld
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux 
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

cat >> /etc/sysctl.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-arptables = 1
net.ipv4.neigh.default.gc_thresh1=4096
net.ipv4.neigh.default.gc_thresh2=6144
net.ipv4.neigh.default.gc_thresh3=8192
net.ipv4.ip_forward=1
udev.event-timeout=300
EOF
sysctl -p

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo echo 'LANG="en_US.UTF-8"' >> /etc/profile;source /etc/profile

virsh net-destroy  default 
virsh net-undefine default 
systemctl disable libvirtd 
systemctl stop libvirtd 
systemctl set-default multi-user.target

rpm -qa|grep docker

sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine \
                  docker-ce-cli \
                  docker-ce-selinux \
                  docker-ce

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    #https://download.docker.com/linux/centos/docker-ce.repo
    
yum list docker-ce --showduplicates | sort -r

#https://releases.rancher.com/install-docker/17.03.sh
wget -O 17.03.sh https://raw.githubusercontent.com/wanghy8166/k8s/master/17.03.sh
oldstr="https://download.docker.com"  
newstr="http://mirrors.aliyun.com/docker-ce"  
sed -i "s#$oldstr#$newstr#g" 17.03.sh
oldstr="17.03.2"  
newstr="17.03.2"  
sed -i "s#$oldstr#$newstr#g" 17.03.sh
sh 17.03.sh

#dockerd[3630]: Error starting daemon: error initializing graphdriver: driver not supported
#处理:rm /var/lib/docker/* -rf
#注意:请先备份，否则镜像和容器都没了
#cat /etc/docker/key.json |python -mjson.tool

touch /etc/docker/daemon.json
cat > /etc/docker/daemon.json <<EOF
{
    "log-driver": "json-file",
    "log-opts": {
    "max-size": "10m",
    "max-file": "20"
    },
    "max-concurrent-downloads": 10,
    "max-concurrent-uploads": 10,
    "registry-mirrors": ["https://7o8ter2k.mirror.aliyuncs.com"],
    "storage-driver": "overlay2",
    "storage-opts": [
    "overlay2.override_kernel_check=true"
    ]
}
EOF
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl restart docker
sudo docker version

/usr/bin/rdate -s time.nist.gov && /sbin/hwclock --systohc 
date -R