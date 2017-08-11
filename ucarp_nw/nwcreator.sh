#!/bin/bash
source ~/confignw.sh
mv /etc/network/interfaces.kahuna /etc/network/interfaces
lsmod | grep dummy
modprobe dummy
lsmod | grep dummy
ip link set name eth10 dev dummy0
sleep 1
ifconfig eth10 hw ether $HW_ADDR
#ip addr add $IP_ADDR/24 brd + dev eth10
sleep 1
ifconfig eth10 up
cp /etc/network/interfaces /etc/network/interfaces.kahuna

echo iface eth10:ucarp inet static >> /etc/network/interfaces
echo address $VIRT_IP_ADDR >> /etc/network/interfaces
echo netmask 255.255.255.255 >> /etc/network/interfaces
sleep 1
/sbin/ifup eth10:ucarp

ucarp --interface=eth10 --srcip=$IP_ADDR --vhid=$VIRT_IP_ID --pass=mypassword --addr=$VIRT_IP_ADDR --advbase=$ADVBASE --advskew=$ADVSKEW --daemonize --upscript=/etc/vip-up.sh --downscript=/etc/vip-down.sh
