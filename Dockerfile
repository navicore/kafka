FROM centos:7

RUN yum update -y

RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 -o /usr/local/bin/confd; chmod 0755 /usr/local/bin/confd; mkdir -p /etc/confd/{conf.d,templates}

RUN curl -L https://github.com/tianon/gosu/releases/download/1.6/gosu-amd64 -o /usr/local/sbin/gosu; chmod 0755 /usr/local/sbin/gosu

RUN yum install -y -q java-headless tar wget; yum clean all

EXPOSE 9092

ENV KAFKA_VERSION 0.10.1.1
ENV SCALA_VERSION 2.11
RUN wget -q http://mirror.vorboss.net/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O - | tar -xzf -; mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} /kafka

VOLUME /data

WORKDIR /kafka
COPY config/server.properties /kafka/config/server.properties
COPY run.sh /run.sh

CMD /run.sh

