# Cert Held On

## 基于联盟链的简单证书托管平台

---

环境依赖：go 1.21+, node.js 16.14+

使用说明：

1. 安装依赖

    ```shell
    cd chaincode
    go get
    go mod vendor
    cd ..
    
    cd restapi
    go get
    go mod vendor
    cd ..

    cd webapp
    yarn
    ```

2. 启动网络

    ```shell
    ./scripts/setDNS.sh -a
    source ./scripts/envPeerCompany.sh

    ./scripts/network.sh -u
    ./scripts/registerUser.sh
    ./scripts/enrollUser.sh

    ./scripts/peerStartUp.sh
    ./scripts/instCC.sh
    # 将instCC.sh输出的CHAINCODE_ID复制到testCC.sh的CHAINCODE_ID中
    ./scripts/testCC.sh
    ```

3. 启动restAPI和webApp

    ```shell
    cd restapi
    go run .
    cd ..

    cd webapp
    yarn start
    cd ..
    ```

4. 访问`localhost:8000`进入主页

