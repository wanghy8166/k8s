wget -O install_docker.sh https://raw.githubusercontent.com/wanghy8166/k8s/master/install_docker.sh
oldstr="hostname=node82"  
newstr="hostname=node82"  
sed -i "s#$oldstr#$newstr#g" install_docker.sh
sh install_docker.sh

systemctl status firewalld
getenforce

Rancher安装.sh(独立一台)
https://github.com/rancher/rancher
https://hub.docker.com/r/rancher/rancher
docker pull rancher/rancher:stable
sudo docker run -d --restart=unless-stopped --name rancher2 -v /etc/timezone:/etc/timezone -v /etc/localtime:/etc/localtime -p 80:80 -p 443:443 rancher/rancher:stable
sudo docker logs -f rancher2

https://172.17.10.82/
admin/admin

k8s集群安装(独立一台)
在Rancher界面操作完成

docker pull wanghy8166/hd:tengine2.2.3-alpine3.8-20190110

https://www.cnrancher.com/docs/rancher/v2.x/cn/tools/pipelines/quick-start-guide/
Configuring Pipeline Trigger Rules
后来发现github的webhook里报错
We couldn’t deliver this payload: Couldn''t connect to server
由于填写的是内网地址
https://172.17.10.82/hooks?pipelineId=p-8ds5d:p-5ngw7
所以注定是不能自动触发的

那怎么办？
自建gitlab啊
https://docs.gitlab.com/ee/install/docker.html#install-gitlab-with-docker
https://docs.gitlab.com/omnibus/docker/README.html

echo 172.17.10.87 gitlab.example.com>>C:\Windows\System32\drivers\etc\hosts
type C:\Windows\System32\drivers\etc\hosts

echo 172.17.10.87 gitlab.example.com>>/etc/hosts
cat /etc/hosts

rm /etc/timezone -rf
rm /etc/localtime -rf
echo 'Asia/Shanghai' > /etc/timezone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

docker pull gitlab/gitlab-ce:11.6.5-ce.0
docker pull gitlab/gitlab-ce:latest
docker rm -f gitlab
rm /srv/gitlab/* -rf
sudo docker run --detach \
	--hostname 172.17.10.87 \
	--publish 443:443 --publish 80:80 --publish 222:22 \
	--name gitlab \
	--restart always \
	--volume /srv/gitlab/config:/etc/gitlab \
	--volume /srv/gitlab/logs:/var/log/gitlab \
	--volume /srv/gitlab/data:/var/opt/gitlab \
	-v /etc/timezone:/etc/timezone -v /etc/localtime:/etc/localtime \
	gitlab/gitlab-ce:latest
sudo docker logs -f gitlab

http://172.17.10.87
root/admin678

http://172.17.10.87/admin/application_settings/network#js-outbound-settings
Note:
1. Pipeline uses Gitlab v4 API and the supported Gitlab version is 9.0+. 
2. If you use GitLab 10.7+ and your Rancher setup is in a local network, enable the
Allow requests to the local network from hooks and services
option in GitLab admin settings.

#https://docs.gitlab.com/omnibus/settings/smtp.html

在gitlab里操作，通过Personal access tokens导入github仓库docker-tengine

在Rancher,Resources,Pipeline做授权

在gitlab里操作，配置应用
应用名 MyPipeline
Callback URL回调 https://172.17.10.82/verify-auth
ID  
密码 

之后便可在Rancher,Workloads,Pipelines里看到任务

向gitlab做push会自动触发任务执行
目前测试只操作了自动构建、自动发布，其他ci/cd功能应该都是可以的
