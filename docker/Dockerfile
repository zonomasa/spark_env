FROM ubuntu

RUN apt-get update
RUN apt-get -y install git openjdk-7-jdk wget
RUN apt-get -y install ssh
RUN mkdir ~/spark
RUN git clone https://github.com/zonomasa/spark_env.git ~/spark
RUN sh ~/spark/install.sh


ENTRYPOINT  env &&\
ip addr del `ip addr |grep "inet " |grep -v 127|awk '{print $2}'` dev eth0 && \
            ip addr add 172.17.0.${IP} dev eth0 && \
            ip route add 172.17.0.0/16 via 0.0.0.0 dev eth0 && \
            service ssh start &&\
            mkdir -p /root/.ssh && chmod 600 /root/.ssh && cp /sshkeys/key.pub /root/.ssh/authorized_keys && \
            bash