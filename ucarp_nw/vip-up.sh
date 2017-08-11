#!/bin/sh

echo Starting VIF
/sbin/ifup $1:ucarp
echo Starting NFS container
docker run -d --privileged -p 192.168.213.105:5501:2049 -v vol777:/exports shiv0
