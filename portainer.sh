#!/bin/bash
hostname=`hostname` #获取主机域名
ip=`ifconfig eth0 | grep "inet" | awk '{ print $2}' | sed -n '1p;1q'` #获取主机IP地扯
host=https://portainer.xxx.com/api #portainer地扯
token=`curl -l -H "Content-type: application/json" -X POST -d '{"username":"admin","password":"123"}' $host/auth | jq ".jwt"`
#token=`echo $token | jq ".jwt"`
token=${token:1}
token=${token%?}
data={\"Name\":\"222\",\"URL\":\"tcp://$hostname:2376\",\"PublicURL\":\"$ip\",\"TLS\":true}
uploadId=`curl -l -H "Content-type: application/json" -H "Authorization: $token" -X POST -d \'$data\' $host/endpoints | jq ".Id"`
#uploadId=`echo uploadId | jq ".Id"`
curl -F "file=@ca.pem" -H "Authorization: $token" $host/upload/tls/$uploadId/ca
curl -F "file=@cert.pem" -H "Authorization: $token" $host/upload/tls/$uploadId/cert
curl -F "file=@key.pem" -H "Authorization: $token" $host/upload/tls/$uploadId/key
