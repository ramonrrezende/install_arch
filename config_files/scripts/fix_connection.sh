#!/bin/bash

CONN=Conexão\ cabeada\ 1.nmconnection

echo "$CONN"

TARGET_DNS=dns

NEW_DNS_VALUE=192.168.100.2

echo "s/\($TARGET_DNS *= *\).*/\1$NEW_DNS_VALUE/" $CONFIG_FILE /etc/NetworkManager/system-connections/$CONN"

sed -i "s/\($TARGET_DNS *= *\).*/\1$NEW_DNS_VALUE/" $CONFIG_FILE /etc/NetworkManager/system-connections/$CONN"
