#!/bin/bash
source ./settings.bash

## Prepare directories
PLATFORM=`uname`

# The default volume path on Linux
VOLUME_PATH=/srv/docker

if [[ "$PLATFORM" == 'Darwin' ]]
then
   # Let's assume that we don't have access to /srv,
   # so using the user's folder as the parent folder
   VOLUME_PATH=$HOME/srv/docker
fi

mkdir -p $VOLUME_PATH/bind


if [[ "$PLATFORM" == 'Linux' ]]
then
  chgrp docker $VOLUME_PATH/bind
fi

## Calculate the IP
net_ip_pre=`echo $NET_CIDR | cut -f 1 -d'/' | cut -f 1-3 -d'.'`
net_ip=${net_ip_pre}.201
echo ip = $net_ip

## Run
docker run --name bind -d --restart=always \
  --network $NET_NAME --ip $net_ip \
  --publish 10000:10000/tcp \
  --volume $VOLUME_PATH/bind:/data \
  sameersbn/bind:9.10.3-20180127
