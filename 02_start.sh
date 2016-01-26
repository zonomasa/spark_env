#!/usr/bin/env bash

set -eu

cur=`dirname $0` && pushd $cur &>/dev/null

source env.sh

check_java

pushd ${WORK}/docker

./start_cluster.sh

cp ../${SPARK_BIN}/docker/slaves ../${SPARK_BIN}/conf
pushd ../sbin

./stop-all.sh
./start-all.sh
popd
popd
