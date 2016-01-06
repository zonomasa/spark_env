#!/bin/bash

set -eu

myerr() {
    echo $1
    exit 1
}


java -version || myerr "java not found"


FTP=http://ftp.tsukuba.wide.ad.jp/software/apache/spark
#FTP=http://ftp.jaist.ac.jp/pub/apache/spark
SPARK_VER=1.5.2
HADOOP_VER=2.6
SPARK_BIN=spark-${SPARK_VER}-bin-hadoop${HADOOP_VER}

mkdir -p ~/spark
cd ~/spark
rm -f ${SPARK_BIN}.tgz
wget ${FTP}/spark-${SPARK_VER}/${SPARK_BIN}.tgz
tar xzvf ${SPARK_BIN}.tgz

cd  ${SPARK_BIN}
sed -e 's/log4j.rootCategory=INFO/log4j.rootCategory=WARN/g' conf/log4j.properties.template >conf/log4j.properties

cp conf/slaves.template conf/slaves
