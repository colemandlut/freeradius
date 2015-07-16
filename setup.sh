#!/bin/bash

sed -i -e "s/\tauth = no/\tauth = yes/" /etc/raddb/radiusd.conf && \
sed -i -e "s/\tauth_badpass = no/\tauth_badpass = yes/" /etc/raddb/radiusd.conf && \
sed -i -e "s/\tsecret\t\t= testing123/\tsecret\t\t= testing123/" /etc/raddb/clients.conf

echo >> /etc/raddb/users
echo unixpower Auth-Type:=Local, Cleartext-Password:=\"password\" >> /etc/raddb/users
echo >> /etc/raddb/users

sed -i -e "s/\tpassword = \"radpass\"/\tpassword = \"$MYSQL_PASSWORD\"/" /etc/raddb/sql.conf

sed -i -e "s/#\t\$INCLUDE sql.conf/\t\$INCLUDE sql.conf/" /etc/raddb/radiusd.conf

sed -i -e "/\t#  See \"Authorization Queries\" in sql.conf/{n
s/#\tsql/\tsql/} " /etc/raddb/sites-available/default

sed -i -e "/\t#  See \"Accounting queries\" in sql.conf/{n
s/#\tsql/\tsql/} " /etc/raddb/sites-available/default

sed -i -e "/\t#  See \"Authorization Queries\" in sql.conf/{n
s/#\tsql/\tsql/} " /etc/raddb/sites-available/inner-tunnel

sed -i -e "/\t#  See \"Simultaneous Use Checking Queries\" in sql.conf/{n
s/#\tsql/\tsql/} " /etc/raddb/sites-available/inner-tunnel
