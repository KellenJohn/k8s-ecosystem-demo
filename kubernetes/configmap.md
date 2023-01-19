### Kubernetes configmap 101

configmap 一般可以用来非機敏性的數據保存至 key/value 之中或是往 Pod 傳遞資訊
> A ConfigMap allows you to decouple environment-specific configuration from your container images, so that your applications are easily portable. Use a ConfigMap for setting configuration data separately from application code.

#### 應用場景
* 設定檔和容器映像檔分離(讓應用程序可以更容易配適不同環境)
* 集中式的設定管理

使用時，可以通過以下進行
* 命令行方式
* 文件(yaml)創建方式


在容器命令和参数内
容器的环境变量
在只读卷里面添加一个文件，让应用来读取
编写代码在 Pod 中运行，使用 Kubernetes API 来读取 ConfigMap

##### 方法一

##### 方法二


範例 - configmap 
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: game-demo
data:
  # 类属性键；每一个键都映射到一个简单的值
  player_initial_lives: "3"
  ui_properties_file_name: "user-interface.properties"

  # 类文件键
  game.properties: |
    enemy.types=aliens,monsters
    player.maximum-lives=5    
  user-interface.properties: |
    color.good=purple
    color.bad=yellow
    allow.textmode=true   
```

範例 - configmap(驗證重新 reload) 
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: game-demo
data:
  # 类属性键；每一个键都映射到一个简单的值
  player_initial_lives: "999"
  ui_properties_file_name: "user-interface.properties"

  # 类文件键
  game.properties: |
    enemy.types=aliens_new,monsters_new
    player.maximum-lives=999    
  user-interface.properties: |
    color.good=purple_new
    color.bad=yellow_new
    allow.textmode=true 
```

範例 - configmap/configure-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-demo-pod
spec:
  containers:
    - name: demo
      image: alpine
      command: ["sleep", "3600"]
      env:
        # 定义环境变量
        - name: PLAYER_INITIAL_LIVES # 请注意这里和 ConfigMap 中的键名是不一样的
          valueFrom:
            configMapKeyRef:
              name: game-demo           # 这个值来自 ConfigMap
              key: player_initial_lives # 需要取值的键
        - name: UI_PROPERTIES_FILE_NAME
          valueFrom:
            configMapKeyRef:
              name: game-demo
              key: ui_properties_file_name
      volumeMounts:
      - name: config
        mountPath: "/config"
        readOnly: true
  volumes:
  # 你可以在 Pod 级别设置卷，然后将其挂载到 Pod 内的容器中
  - name: config
    configMap:
      # 提供你想要挂载的 ConfigMap 的名字
      name: game-demo
      # 来自 ConfigMap 的一组键，将被创建为文件
      items:
      - key: "game.properties"
        path: "game.properties"
      - key: "user-interface.properties"
        path: "user-interface.properties"
```


驗證與解說
```
$ kubectl exec -it configmap-demo-pod -- sh
/ # ls
bin     config  dev     etc     home    lib     media   mnt     opt     proc    root    run     sbin    srv     sys     tmp     usr     var
/ # cd config
/config # ls
game.properties            user-interface.properties
/config # echo $PLAYER_INITIAL_LIVES
3
/config # echo $UI_PROPERTIES_FILE_NAME
user-interface.properties
/config # cat user-interface.properties 
color.good=purple
color.bad=yellow
allow.textmode=true 
/config # 
# 
# 等一下，我們作個手腳，把 configmap 重新 reload 成新的
#
/config # echo $PLAYER_INITIAL_LIVES
3
/config # cat user-interface.properties
color.good=purple_new
color.bad=yellow_new
allow.textmode=true 
/config # 

# 可以發現環境變數依舊是 3(即使是我們調整了 confingmap)，因為他是 env 帶入無法達到熱更新
# 若是 configmap 以 volume 掛載進行，可以看到可進行熱更新(顏色有帶 _)
# 但是應用程式服務又是另一個要判斷，有可能像資料庫長連線或是 API 依舊是以舊的 configmap 資料
# 建議要測試一下，對 Pod / Deployment 進行重啟
```

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: example-redis-config
data:
  redis-config: |
    maxmemory 2mb
    maxmemory-policy allkeys-lru 
```

```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: mypod
    image: redis
    volumeMounts:
    - name: foo
      mountPath: "/etc/foo"
      readOnly: true
  volumes:
  - name: foo
    configMap:
      name: myconfigmap
```


```
apiVersion: v1
kind: Pod
metadata:
  name: redis
spec:
  containers:
  - name: redis
    image: redis:5.0.4
    command:
      - redis-server
      - "/redis-master/redis.conf"
    env:
    - name: MASTER
      value: "true"
    ports:
    - containerPort: 6379
    resources:
      limits:
        cpu: "0.1"
    volumeMounts:
    - mountPath: /redis-master-data
      name: data
    - mountPath: /redis-master
      name: config
  volumes:
    - name: data
      emptyDir: {}
    - name: config
      configMap:
        name: example-redis-config
        items:
        - key: redis-config
          path: redis.conf
```

---

範例：
說明：把文件的內容寫入至 configmap，之後在透過 volume 方式來引用這個 configmap，就等同把想要的文件引入至 Pod 中

```bash
指令 kubectl create configmap cm2 --from-file=file1
# 文件名為 key，而內容為 value
# 試著把 /etc/host 這個作為 configmap

$ kubectl describe cm cm2
Name: cm2
Namespace: default
Labels: <none>
Annotations: <none>
Data
====
hosts:
 - - 
127.0.0.1 localhost
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
192.168.0.27 worker1
BinaryData
====
Events: <none>

# 或是
$ kubectl get cm my2 -o yaml
apiVersion: v1
data:
  hosts: "127.0.0.1\tlocalhost\n\nfe00::0\tip6-localnet\nff00::0\tip6-mcastprefix\nff02::1\tip6-allnodes\nff02::2\tip6-allrouters\n192.168.0.27\tworker1\n"
kind: ConfigMap
metadata:
  creationTimestamp: "2023-01-19T03:36:38Z"
  name: my2
  namespace: default
  resourceVersion: "4746"
  uid: 03ff5f34-6b3d-4e9b-ae44-119d4f49b1b3

# 引用不同文件(由 key 來處理要抓那份資訊)
$ kubectl get cm my2 -o jsonpath='{.data.hosts}'
127.0.0.1       localhost

fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
192.168.0.27    worker1

$ cat /etc/hosts
127.0.0.1 localhost
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
192.168.0.27 worker1
```
