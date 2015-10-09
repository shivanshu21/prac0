#!/bin/sh

echo "Staring Virtual machines..."
vboxmanage startvm ClusNode0 --type headless
vboxmanage startvm ClusNode1 --type headless
vboxmanage startvm ClusNode2 --type headless

echo "Sleeping for 15 Seconds..."
sleep 15

if [ -z "$STY" ]; then exec screen -dm -S Deity /bin/bash "$0"; fi
screen -t Main  1 bash;
screen -t Code  2 bash;
screen -t Code  3 bash;
screen -t Code  4 bash;
screen -t Build 5 bash;
screen -t admin 6 bash;
screen -t VM1 7 bash;
screen -t VM2 8 bash;
screen -t VM3 9 bash;
