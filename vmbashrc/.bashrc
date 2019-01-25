## Prompt and common commands
export PS1="\e[0;31m\u@\h \w: \e[m"
#eval `ssh-agent -s`
alias ls="ls -G"
alias ll="ls -lart"
alias vi="vim"


export M2_HOME=/Users/shigoswami/apache-maven-3.5.4
export PATH=$PATH:$M2_HOME/bin

## Machine specific
#alias GWD="cd /go/src/github.com/shivanshu21/docker-volume-vsphere"
#alias SHD="cd /home/shivanshu/"
#alias SQL="mysql -u root -p"
alias BRC="vim ~/.bashrc"
alias SBRC="source ~/.bashrc"
alias C3MAC="ssh shigoswami@10.149.255.51"
alias STAGENVOY="ssh shigoswami@10.169.161.18"
#alias RGW="cd ~/workspace;vagrant ssh rgw"
#alias SVM0="cd ~/workspace;vagrant ssh shiv0"
#alias SVM1="cd ~/workspace;vagrant ssh shiv1"
#alias EC2="ssh -i ~/KurmaTest0.pem ec2-user@35.163.79.235"

## Git stuff
#alias diffgit="git diff --cached"
#alias addgit="git add ."
export GIT_EDITOR="vim"

## Koding.com
#alias koding="ssh shivanshu21@shivanshu21.koding.io"

## Let ls and dir have good colors
#eval `dircolors -b ~/.dir_colors`

## HTTP proxy
#export http_proxy="10.140.221.232:3128"
#export https_proxy="10.140.221.232:3128"
#export no_proxy="localhost,127.0.0.1"

## Cscope and Ctags
#alias CSCOPE_FILES="find . -iname \"*.c\" -o -iname \"*.cpp\" -o -iname \"*.cc\" -o -iname \"*.h\" -o -iname \"*.hpp\" > ~/cephscope/cscope.files"
#alias BCSCOPE="cd ~/cephscope/;cscope -b -q -k"
#alias BCTAGS="cd /root/gitcode/ceph/src/;ctags -R"

#alias FSL="ssh shivanshu@trex.fsl.cs.sunysb.edu"

#======================================================
#alias dbuild="make clean-all build-all deploy-all test-all"
#alias nimbus="ssh shivanshug@nimbus-gateway.eng.vmware.com"

#Nimbus
#export ESX="10.161.225.207"
#export VM1="10.161.255.114"
#export VM2="10.161.231.219"

#export GOVC_PASSWORD='ca$hc0w'
#export DOCKER_HUB_REPO=shivanshug
#export GOVC_INSECURE=1
#export GOVC_URL=$ESX
#export GOVC_USERNAME=root
#export GOPATH="/go"

#export MANAGER1=$VM1
#export WORKER1=$VM2
#export WORKER2=$VM3

#======================================================
export PATH=$PATH:/root/bin

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/root/google-cloud-sdk/path.bash.inc' ]; then source '/root/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/root/google-cloud-sdk/completion.bash.inc' ]; then source '/root/google-cloud-sdk/completion.bash.inc'; fi
