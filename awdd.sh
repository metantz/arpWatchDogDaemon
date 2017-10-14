#!/bin/sh

iface=$(cat /proc/net/wireless | perl -ne '/(\w+):/ && print $1')
/opt/arpWatchDogDaemon/awdd.py $iface > /dev/null 2>&1 &
