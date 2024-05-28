#! /bin/bash

WIFI_SSID="Spock"
WIFI_PASSWD="06051994"
WIFI_DEVICE="wlan0"
KEYBOARD="br-abnt2"


# keyboard config
loadkeys $KEYBOARD

# network
iwctl --passphrase $WIFI_PASSWD station $WIFI_DEVICE connect $WIFI_SSID

