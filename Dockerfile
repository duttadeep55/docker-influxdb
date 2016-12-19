FROM centos:centos7

RUN yum update -y && \
yum install -y wget  && \
yum install -y python-setuptools && \
yum clean all


RUN wget https://dl.influxdata.com/influxdb/releases/influxdb-0.13.0.x86_64.rpm
RUN yum localinstall -y influxdb-0.13.0.x86_64.rpm

RUN easy_install supervisor

ADD run.sh /run.sh
#ADD continuous_queries.txt /config/continuous_queries.txt
RUN chmod +x /*.sh

COPY supervisord.conf /etc/supervisor/supervisord.conf
# Expose the ports for inbound events and websockets

EXPOSE 8086
EXPOSE 8083

CMD ["supervisord"]
