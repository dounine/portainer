#!/bin/bash
domain=$1
yum install jq net-tools -y
hostname=`hostname` #获取主机域名
ip=`ifconfig eth0 | grep "inet" | awk '{ print $2}' | sed -n '1p;1q'` #获取主机IP地扯
host=https://$domain/api #portainer地扯
token=`curl -l -H "Content-type: application/json" -X POST -d '{"username":"admin","password":"xxxPassword"}' $host/auth | jq ".jwt"`
token=${token:1}
token=${token%?}
data={\"Name\":\"$hostname\",\"URL\":\"tcp://$hostname:2376\",\"PublicURL\":\"$ip\",\"TLS\":true}
uploadId=`curl -l -H "Content-type: application/json" -H "Authorization: $token" -X POST -d $data $host/endpoints | jq ".Id"`
curl -F "file=@ca.pem" -H "Authorization: $token" $host/upload/tls/ca?folder=$uploadId
curl -F "file=@cert.pem" -H "Authorization: $token" $host/upload/tls/cert?folder=$uploadId
curl -F "file=@key.pem" -H "Authorization: $token" $host/upload/tls/key?folder=$uploadId
