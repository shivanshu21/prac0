#!/bin/sh

echo "Staring Virtual machines..."
vboxmanage startvm ClusNode0 --type headless
vboxmanage startvm ClusNode1 --type headless
vboxmanage startvm ClusNode2 --type headless

echo "Sleeping for 60 Seconds..."
sleep 60

if [ -z "$STY" ]; then exec screen -dm -S Deity /bin/bash "$0"; fi
screen -t Main  1 bash;
sleep 1
screen -t Code  2 bash;
sleep 1
screen -t Code  3 bash;
sleep 1
screen -t Code  4 bash;
sleep 1
screen -t Build 5 bash;
sleep 1
screen -t admin 6 bash;
sleep 1
screen -t VM1 7 bash;
sleep 1
screen -t VM2 8 bash;
sleep 1
screen -t VM3 9 bash;
sleep 1
