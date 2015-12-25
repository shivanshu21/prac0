## Builds a CEPH cluster on four VMs
import pexpect
import os
import re
import sys

PASSWORD = 'vagrant'
TIMEOUT  = 10
ADMIN_NODE = 'node4'

#==================== FUNCTION DEFINITIONS ====================#
def genKey():
    child = pexpect.spawn('ssh-keygen')
    child.expect('Enter.*: ', TIMEOUT)
    child.sendline()
    ret = child.expect(['Enter passphrase.*: ', '.*Overwrite.*'], TIMEOUT)
    if ret == 0:
        child.sendline()
    elif ret == 1:
        child.sendline('y')
        child.expect('Enter passphrase.*: ')
        child.sendline()
    child.expect('Enter same passphrase.*: ', TIMEOUT)
    child.sendline()
    print child.before
    try:
        child.interact()
    except:
        print "Unexpected error during keypair generation"
    return 0

def copyKey(node):
    command_str = 'ssh-copy-id ' + node
    child = pexpect.spawn(command_str)
    ret = child.expect(['Are you sure.*', '.*password: '], TIMEOUT)
    if ret == 0:
        child.sendline('yes')
        child.expect('.*password: ',TIMEOUT)
        child.sendline(PASSWORD)
    elif ret == 1:
        child.sendline(PASSWORD)
    else:
        print "Unexpected prompt during copying keys"
    print child.before
    try:
        child.interact()
    except:
        print "Unexpected error has occured during copying keys"
    return 0

#==================== PROGRAM FLOW ====================#

## Check whether this is the admin node
command = 'cat /etc/hostname'
ret = os.popen(command).read()
pattern = re.compile(ADMIN_NODE)
if pattern.match(ret):
    print "This is the admin node. Continuing..."
else:
    print "This is not the admin node. Cannot continue with CEPH installation here!"
    sys.exit(0)

## Start CEPH deployment
print "\n\n== Starting CEPH deployment =="
os.chdir('/home/vagrant')
print "Adding keys..."
command = "wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -"
os.system(command)
print "Adding the Ceph packages to your repository..."
command = "echo deb http://download.ceph.com/debian-hammer/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list"
os.system(command)
print "Installing CEPH deploy..."
command = "sudo apt-get -y update && sudo apt-get -y install ceph-deploy"
os.system(command)
command = "sudo apt-get -y install ntp"
os.system(command)

## Generate SSH keys and push admin's ssh keys on other nodes
print "\n\n== Generating keypair and copying  =="
genKey()
copyKey('node5')
copyKey('node6')
copyKey('node7')

## Run the ceph deploy script
print "\n\n== Running CEPH deploy =="
command = 'mkdir ceph_cluster'
os.system(command)
os.chdir('/home/vagrant/ceph_cluster')

#### Initiate a cluster and get proper ceph.conf
command = 'ceph-deploy new node4'
os.system(command)
command = 'sudo cp /vagrant/ceph.conf .'
os.system(command)
command = 'sudo chmod 0755 ./ceph.conf'
os.system(command)

'''
#### Start installation of ceph binaries
command = 'ceph-deploy install node4 node5 node6 node7'
os.system(command)

#### ST MON leader makes first mon to come up
command = 'ceph-deploy mon create-initial'
os.system(command)

#### Create directories on which to run OSDs
command = 'ssh node5 \"sudo mkdir /var/local/osd0\"'
os.system(command)
command = 'ssh node6 \"sudo mkdir /var/local/osd1\"'
os.system(command)
command = 'ssh node7 \"sudo mkdir /var/local/osd2\"'
os.system(command)
command = 'ceph-deploy osd prepare node5:/var/local/osd0 node6:/var/local/osd1 node7:/var/local/osd2'
os.system(command)
command = 'ceph-deploy osd activate node5:/var/local/osd0 node6:/var/local/osd1 node7:/var/local/osd2'
os.system(command)

#### Copying keyrings
command = 'ceph-deploy admin node4 node5 node6 node7'
os.system(command)
command = 'sudo chmod +r /etc/ceph/ceph.client.admin.keyring'
os.system(command)
'''
