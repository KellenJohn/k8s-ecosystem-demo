https://lab.redhat.com/tracks/sandbox

* [舙](http://rhel.idlls6wdbint.instruqt.io:8080/)



[root@docker-cry001 centos64]# export HELLO="Hello"
[root@docker-cry001 centos64]# echo $HELLO
Hello
export HARBORIP="10.5.1.17"


安裝 trivy
https://aquasecurity.github.io/trivy/v0.18.3/installation/

在 RHEL 安裝 Docker/Docker-compose 的解法
https://linuxconfig.org/how-to-install-docker-in-rhel-8#
https://docs.docker.com/engine/install/rhel/
https://github.com/goharbor/harbor/issues/13553


/usr/local   ：在你安裝完了 Linux 之後，基本上所有的配備你都有了，但是軟體總是可以升級的，例如你要升級你的 proxy 服務，則通常軟體預設的安裝地方就是在 /usr/local 中（ local 是『當地』的意思），同時，安裝完畢之後所得到的執行檔，為了與系統原先的執行檔有分別，因此升級後的執行檔通常擺在 /usr/local/bin 這個地方


redhat lab
```sh
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine \
                podman \
                runc
sudo yum install -y yum-utils
sudo yum-config-manager \
             --add-repo \
             https://download.docker.com/linux/rhel/docker-ce.repo       
             
# sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
# yum list docker-ce --showduplicates | sort -r

# >>>>>>>>>>>>>>>>>>>

sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf repolist -v
dnf list docker-ce --showduplicates | sort -r
sudo dnf install docker-ce-3:20.10.21-3.el9
sudo dnf install --nobest docker-ce
sudo dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
sudo dnf install docker-ce
sudo systemctl disable firewalld
sudo systemctl enable --now docker

$ systemctl is-active docker
active
$ systemctl is-enabled docker


curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o docker-compose
sudo mv docker-compose /usr/local/bin && sudo chmod +x /usr/local/bin/docker-compose

sudo dnf install python3-pip
pip3 install docker-compose --user
```


Harbor script

```sh
$ wget https://github.com/goharbor/harbor/releases/download/v2.0.2/harbor-offline-installer-v2.0.2.tgz
$ tar -xvf harbor-offline-installer-v2.0.2.tgz
$ cd harbor
$ tree .
.
├── common.sh
├── harbor.v2.0.2.tar.gz
├── harbor.yml.tmpl
├── install.sh
├── LICENSE
└── prepare

cp harbor.yml.tmpl harbor.yml
vim /usr/local/harbor/harbor.yml


hostname: 域名 IP
並註銷掉 https 之後在驗證

輸入「ifconfig -a」指令來檢視所有網路介面卡資訊
+ ip / http 留

# 新增以下檔案內容 vim /etc/docker/daemon.json

{   
    "dns": ["8.8.8.8","8.8.4.4"],
    "insecure-registries": ["10.5.0.251"]
}

重新啟動 docker & systemctl
a.修改完成後reload組態檔
sudo systemctl daemon-reload
 
b.重啟docker服務
sudo systemctl restart docker.service
$ sudo systemctl daemon-reload && sudo systemctl restart docker


重启服务 systemctl restart docker 重启服务以后需要再跑一遍脚本，80端口才会启动


vim /etc/hosts

ifconfigvi
10.5.0.193

{
    "experimental": true,
    "debug": true,
    "log-level": "info",
    "insecure-registries": ["192.168.0.7"],
    "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2375"],
    "tls": false,
    "tlscacert": "",
    "tlscert": "",
    "tlskey": ""
}    


$ docker-compose up -d ：构建（容器）并启动（容器）整个project的所有service

$ sudo ./install.sh --with-trivy

http://rhel.d8zrr00ouhm4.instruqt.io:80





##### issue
教 https://juejin.cn/post/7081686625704476702
教 https://blog.51cto.com/lidabai/5846822
教 https://blog.csdn.net/qq_34556414/article/details/109670343

https://blog.csdn.net/tianmingqing0806/article/details/126423734?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-0-126423734-blog-127602288.pc_relevant_landingrelevant&spm=1001.2101.3001.4242.1&utm_relevant_index=3

強
https://www.chenshaowen.com/blog/a-image-management-and-distribution-case-based-on-harbor-and-registry.html
https://www.linuxprobe.com/harbor-high-availability.html
https://blog.csdn.net/qq_34556414/article/details/109670343
https://www.cnblogs.com/zhangxingeng/p/11598708.html

教離線 trivy
https://blog.csdn.net/weixin_38299404/article/details/116532027?spm=1001.2101.3001.6650.6&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-6-116532027-blog-105639085.pc_relevant_3mothn_strategy_and_data_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-6-116532027-blog-105639085.pc_relevant_3mothn_strategy_and_data_recovery&utm_relevant_index=9
https://tw511.com/a/01/45894.html

https://github.com/aquasecurity/harbor-scanner-trivy/issues/73
https://gitee.com/jcown/harbor-scanner-trivy


https://github.com/goharbor/harbor/issues/16748
https://blog.csdn.net/qq_31977125/article/details/105639085
https://gist.github.com/danielpacak/22ed6bfb5fb9ced38bb94d5acb800da6

docker logs -f trivy-adapter
ERROR: requeuer.process - dial tcp: lookup trivy-redis on 127.0.0.11:53: no such host
ERROR: worker.fetch - dial tcp: lookup trivy-redis on 127.0.0.11:53: no such host


curl http://trivy-adapter:8080/api/v1/metadata
http://trivy-adapter:8080
Dec  3 12:44:23 172.18.0.1 core[4512]: 2022-12-03T12:44:23Z [ERROR] [/server/error/error.go:53]: {"errors":[{"code":"INTERNAL_SERVER_ERROR","message":"scanner API: ping: scanner controller: ping: v1 client: get metadata: Get http://trivy-adapter:8080/api/v1/metadata: dial tcp: lookup trivy-adapter on 127.0.0.11:53: no such host"}]} 


```
* 準備一個 harbor.yml 的設定檔案
* 執行 prepare 這個腳本，此腳本會讀取 harbor.yml 的設定檔案，並根據此產生一個合適的 docker-compose 檔案
* 最後根據運行產生出來的 docker-compose 檔案即可

docker login <Your Harbor Domain> or <IP>
docker login --username admin --password 1313  https://192.168.0.7

https://github.com/gliderlabs/docker-alpine/issues/183
https://blog.51cto.com/u_15266039/4967617
  
  
  
---
Trivy
注意：从其他节点docker客户端登录harbor，必须分发ca.crt到对应客户端
配置trivy	
创建一个docker网络，后续的redis与trivy都是用这个网络。网络名与harbor的docker-compose.xml中的网络名相同，这样才能使用内部url互通。当然也可以使用外部地址互通。
```sh
$docker network create harbor_harbor

使用docker运行一个redis供trivy使用
$docker run --name redis -d --rm --network harbor_harbor redis:5

使用docker运行trivy
因为我是内网需要通过代理才能上公网，所以容器启动时加配置proxy的环境变量，NO_PROXY可以参照harbor和clair的no_proxy配置，否则trivy可能连不上harbor。具体可配置的参数这里有个列表

docker run --name trivy-adapter -d --rm \
  -p 8181:8181 \
  --env HTTP_PROXY='http://192.168.1.2:8080' \
  --env HTTPS_PROXY='http://192.168.1.2:8080' \
   --env NO_PROXY='.local,portal,clair-adapter,chartmuseum,trivy-adapter,core,redis' \
  -e "SCANNER_LOG_LEVEL=trace" \
  -e "SCANNER_TRIVY_DEBUG_MODE=true" \
  -e "TRIVY_NON_SSL=true" \
  -e "SCANNER_API_SERVER_ADDR=:8181" \
  -e "SCANNER_STORE_REDIS_URL=redis://redis:6379" \
  -e "SCANNER_JOB_QUEUE_REDIS_URL=redis://redis:6379" \
  --network harbor_harbor \
  aquasec/harbor-scanner-trivy:0.9.0
  
# Daniel
$ docker network create trivy-adapter
$ docker run --name redis -d --rm --network trivy-adapter redis:5
$ docker run --name trivy-adapter -d --rm \
  -p 8080:8080 \
  -u root:root \
  -e "SCANNER_LOG_LEVEL=trace" \
  -e "SCANNER_STORE_REDIS_URL=redis://redis:6379" \
  -e "SCANNER_JOB_QUEUE_REDIS_URL=redis://redis:6379" \
  --network trivy-adapter \
  docker.io/aquasec/harbor-scanner-trivy:0.2.2


# 改良	
$ docker network create trivy-adapter
$ docker run --name redis -d --rm --network trivy-adapter redis:5
	
	
# Removed the -u root:root from the docker command (so that the scanner user owned the cache)
  -e "SCANNER_STORE_REDIS_URL=redis://redis:6379" \
  -e "SCANNER_JOB_QUEUE_REDIS_URL=redis://redis:6379" \	
# 檢查以上	

	
	
# 改良
$ docker network create harbor_harbor
$ docker run --name redis -d --rm --network harbor_harbor redis:5	
	
$ docker run --name trivy-adapter -d --rm \
  -p 8080:8080 \
  -u root:root \
  -e "SCANNER_LOG_LEVEL=trace" \
  -e "SCANNER_TRIVY_DEBUG_MODE=true" \
  -e "TRIVY_NON_SSL=true" \
  -e "SCANNER_TRIVY_INSECURE=true" \
  -e "SCANNER_STORE_REDIS_URL=redis://trivy-redis:6379" \
  -e "SCANNER_JOB_QUEUE_REDIS_URL=redis://trivy-redis:6379" \
  -e "SCANNER_API_SERVER_ADDR=:8080" \  
  --network harbor_harbor \
  docker.io/aquasec/harbor-scanner-trivy:0.11.0

# 檢查  
curl -u admin:Harbor12345 https://$HELLO/api/v2.0/projects/library/repositories/busybox
curl -u admin:Harbor12345 https://10.5.1.17.io/api/v2.0/projects/library/repositories/busybox  
curl -u admin:Harbor12345 https://10.5.0.251.io/api/v2.0/projects/library/repositories/alpine 
docker logs -f trivy-adapter
curl http://trivy-adapter:8181/api/v1/metadata  
```
  
Hi, how to check whether the CVE data download is complete?</br>
You can check if the metadata.json and trivy.db files are present under the</br> $SCANNER_TRIVY_CACHE_DIR/db directory. It defaults to the /home/scanner/.cache/trivy/db path.</br>

Then download cve from trivy-db : https://github.com/aquasecurity/trivy-db/releases.
And import , my import cve db commands is, follow from https://github.com/aquasecurity/trivy/blob/master/docs/air-gap.md#put-the-db-file-in-trivys-cache-directory

$ docker cp trivy-offline.db.tgz   trivy-adapter:/home/scanner
$ docker exec -it trivy-adapter /bin/sh
$ mkdir -p /home/scanner/.cache/trivy/db
$ cd /home/scanner/.cache/trivy/db
$ mv /home/scanner/trivy-offline.db.tgz .
$ tar xvf trivy-offline.db.tgz
x trivy.db
x metadata.json
$ rm trivy-offline.db.tgz


鏡像清理腳本
https://medium.com/@shahids89/harbor-container-images-cleanup-automation-1de7cc7c5655
