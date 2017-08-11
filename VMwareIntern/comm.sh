#!/bin/bash
#Single container
#sudo docker run -d --name samba -p 10445:445 -v vol222:/mount dperson/samba -u "root;badpass" -s "public;/mount;yes;no;no;all;root;root"


#Swarm
#docker service create --replicas 1 --network shiv1 --name serv2 -p :445 --mount type=volume,source=InternalVolvol1,dst=/mount dperson/samba -s "share1;/mount;yes;no;no;all;root;root" -u "root;badpass"

docker service create --replicas 1 --network shiv1 --name serv3 -p :445 --mount type=volume,source=InternalVolvol3,dst=/mount dperson/samba -s "share1;/mount;yes;no;no;all;root;root" -u "root;badpass"


#docker service create --replicas 1 --network shiv1 --name serv2 -p 10445:445 --mount type=volume,source=InternalVolvol1,dst=/mount busybox
