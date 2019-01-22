#rancher2.1.5应用商店安装kubernetes-dashboard0.8.0所需的在k8s.gcr.io的镜像
docker pull anjia0532/google-containers.kubernetes-dashboard-amd64:v1.10.0
docker tag  anjia0532/google-containers.kubernetes-dashboard-amd64:v1.10.0 k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.0
docker rmi  anjia0532/google-containers.kubernetes-dashboard-amd64:v1.10.0

#使用以下配置文件登录
#find / -name *kubeconfig*            
#/etc/cni/net.d/calico-kubeconfig