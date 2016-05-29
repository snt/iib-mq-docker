FROM ubuntu:14.04

ENV IIBTAR 10.0.0-IIB-LINUXX64-FP0004.tar.gz
ENV MQTAR WS_MQ_V8.0.0.4_LINUX_ON_X86_64_IM.tar.gz

#VOLUME ["/var/mqsi"]

RUN apt-get update && apt-get install -y rpm

ADD ${IIBTAR} ${MQTAR} /
COPY setup.sh start.sh /

RUN tar xfz EAsmbl_image/iib-*.tar.gz && ln -s iib-10.* iib

RUN MQServer/mqlicense.sh -accept && \
  rpm -ivh --force-debian MQServer/MQSeriesRuntime-*.rpm && \
  rpm -ivh --force-debian \
    MQServer/MQSeriesClient-*.rpm \
    MQServer/MQSeriesGSKit-*.rpm \
    MQServer/MQSeriesJava-*.rpm \
    MQServer/MQSeriesJRE-*.rpm \
    MQServer/MQSeriesMan-*.rpm \
    MQServer/MQSeriesSamples-*.rpm \
    MQServer/MQSeriesSDK-*.rpm \
    MQServer/MQSeriesServer-*.rpm

RUN usermod -a -G mqm root

RUN sh setup.sh

EXPOSE 1414 4414 7080 7800 11883

CMD ["/bin/bash", "--rcfile", "/start.sh"]


