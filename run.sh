#!/bin/bash


sed -i -e "s/\tserver = \"localhost\"/\tserver = \"$MYSQL_SERVER\"/" /etc/raddb/sql.conf
sed -i -e "s/\tpassword = \"radpass\"/\tpassword = \"$MYSQL_PASSWORD\"/" /etc/raddb/sql.conf

service radiusd start

/bin/bash

