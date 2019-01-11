#!/bin/bash
# install_docker.sh
echo node82 >/etc/hostname
hostname node82

cat >/etc/hosts<<EOF
127.0.0.1   localhost
172.17.10.82   node82
172.17.10.86   node86
172.17.10.87   node87
EOF

systemctl disable firewalld
systemctl stop firewalld
echo 'SELINUX=disabled'      >  /etc/selinux/config
echo 'SELINUXTYPE=targeted'  >> /etc/selinux/config 
setenforce 0

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

wget -O 17.03.sh https://releases.rancher.com/install-docker/17.03.sh
oldstr="https://download.docker.com"  
newstr="http://mirrors.aliyun.com/docker-ce"  
sed -i "s#$oldstr#$newstr#g" 17.03.sh
sh 17.03.sh

#/usr/lib/systemd/system/docker.service
sudo systemctl enable docker
sudo systemctl restart docker
sudo docker version