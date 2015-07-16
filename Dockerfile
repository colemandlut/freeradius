FROM centos:centos6

MAINTAINER coleman <coleman_dlut@hotmail.com>

ENV MYSQL_PASSWORD=

RUN yum -y update && \
    yum -y install freeradius freeradius-utils freeradius-mysql && \
    yum clean all

ADD setup.sh /tmp/setup.sh

RUN chmod 777 /tmp/setup.sh && /tmp/setup.sh && rm -f /tmp/setup.sh

# Run
CMD /bin/bash