

* [舙](http://rhel.idlls6wdbint.instruqt.io:8080/)



[root@docker-cry001 centos64]# export HELLO="Hello"
[root@docker-cry001 centos64]# echo $HELLO
Hello
export HARBORIP="10.5.1.17"
curl -u admin:Harbor12345 https://$HELLO/api/v2.0/projects/library/repositories/busybox
curl -u admin:Harbor12345 https://10.5.1.17.io/api/v2.0/projects/library/repositories/busybox

https://lab.redhat.com/tracks/sandbox


https://linuxconfig.org/how-to-install-docker-in-rhel-8#
https://docs.docker.com/engine/install/rhel/
https://github.com/goharbor/harbor/issues/13553

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

$ sudo dnf install python3-pip
$ pip3 install docker-compose --user
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

cp harbor.yml.tmpl harbor.ymlcd 
輸入「ifconfig -a」指令來檢視所有網路介面卡資訊
+ ip / http 留

# 新增以下檔案內容 /etc/docker/daemon.json
{
    "insecure-registries": ["10.5.0.193"]
}
$ sudo systemctl daemon-reload && sudo systemctl restart docker

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

重新啟動 docker & systemctl
$ sudo systemctl daemon-reload && sudo systemctl restart docker

$ sudo ./install.sh

http://rhel.d8zrr00ouhm4.instruqt.io:80


##### issue

https://github.com/aquasecurity/harbor-scanner-trivy/issues/73
https://gitee.com/jcown/harbor-scanner-trivy

https://blog.csdn.net/tianmingqing0806/article/details/126423734?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-0-126423734-blog-127602288.pc_relevant_landingrelevant&spm=1001.2101.3001.4242.1&utm_relevant_index=3

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
