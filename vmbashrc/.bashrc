## Prompt and common commands
export PS1="\e[0;31m\u@\h \w: \e[m"
export PATH="/usr/local/go/bin:$PATH"

#alias ls="ls -F --color"
alias ls="ls -G"
alias ll="ls -lart"
alias vi="vim"
alias BRC="vim ~/.bashrc"
alias SBRC="source ~/.bashrc"

## Machine specific
alias GWD="cd ~/git/fsl-nfs-ganesha/"
alias SHD="cd /home/shivanshu/"
alias SQL="mysql -u root -p"
alias EC2="ssh -i ~/KurmaTest0.pem ec2-user@35.163.79.235"

## Cscope and Ctags
#alias CSCOPE_FILES="find . -iname \"*.c\" -o -iname \"*.cpp\" -o -iname \"*.cc\" -o -iname \"*.h\" -o -iname \"*.hpp\" > ~/cephscope/cscope.files"
#alias BCSCOPE="cd ~/cephscope/;cscope -b -q -k"
#alias BCTAGS="cd /root/gitcode/ceph/src/;ctags -R"

## Misc
alias koding="ssh shivanshu21@shivanshu21.koding.io"
alias FSL="ssh shivanshu@trex.fsl.cs.sunysb.edu"


#=============================================================
#VMware
alias dbuild="make clean-all build-all deploy-all test-all"
alias nimbus="ssh shivanshug@nimbus-gateway.eng.vmware.com"

#Local
#export ESX=192.168.213.129
#export VM1=
#export VM2=
alias LMAC16A="ssh root@192.168.213.142"
alias LMAC16B="ssh root@192.168.213.140"
alias LMAC16C="ssh root@192.168.213.141"

#nimbus
export ESX=10.161.225.207
export VM1=10.161.254.243
export VM2=10.161.238.197
export UM=10.161.246.175
alias ConnUM="ssh root@$UM"
#export VM3=

#Nirdesh
#export ESX=10.192.222.78
#export VM1=10.192.223.176
#export VM2=10.192.201.118


export GOVC_PASSWORD='ca$hc0w'
export DOCKER_HUB_REPO=shivanshug
export GOVC_INSECURE=1
export GOVC_URL=$ESX
export GOVC_USERNAME=root
export MANAGER1=$VM1
export WORKER1=$VM2
#export WORKER2=$VM3

#=============================================================

## Git stuff
export GIT_EDITOR="vim"

## Let ls and dir have good colors
#eval `dircolors -b ~/.dir_colors`

## HTTP proxy
#export http_proxy="10.140.221.232:3128"
#export https_proxy="10.140.221.232:3128"
#export no_proxy="localhost,127.0.0.1"

export PATH=$PATH:/root/bin
