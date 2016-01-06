#!/bin/bash

BASE=ubuntu
ID=spark_node
NUM_NODE=10

rm -rf /tmp/spark_env
mkdir -p /tmp/spark_env

ssh-keygen -f /tmp/spark_env/key -N ""

sudo docker rm -f `sudo docker ps -a -q`

set -eu

sudo docker build -t ${BASE}:${ID} .

for i in `seq 2 $NUM_NODE`
do
    NODE=`printf "%03d" $i`
    sudo docker run -v /tmp/spark_env:/sshkeys --name=spark_node${NODE} -e IP=${i} --privileged -it -d ${BASE}:${ID}
#    ssh -i /tmp/spark_env/key -oStrictHostKeyChecking=no root@172.17.0.${i} ip addr
#    echo $NODE
done

sudo docker start `sudo docker ps -a -q`


rm -f slaves

for i in `seq 2 $NUM_NODE`
do
    ssh -i /tmp/spark_env/key -oStrictHostKeyChecking=no root@172.17.0.${i} ip addr
    echo 172.17.0.${i}>>slaves
done

sudo docker ps -a
