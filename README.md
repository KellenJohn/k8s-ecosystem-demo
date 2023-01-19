### 這邊提供各式線上 on-line lab 實作 Kubernetes 
#### 用途使用
* 辦公需求、不想帶 notebook 或可能在其他地方有裝置或不希望透過雲端產生額外費用
* 自有資源不多又不想汙染自己 client 端的 K8s cluster setting
* 純 lab 可快速實驗、探索，對岸亦有類似相關文章，搜尋「白嫖」線上 LAB 字眼應該會有更多奇招

#### 缺點
* 驗證想法使用，相關程序不易保存，或是在前置作業中，加入你想要同步的雲端資源也是可行作法，e.g., DockerHub, Github, ...
* 時間限制，不過像是 Container Lab 4 小時後還可以到 24 小時滿夠用了
* 較大型或持續性的專案不適用或是要逼迫自己進行最佳化

#### 選型 on-line lab
* RedHat on-line lab
 * 參考 redhat-online-lab.sh 進行前置處理後，即可使用 Kubernetes on-line 
 * 優點：界面操作性勝
 * 缺點：只有一個小時 😢
* Docker Container lab
 * 參考 dockerlab-online.sh 進行前置處理後，即可使用 Kubernetes on-line 
 * 優點：一開始限時四小時，但時間到了還在操作話會到二十四小時，幾乎無限時間任你玩
 * 缺點：界面操作性稍差 😢
