#!/usr/bin/env bash

set -eu

cur=`dirname $0` && pushd $cur &>/dev/null

source env.sh

check_java





APP=StudySpark-0.0.1-SNAPSHOT.jar
MAIN_CLASS=org.example.zono.StudySpark.WordCount

cd ~/spark
cd docker

./start_cluster.sh

cp /tmp/spark_env/key.pub /root/.ssh/authorized_keys
cp /tmp/spark_env/key /root/.ssh/id_rsa

cd  ./${SPARK_BIN}

scp ${APP}

./bin/spark-submit --deploy-mode  cluster --master spark://master:7077 --verbose --class ${MAIN_CLASS}  ${APP}  CHANGES.txt out.txt 


