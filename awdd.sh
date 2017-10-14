#!/bin/sh

iface=$(cat /proc/net/wireless | perl -ne '/(\w+):/ && print $1')
python /opt/arpWatchDogDaemon/awdd.py $iface
