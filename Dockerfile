FROM java:8-alpine

RUN apk add --update curl wget bash

RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 -o /usr/local/bin/confd; chmod 0755 /usr/local/bin/confd; mkdir -p /etc/confd/{conf.d,templates}

RUN mkdir -p /usr/local/sbin && curl -L https://github.com/tianon/gosu/releases/download/1.6/gosu-amd64 -o /usr/local/sbin/gosu; chmod 0755 /usr/local/sbin/gosu

EXPOSE 9092

ENV KAFKA_VERSION 0.11.0.1
ENV SCALA_VERSION 2.12
RUN wget -q http://mirror.vorboss.net/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O - | tar -xzf -; mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} /kafka

VOLUME /data

WORKDIR /kafka
COPY config/server.properties /kafka/config/server.properties
COPY run.sh /run.sh

CMD /run.sh

