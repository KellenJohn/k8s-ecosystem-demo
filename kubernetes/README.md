### 本篇作為在 Kubernetes 環境架設及設計討論
* 推薦搭配波波微課進行 Kubernetes 基礎知識補足 [聯結](https://github.com/spring2go/k8s-msa-in-action)
* Configmap
* Secret
* [ITHome](https://ithelp.ithome.com.tw/articles/10195786)

1. Pod 訪問
```sh
# 直接轉發至本地，不建議在測試環境
kubectl port-forward petclinic 8080:8080

root:~$ kubectl port-forward petclinic 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Handling connection for 8080
```
2、blue green
調整 service.yaml spec.selector.version 為 v1.0.1


```sh
# 查看 k8s node 資訊
kubectl get nodes
podman pull mysql:5.7
kubectl apppy -f mysql.yaml


```
