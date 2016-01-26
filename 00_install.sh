#!/usr/bin/env bash

set -eu

cur=`dirname $0` && pushd $cur &>/dev/null

source env.sh
echo $SPARK_VER

check_java

mkdir -p ${WORK}

pushd ${WORK}
rm -f ${SPARK_BIN}.tgz
wget ${FTP}/spark-${SPARK_VER}/${SPARK_BIN}.tgz
tar xzvf ${SPARK_BIN}.tgz

pushd  ${SPARK_BIN}
#sed -e 's/log4j.rootCategory=INFO/log4j.rootCategory=WARN/g' conf/log4j.properties.template >conf/log4j.properties

cp conf/slaves.template conf/slaves

popd

popd

popd
