#rancher2.1.5应用商店安装istio1.0.1所需的在gcr.io的镜像
docker pull anjia0532/istio-release.citadel:release-1.0-latest-daily
docker pull anjia0532/istio-release.proxyv2:release-1.0-latest-daily
docker pull anjia0532/istio-release.galley:release-1.0-latest-daily
docker pull anjia0532/istio-release.proxyv2:release-1.0-latest-daily
docker pull anjia0532/istio-release.pilot:release-1.0-latest-daily
docker pull anjia0532/istio-release.mixer:release-1.0-latest-daily
docker pull anjia0532/istio-release.sidecar_injector:release-1.0-latest-daily
docker pull anjia0532/istio-release.mixer:release-1.0-latest-dailyproxyv2

docker tag anjia0532/istio-release.citadel:release-1.0-latest-daily gcr.io/istio-release/citadel:release-1.0-latest-daily
docker tag anjia0532/istio-release.proxyv2:release-1.0-latest-daily gcr.io/istio-release/proxyv2:release-1.0-latest-daily
docker tag anjia0532/istio-release.galley:release-1.0-latest-daily gcr.io/istio-release/galley:release-1.0-latest-daily
docker tag anjia0532/istio-release.proxyv2:release-1.0-latest-daily gcr.io/istio-release/proxyv2:release-1.0-latest-daily
docker tag anjia0532/istio-release.pilot:release-1.0-latest-daily gcr.io/istio-release/pilot:release-1.0-latest-daily
docker tag anjia0532/istio-release.mixer:release-1.0-latest-daily gcr.io/istio-release/mixer:release-1.0-latest-daily
docker tag anjia0532/istio-release.sidecar_injector:release-1.0-latest-daily gcr.io/istio-release/sidecar_injector:release-1.0-latest-daily
docker tag anjia0532/istio-release.mixer:release-1.0-latest-daily gcr.io/istio-release/mixer:release-1.0-latest-daily

docker rmi anjia0532/istio-release.citadel:release-1.0-latest-daily
docker rmi anjia0532/istio-release.proxyv2:release-1.0-latest-daily
docker rmi anjia0532/istio-release.galley:release-1.0-latest-daily
docker rmi anjia0532/istio-release.proxyv2:release-1.0-latest-daily
docker rmi anjia0532/istio-release.pilot:release-1.0-latest-daily
docker rmi anjia0532/istio-release.mixer:release-1.0-latest-daily
docker rmi anjia0532/istio-release.sidecar_injector:release-1.0-latest-daily
docker rmi anjia0532/istio-release.mixer:release-1.0-latest-daily