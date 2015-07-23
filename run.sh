#!/bin/bash


sed -i -e "s/\tserver = \"localhost\"/\tserver = \"$MYSQL_SERVER\"/" /etc/raddb/sql.conf
sed -i -e "s/\tpassword = \"radpass\"/\tpassword = \"$MYSQL_PASSWORD\"/" /etc/raddb/sql.conf

echo >> /etc/raddb/clients.conf
echo "client $CLIENT_IP {">> /etc/raddb/clients.conf
echo "       secret          = $CLIENT_PASSWORD">> /etc/raddb/clients.conf
echo "}">> /etc/raddb/clients.conf
echo >> /etc/raddb/clients.conf

service radiusd start

/bin/bash

