#!/bin/bash
source ~/confignw.sh
mv /etc/network/interfaces.kahuna /etc/network/interfaces
#ip addr del $IP_ADDR/24 brd + dev eth10
ip link delete eth10 type dummy
rmmod dummy
