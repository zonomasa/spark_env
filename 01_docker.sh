#!/usr/bin/env bash

set -eu

cur=`dirname $0` && pushd $cur &>/dev/null

source env.sh

pushd ${SPARK_BIN}

rm -rf ${WORK}/tmp/spark_env
mkdir -p ${WORK}/tmp/spark_env

ssh-keygen -f ${WORK}/tmp/spark_env/key -N ""
set +e
sudo docker rm -f `sudo docker ps -a -q`
set -e 
popd
pushd ./docker
sudo docker build -t ${BASE}:${ID} .


for i in `seq 2 $NUM_NODE`
do
    NODE=`printf "%03d" $i`
    sudo docker run -v ${WORK}/tmp/spark_env:/sshkeys --name=spark_node${NODE} -e IP=${i} --privileged -it -d ${BASE}:${ID}
#    ssh -i /tmp/spark_env/key -oStrictHostKeyChecking=no root@172.17.0.${i} ip addr
#    echo $NODE
done

sudo docker start `sudo docker ps -a -q`

sudo cp ${WORK}/tmp/spark_env/key.pub ~/.ssh/authorized_keys
sudo cp ${WORK}/tmp/spark_env/key ~/.ssh/id_rsa


rm -f slaves

for i in `seq 2 $NUM_NODE`
do
    ssh -i ${WORK}/tmp/spark_env/key -oStrictHostKeyChecking=no root@172.17.0.${i} ip addr
    echo 172.17.0.${i}>>slaves
done

sudo docker ps -a
