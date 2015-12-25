#!/bin/bash
## This runs on admin node (node4) alone

su vagrant
cd

## Get the deployment scripts
echo "== Starting CEPH deployment =="
echo "Adding keys..."
wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -
echo "Adding the Ceph packages to your repository..."
echo deb http://download.ceph.com/debian-hammer/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
echo "Installing CEPH deploy..."
sudo apt-get -y update && sudo apt-get -y install ceph-deploy
sudo apt-get -y install ntp

## Generate SSH keys and push admin's ssh keys on other nodes


## Run the ceph deploy script
echo "== Running CEPH deploy =="
#### A place to put the keyrings
mkdir my-cluster
cd my-cluster

#### Initiate a cluster and get proper ceph.conf
ceph-deploy new node4
sudo cp /vagrant/ceph.conf .
sudo chmod 0755 ./ceph.conf

#### Start installation of ceph binaries
ceph-deploy install node4 node5 node6 node7

#### ST MON leader makes first mon to come up
ceph-deploy mon create-initial

#### Create directories on which to run OSDs
ssh node5 "sudo mkdir /var/local/osd0"
ssh node6 "sudo mkdir /var/local/osd1"
ssh node7 "sudo mkdir /var/local/osd2"
ceph-deploy osd prepare node5:/var/local/osd0 node6:/var/local/osd1 node7:/var/local/osd2
ceph-deploy osd activate node5:/var/local/osd0 node6:/var/local/osd1 node7:/var/local/osd2

#### Copying keyrings
ceph-deploy admin node4 node5 node6 node7
sudo chmod +r /etc/ceph/ceph.client.admin.keyring
