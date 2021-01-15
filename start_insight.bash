#!/bin/bash
source ./settings.bash

## Calculate the IP
net_ip_pre=`echo $NET_CIDR | cut -f 1 -d'/' | cut -f 1-3 -d'.'`
net_ip=${net_ip_pre}.222
echo ip = $net_ip

docker run --detach --network $NET_NAME --ip $net_ip -p 8080:8001 -v redisinsight:/db redislabs/redisinsight:latest
