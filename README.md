# portainer
portainer 自动增加主机
# 使用方法
下载`dounine/tls`项目
```
git clone https://github.com/dounine/tls.git
```
生成证书
```
cd tls
./start.sh
```
复制证书
```
cd portainer
cp -rf ../tls/pem/* .
```
替换`portainer`密码
```
sed -i "s/xxxPassword/密码" portainer.sh
```
往`portainer`添加endpoint
```
./portainer.sh www.demo.com
```

