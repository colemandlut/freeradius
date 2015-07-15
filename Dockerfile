FROM centos:centos6

MAINTAINER coleman <coleman_dlut@hotmail.com>

ENV MYSQL_PASSWORD=

RUN yum -y update && \
    yum -y install freeradius freeradius-utils freeradius-mysql && \
    yum clean all

RUN sed -i -e "s/\tauth = no/\tauth = yes/" /etc/raddb/radiusd.conf && \
    sed -i -e "s/\tauth_badpass = no/\tauth_badpass = yes/" /etc/raddb/radiusd.conf && \
    sed -i -e "s/\tsecret\t\t= testing123/\tsecret\t\t= testing123/" /etc/raddb/clients.conf
RUN echo >> /etc/raddb/users
RUN echo unixpower Auth-Type:=Local, Cleartext-Password:=\"password\" >> /etc/raddb/users
RUN echo >> /etc/raddb/users
RUN sed -i -e "s/\tpassword = \"radpass\"/\tpassword = \"$MYSQL_PASSWORD\"/" /etc/raddb/sql.conf
RUN sed -i -e "s/#\t\$INCLUDE sql.conf/\t\$INCLUDE sql.conf/" /etc/raddb/radiusd.conf
RUN sed -i -e "/\t#  See \"Authorization Queries\" in sql.conf/{n \
    s/#\tsql/\tsql/} " /etc/raddb/sites-available/default
RUN sed -i -e "/\t#  See \"Accounting queries\" in sql.conf/{n \
    s/#\tsql/\tsql/} " /etc/raddb/sites-available/default
RUN sed -i -e "/\t#  See \"Authorization Queries\" in sql.conf/{n  \
    s/#\tsql/\tsql/} " /etc/raddb/sites-available/inner-tunnel
RUN sed -i -e "/\t#  See \"Simultaneous Use Checking Queries\" in sql.conf/{n  \
    s/#\tsql/\tsql/} " /etc/raddb/sites-available/inner-tunnel



# Add files
#ADD install.sh /opt/install.sh

# Run
CMD /bin/bash