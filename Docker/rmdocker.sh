#!/bin/bash
sudo apt-get purge -y docker-engine
sudo apt-get autoremove -y --purge docker-engine
sudo apt-get autoclean
sudo rm -rf /var/lib/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
