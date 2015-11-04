#! /bin/bash
while true
do
    ping -c 1 10.140.192.130 > /dev/null
    sleep 300
done
