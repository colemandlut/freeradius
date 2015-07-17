FROM centos:centos6

MAINTAINER coleman <coleman_dlut@hotmail.com>

ENV MYSQL_SERVER=
ENV MYSQL_PASSWORD=

RUN yum -y update && \
    yum -y install freeradius freeradius-utils freeradius-mysql && \
    yum clean all

ADD setup.sh /tmp/setup.sh

RUN chmod 777 /tmp/setup.sh
RUN /tmp/setup.sh
RUN rm -f /tmp/setup.sh

# Run
ADD run.sh /opt/run.sh
RUN chmod 700 /opt/run.sh

CMD /opt/run.sh