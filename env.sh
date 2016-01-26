#!/usr/bin/env bash

WORK=`readlink -f ${cur}`

# Spark binary
FTP=http://ftp.tsukuba.wide.ad.jp/software/apache/spark
#FTP=http://ftp.jaist.ac.jp/pub/apache/spark
SPARK_VER=1.5.2
HADOOP_VER=2.6
SPARK_BIN=spark-${SPARK_VER}-bin-hadoop${HADOOP_VER}

# Docker and Cluster
BASE=ubuntu
ID=spark_node
NUM_NODE=10


check_java() {
    java -version || myerr "java not found"
}

myerr() {
    echo $1
    exit 1
}

